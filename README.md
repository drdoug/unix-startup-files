# unix-startup-files
Here are some common files used when logging into a UNIX-based system such as MacOS, Linux or others.
It includes support for **zsh**, **bash**, and various flavours of **vim** (**gvim**, **macvim**, **neovim**, etc.)

A small bash script named ***update-startup-files.sh*** will check if the installed files are in sync with these.

* **-d** displays differences between the controlled files and what's in use for the account.
* **-F** prompt to copy the controlled files into place for this account after user confirmation.
* **-C** create required configuration subdirectories for the current user account if they don't exist.
* **-X** ask the user if they wish to ***overwrite*** the controlled ***master files*** with those ***files installed for the current user account***. **WARNING** this should only be used when the user changes their files for testing, with the intent to install those changes permanently in the repository. No commit or push is done, only the local controlled versions are changed. The user must do a commit afterwards, indicating the details of the change.

For **bash** support:

* *~/.bash_profile* is included, along with several supporting files located within *~/.config/shells*.

For **zsh** support:

* *~/.zshenv* file is included along with other **zsh** related files that reside within the *~/.config/shells* directory.

For **vim** and **neovim** support:

*  related files are placed within the *~/.config/vim* and *~/.config/nvim*  directories, respectively.
