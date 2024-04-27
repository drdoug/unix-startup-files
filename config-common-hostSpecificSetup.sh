

COMPUTER_LOCAL_NAME=~/.config/PersonalComputersName

#
# Host specific setup file
# Common to bash and zsh
#

function _CommonSLACSettings
        {

        EPICS_VERSION="R7.0.3.1-1.0"
        PYTHON_VERSION="3.7.2"

        epicsDir="epics/base/${EPICS_VERSION}"

        #
        # if AFS and /usr/local both exist,
        # get EPICS from /usr/local.
        #
        if [[ -d "/usr/local/lcls/${epicsDir}" ]];
        then
                export EPICS_BASE=${EPICS_BASE:-"/usr/local/lcls/${epicsDir}"}
        fi

        if [[ -d "/afs/slac/g/lcls/${epicsDir}" ]];
        then
                export EPICS_BASE=${EPICS_BASE:-"/afs/slac/g/lcls/${epicsDir}"}
        fi
        unset epicsDir

        #
        # find the host architecture
        #
        if [[ -r ${EPICS_BASE}/startup/EpicsHostArch ]];
        then
                export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
        fi
 
        #
        # set up other local variables relating to
        # modules, extensions and the facility
        #
        EPICS_SETUP="${EPICS_BASE}/../../setup"
        if [[ -r ${EPICS_SETUP}/epicsenv-${EPICS_VERSION}.bash ]];
        then
                source ${EPICS_SETUP}/epicsenv-${EPICS_VERSION}.bash
        fi

        #
        # assume redhat 6 if HOST not set
        #
        export EPICS_HOST_ARCH=${EPICS_HOST_ARCH:-"rhel6-x86_64"}

        if ! type newlist &>/dev/null
        then
                printf "The newlist function is not available.  Functionality will be limited."
                return
        fi

        #
        # At this point, we know
        # path support is available
        #
        addpath -q ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}/

        #
        # if AFS and /usr/local both exist,
        # get Python from /usr/local.
        #
        if [[ -d "/usr/local/lcls/package" ]];
        then
                export PACKAGE_TOP=${PACKAGE_TOP-"/usr/local/lcls/package"}
                inspath -q $PACKAGE_TOP/anaconda/envs/python3_rhel7_env/bin
                inslib -q $PACKAGE_TOP/anaconda/envs/python3_rhel7_env/lib
                inslib -q $PACKAGE_TOP/anaconda/envs/python3_rhel7_env/lib/python3.7/lib-dynload
        fi

        if [[ -d "/afs/slac/g/lcls/package" ]];
        then
                export PACKAGE_TOP=${PACKAGE_TOP-"/afs/slac/g/lcls/package"}
                inspath -q $PACKAGE_TOP/python/python${PYTHON_VERSION}/linux-x86_64/bin
                inslib -q $PACKAGE_TOP/python/python${PYTHON_VERSION}/linux-x86_64/lib
                inslib -q $PACKAGE_TOP/python/python${PYTHON_VERSION}/linux-x86_64/lib/python3.7/lib-dynload

                #
                # HDF5 and net tools support
                #
                addpath -q /afs/slac/g/lcls/package/hdf5/1.10.8/$EPICS_HOST_ARCH/bin
                addpath -q /afs/slac/package/net/bin
        fi

        export GIT_ROOT=${GIT_ROOT-'/afs/slac/g/cd/swe/git/repos'}
        }

function hostSpecificSetup
        {

        #
        # Some DHCP servers like to assign dynamic
        # and cryptic names to override the assigned
        # local hostname.  If this is a "personal"
        # computer, indicated by the  existence of a
        # specific file, then just use the initial
        # name as supplied by the computer.
        #
        if [[ -r "$COMPUTER_LOCAL_NAME" ]];
        then
                SYSTEM_NAME=$(< $COMPUTER_LOCAL_NAME)
        else
                SYSTEM_NAME=$(hostname -s)
        fi

        if type shopt &>/dev/null
        then
                shopt -s extglob
        fi

        case "$SYSTEM_NAME" in
                "MurrayMacBookPro" | "DougM3" )
                        #
                        # Personal Laptop
                        #
                        if ! type newlist &>/dev/null
                        then
                                return
                        fi

                        inspath -q /opt/homebrew/bin
                        inspath -q /Users/dougm/Home/bin
                        inspath -q /Users/dougm/bin

                        #
                        # Support for Wine, Qt, Xcode, etc.
                        #
                        addpath -q /opt/usr/bin
                        addpath -q /opt/Qt/6.7.0/macos/bin
                        addpath -q /opt/Qt/6.4.0/macos/bin

                        addmaclib -q ~/Dropbox/src/lib
                        addman -q /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man

                        #
                        # check for local EPICS
                        #
                        export EPICS_BASE=${EPICS_BASE:-"/usr/local/epics/base"}
                        if [[ -d "${EPICS_BASE}" ]];
                        then
                                EPICS_SETUP=${EPICS_BASE}/config/epicsSetup.bash
                                if [[ -e $EPICS_SETUP ]];
                                then
                                        source $EPICS_SETUP
                                else
                                        export EPICS_HOST_ARCH=${EPICS_HOST_ARCH:-"darwin-x86"}
                                        addpath -q ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}/
                                fi
                        fi

                        #
                        # Support for OpenDDS
                        #
                        if [[ -d ~/Dropbox/OpenDDS ]];
                        then
                                export DANCE_ROOT=unused
                                export CIAO_ROOT=unused
                                export DDS_ROOT=~/Dropbox/OpenDDS/OpenDDS-3.12
                                export ACE_ROOT=~/Dropbox/OpenDDS/OpenDDS-3.12/ACE_wrappers
                                export TAO_ROOT=~/Dropbox/OpenDDS/OpenDDS-3.12/ACE_wrappers/TAO
                                export MPC_ROOT=~/Dropbox/OpenDDS/OpenDDS-3.12/ACE_wrappers/MPC
                                addmaclib -q ${DDS_ROOT}/lib
                                addpath -q ${DDS_ROOT}/bin
                                addmaclib -q ${ACE_ROOT}/lib
                                addpath -q ${ACE_ROOT}/bin
                        fi

                        #
                        # Support for RTI DDS
                        #
                        if [[ -d /Applications/rti_connext_dds-5.3.1 ]];
                        then
                                export NDDSHOME=/Applications/rti_connext_dds-5.3.1
                                addpath -q ${NDDSHOME}/bin
                                addlib -q ${NDDSHOME}/lib/x64Darwin17clang9.0/
                                addmaclib -q ${NDDSHOME}/lib/x64Darwin17clang9.0/
                        fi

                        ;;
                "PC102884" )
                        #
                        # SLAC MacBook Pro M2 2023
                        #
                        export EPICS_BASE=/usr/local/epics/epics-base
                        export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
                        inspath -q "${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"
                        inspath -q /opt/homebrew/bin

                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        ;;
                "pc99383" )
                        #
                        # Dell Desktop Machine Rocky Linux 9
                        #
                        _CommonSLACSettings
                        export EPICS_BASE=/usr/local/epics/base
                        if [[ -f ${EPICS_BASE}/startup/EpicsHostArch ]];
                        then
                                export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
                        fi
                        export EPICS_PVA_AUTO_ADDR_LIST=NO
                        inspath ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}
                        inslib ${EPICS_BASE}/lib/${EPICS_HOST_ARCH}
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        addca mcc-dmz
                        ;;
                "rhel6-64*" )
                        _CommonSLACSettings
                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        export EPICS_CA_AUTO_ADDR_LIST=NO
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        addca mcc-dmz
                        addca 134.79.219.255
                        addca 172.26.97.63
                        export EPICS_PVA_ADDR_LIST="$EPICS_CA_ADDR_LIST"
                        ;;
                sdfiana* )
                        export EPICS_BASE=/sdf/home/d/drm/src/epics/base
                        if [[ -r ${EPICS_BASE}/startup/EpicsHostArch ]];
                        then
                                export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
                        fi
                        inspath -q "${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"
                        addpath -q ~/.local/bin
                        umask 2
                        ;;
                nx* )
                        alias gtgray="gnome-terminal --profile='DougM Gray'"
                        alias gtgrey="gnome-terminal --profile='DougM Gray'"
                        alias gtblue="gnome-terminal --profile='DougM Blue'"
                        alias gtbrown="gnome-terminal --profile='DougM Brown'"
                        alias gtburg="gnome-terminal --profile='DougM Burgundy'"
                        alias gtgreen="gnome-terminal --profile='DougM Green'"
                        alias gtindigo="gnome-terminal --profile='DougM Indigo'"
                        alias gtteal="gnome-terminal --profile='DougM Teal'"
                        alias gt="gtgrey;gtblue;gtbrown;gtburg;gtgreen;gtindigo;gtteal"
                        ;;
                sdf* )
                        alias gtgray="gnome-terminal --profile='DougM Gray'"
                        alias gtgrey="gnome-terminal --profile='DougM Gray'"
                        alias gtblue="gnome-terminal --profile='DougM Blue'"
                        alias gtbrown="gnome-terminal --profile='DougM Brown'"
                        alias gtburg="gnome-terminal --profile='DougM Burgundy'"
                        alias gtgreen="gnome-terminal --profile='DougM Green'"
                        alias gtindigo="gnome-terminal --profile='DougM Indigo'"
                        alias gtteal="gnome-terminal --profile='DougM Teal'"
                        alias gt="gtgrey;gtblue;gtbrown;gtburg;gtgreen;gtindigo;gtteal"
                        export EPICS_BASE=/sdf/home/d/drm/src/epics/base
                        export EPICS_CA_ADDR_LIST="134.79.219.255 172.26.97.63"
                        export EPICS_PVA_ADDR_LIST="134.79.151.21"
                        export EPICS_PVA_BROADCAST_PORT=5169
                        export EPICS_PVA_AUTO_ADDR_LIST=NO
                        export EPICS_PVA_SERVER_PORT=5168
                        if [[ -r ${EPICS_BASE}/startup/EpicsHostArch ]];
                        then
                                export EPICS_HOST_ARCH=$(${EPICS_BASE}/startup/EpicsHostArch)
                        fi
                        inspath -q "${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"
                        umask 2
                        ;;
                "lcls-dev3" )
                        _CommonSLACSettings
                        export MATLAB_TOP=/u1/software/matlab
                        export MATLAB_VERSION=R2017b
                        inslib $MATLAB_TOP/$MATLAB_VERSION/bin/glnxa64
                        inslib $MATLAB_TOP/$MATLAB_VERSION/sys/os/glnxa64
                        export PATH=$MATLAB_TOP/$MATLAB_VERSION/bin:$PATH
                        #
                        # evil script sets prompt and other aliases. bad script.
                        #
                        _x="${PS1}"
                        source /afs/slac/g/lcls/tools/script/ENVS64.bash
                        PS1="${_x}"
                        unset _x
                        printf "The message above (%s) comes from ENVS64.bash and should be fixed.\n" "-bash: [: too many arguments"
                        #DM prompt green user @ Green host sp Gray2 time Orange Gitb sp White hist sp Red Ret White .
                        export PYEPICS_LIBCA=$EPICS_BASE_TOP/$EPICS_BASE_VER/lib/$EPICS_HOST_ARCH/libca.so
                        export PYEPICS_LIBCOM=$EPICS_BASE_TOP/$EPICS_BASE_VER/lib/$EPICS_HOST_ARCH/libCom.so
                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        addca mcc-dmz
                        addca 134.79.219.255
                        addca 172.26.97.63
                        ;;
                "aird-b50-srv01" )
                        _CommonSLACSettings
                        export EPICS_HOST_ARCH="rhel7-x86_64"
                        #
                        # DANGER: (bash only)
                        #         sourcing this wonderful script
                        #         twice will remove PATH, making
                        #         this current session unusable
                        #
                        # source /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash
                        #
                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        export JAVA_VERS=jdk-11.0.2
                        export JAVA_HOME=/afs/slac/g/lcls/package/java/$JAVA_VERS
                        export MAVEN_VERS=3.6.0
                        export MAVEN_HOME=/afs/slac/g/lcls/package/maven/$MAVEN_VERS
                        addpath -q ${JAVA_HOME}/bin
                        addpath -q ${MAVEN_HOME}/bin
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        addca mcc-dmz
                        addca 134.79.219.255
                        addca 172.26.97.63
                        addpath -q /afs/slac/g/lcls/epics/extensions/R1.1.1/bin/rhel7-x86_64
                        addpath -q /afs/slac/g/lcls/epics/extensions/pvxs/R1.2.2-0.1.0/bin/rhel7-x86_64
                        ;;
                "mccas0" )
                        _CommonSLACSettings
                        #
                        # HDF5 tools and BSAS-NC FileWriter monitoring
                        #
                        addpath /afs/slac/g/lcls/package/anaconda/envs/python3_rhel7_env/bin
                        addpath /afs/slac/g/lcls/package/bsasStore/current/bsasFileWriterMonitor
                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        addca lcls-daemon0
                        addca lcls-prod01:5068
                        addca lcls-prod01:5063
                        addca mcc-dmz
                        addca 134.79.219.255
                        addca 172.26.97.63
                        ;;
                "lcls-daemon0" )
                        _CommonSLACSettings

                        #
                        # production network, uid laci; need python path for iocConsole
                        #
                        newlist py PYTHONPATH -e
                        inspy /usr/local/lcls/epics/base/base-cpp-R4-6-0/pvaPy/lib/python/2.7/linux-x86
                        inspy /usr/local/lcls/tools/python/toolbox
                        inspy /usr/local/lcls/epics/base/base-cpp-R4-4-0/pvaPy/lib/linux-x86

                        #
                        # production network, uid laci; EPICS subnets
                        #
                        export EPICS_PVA_AUTO_ADDR_LIST=YES
                        addca 172.27.3.255:5068
                        addca mcc-dmz
                        addca 172.21.40.63:5064
                        addca 172.27.72.24:5070
                        addca 172.27.131.255:5068
                        addca 172.27.43.255:5068
                        ;;
                "testfac-srv01" )
                        _CommonSLACSettings
                        export ACCTEST_ROOT=/afs/slac/g/acctest
                        source /afs/slac/g/acctest/tools/script/ENVS_acctest.bash
                        ;;
                "testfac-camsrv01" )
                        _CommonSLACSettings
                        export ACCTEST_ROOT=/afs/slac/g/acctest
                        source /afs/slac/g/acctest/tools/script/ENVS_acctest.bash
                        ;;
                "testfac-camsrv02" )
                        _CommonSLACSettings
                        export ACCTEST_ROOT=/afs/slac/g/acctest
                        source /afs/slac/g/acctest/tools/script/ENVS_acctest.bash
                        ;;
                "testfac-asta-cs01" )
                        _CommonSLACSettings
                        export ACCTEST_ROOT=/afs/slac/g/acctest
                        source /afs/slac/g/acctest/tools/script/ENVS_acctest.bash
                        ;;
                "lcls-dev2" )
                        _CommonSLACSettings
                        source /afs/slac/g/lcls/tools/script/ENVS.bash
                        export JAVAVER=1.7.0_01
                        source /afs/slac/g/lcls/epics/setup/go_epics_3-14-12.bash
                        export JAVA_HOME=/afs/slac/g/lcls/package/java/jdk1.7.0_01
                        export PATH=$JAVA_HOME/bin:$PATH
                        export NETBEANS_HOME=/afs/slac/g/lcls/package/netbeans/netbeans-7.0.1
                        export PATH=$NETBEANS_HOME/bin:$PATH
                        export CSS_EPICS_VER=3.1.0
                        export CSS_EPICS_HOME=/afs/slac/g/lcls/package/CSS/CSS_EPICS_$CSS_EPICS_VER
                        export PATH=$CSS_EPICS_HOME:$PATH:/usr/afsws/bin
                        export PATH=$PACKAGE_TOP/python/current/bin:$PATH
                        inslib $PACKAGE_TOP/python/current/lib
                        inslib $PACKAGE_TOP/python/current/lib/python2.7/lib-dynload
                        ;;
                "aird-pc90626" )
                        _CommonSLACSettings
                        source /afs/slac/g/lcls/tools/script/ENVS64.bash
                        source /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash
                        export PACKAGE_TOP=/afs/slac/g/lcls/package
                        export PATH=$PACKAGE_TOP/python/python2.7.9/linux-x86_64/bin:$PATH
                        export PYEPICS_LIBCA=$EPICS_BASE_TOP/$EPICS_BASE_VER/lib/$EPICS_HOST_ARCH/libca.so
                        export PYEPICS_LIBCOM=$EPICS_BASE_TOP/$EPICS_BASE_VER/lib/$EPICS_HOST_ARCH/libCom.so
                        inslib $PACKAGE_TOP/python/python2.7.9/linux-x86_64/lib
                        inslib $PACKAGE_TOP/python/python2.7.9/linux-x86_64/lib/python2.7/lib-dynload
                        ;;
                "rdsrv300" )
                        _CommonSLACSettings
                        /usr/bin/aklog
                        /usr/bin/klist
                        /usr/bin/tokens
                        source /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash
                        ;;
                "rdsrv315" )
                        _CommonSLACSettings
                        /usr/bin/aklog
                        /usr/bin/klist
                        /usr/bin/tokens
                        ;;
                "rdsrv223" )
                        _CommonSLACSettings
                        source /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash
                        ;;
                *)
                        _CommonSLACSettings
                        if [[ -r /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash ]];
                        then
                                source /afs/slac/g/lcls/epics/setup/epicsenv-7.0.3.1-1.0.bash
                        fi
                        export JAVA_HOME=/afs/slac/g/lcls/package/java/jdk1.7.0_01
                        export PATH=$JAVA_HOME/bin:$PATH
                        export NETBEANS_HOME=/afs/slac/g/lcls/package/netbeans/netbeans-7.0.1
                        export PATH=$NETBEANS_HOME/bin:$PATH:/usr/afsws/bin
                        ;;
        esac
        }
