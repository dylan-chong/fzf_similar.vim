# fzf-similar.vim

`fzf_similar.vim` is a simple plug in for finding files similar to the one you
are currently editing. This plugin uses a custom FZF query to find the similar
files, and present the list of results.

## Installation

Install this plugin using the plugin manager of your choice, for example with
[vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'dylan-chong/fzf_similar.vim'
```

**Note:** This plugin depends on
[fzf.vim](https://github.com/junegunn/fzf.vim#installation), so follow the
installation instructions for that plugin.

## Configuration

Add this (with the mapping of your choice) to your `.vimrc`:

```
nnoremap <silent> <Leader><C-f> :call fzf_similar#find_similar_files()<CR>
```

## FAQ

### Why not use
[vim-projectionist](https://github.com/tpope/vim-projectionist)?

That plugin requires manual configuration to get it to work. This plugin works
for (most) projects out-of-the-box.

# TODO

- get alternative specificities working
- right documentation
