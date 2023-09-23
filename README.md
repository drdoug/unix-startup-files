# unix-startup-files
Here are some common files used when logging into a UNIX-based system such as MacOS, Linux or others.  It includes support for **zsh**, **bash**, **vim**, **gvim**, **macvim**.

A small bash script named *update-startup-files.sh* will see if the installed files are in sync with these.  A '-d' option displays differences, and the '-F' option will attempt to copy the file into place, after user confirmation.

For **bash** support, *~/.bashrc* is included, along with several supporting files.  For **zsh**, a *~/.zshenv* file is included which indicates all other **zsh** related files live within the *~/.zsh* directory.  **Vim** related files are placed within the *~/.vim* directory.
