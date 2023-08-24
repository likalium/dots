> All this notes are here to define some sorting criteria in my nvim plugins. It's not a strong opinion, it's just an attempt to never get lost into my plugin files. They can change.
- Tries to follow [rockerBOO/awesome-neovim](https://github.com/rockerBOO/awesome-neovim) categories
- Every telescope extension, even if listen in some category into awesome-neovim, goes into the `dependencies` of telescope, into `fuzzy_finder.lua`

Definition of a "telescope extension" (in this config): it's a plugin which uses the telescope command. So `neoclip` is a telescope extension, while `octo` isn't.

