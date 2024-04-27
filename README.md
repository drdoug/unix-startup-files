# unix-startup-files
Here are some common files used when logging into a UNIX-based system such as MacOS, Linux or others.
It includes support for **zsh**, **bash**, and various flavours of **vim** (**gvim**, **macvim**, **neovim**, etc.)

A small bash script named ***update-startup-files.sh*** will check if the installed files are in sync with these.
A '-d' option displays differences, and the '-F' option will prompt the user to copy the file into place, and do so after confirmation.
The '-C' option create required subdirectories if they don't exist.

For **bash** support, *~/.bash_profile* is included, along with several supporting files located within *~/.config/shells*.
For **zsh**, a *~/.zshenv* file is included along with other **zsh** related files that reside within the *~/.config/shells* directory.
**Vim** related files are placed within the *~/.vim* directory.
