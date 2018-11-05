# VSCode Setup

These files need to be symlinked manually on each new VSCode installation.
That's because VSCode stores the configuration in `~/Library/Application\
Support/Code/User/` instead of the home directory.

Close VSCode, then do the following (replace with your actual host username!):

```
ln -s /Users/ryyppy/dotfiles/vscode/settings.json /Library/Application\
Support/Code/User/settings.json

ln -s /Users/ryyppy/dotfiles/vscode/keybindings.json /Library/Application\
Support/Code/User/keybindings.json

ln -s /Users/ryyppy/dotfiles/vscode/snippets/ /Library/Application\
Support/Code/User/snippets
```


**Inspiration:**

https://pawelgrzybek.com/sync-vscode-settings-and-snippets-via-dotfiles-on-github/
