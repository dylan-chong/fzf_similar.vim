# fzf_similar.vim

`fzf_similar.vim` is a simple plug in for finding files similar to the one you
are currently editing. This plugin uses a custom FZF query to find the similar
files, and present the list of results.

## Installation

Install this plugin using the plugin manager of your choice, for example with
[vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'dylan-chong/fzf_similar.vim'
```

**Note:** This plugin depends on
[fzf.vim](https://github.com/junegunn/fzf.vim#installation), so follow the
installation instructions for that plugin.

## Configuration

Add this (with the mapping of your choice) to your `.vimrc`:

```vim
nnoremap <silent> <Leader><C-f>1 :call fzf_similar#find_similar_files()<CR>
nnoremap <silent> <Leader><C-f>2 :call fzf_similar#find_similarly_named_files()<CR>
nnoremap <silent> <Leader><C-f>3 :call fzf_similar#find_files_in_the_same_directory()<CR>
```

## Function Documentation

### `fzf_similar#find_similar_files()`

Open and FZF window suggesting files that have a similar base name as the
current file and has a similarly named ancestor directories. This is the
function that is meant to be used most of the time. See the examples below:

#### Examples

In an Angular app, if you are editing `src/components/banner.component.ts`,
this plugin will suggest, `src/components/banner.component.spec.ts`,
`src/components/banner.html` and `src/components/banner.scss`.

In a Rails app, you are currently editing file `app/models/report.rb`, this
plugin will suggest the file `spec/models/report.rb`, while ignoring
`app/controllers/report.rb` and `spec/controllers/report.rb`.

### `fzf_similar#find_similarly_named_files()`

Same as `find_similar_files` but ignores filtering by similarly named ancestor
directories.

### `fzf_similar#find_files_in_the_same_directory()`

Finds files in the same directory as the current file.

## FAQ

### Why not use
[vim-projectionist](https://github.com/tpope/vim-projectionist)?

That plugin requires manual configuration to get it to work. This plugin works
for (most) projects out-of-the-box.

---

# TODO

- get preview window working
- tidy up the query that the user has to see?
- add multiple levels of specificity
    1. existing functionality
    1. searching of files for similar name, ie ignoring directory structure
    1. refactor api to take a map of options
    1. searching of files for similar name, ie ignoring directory structure,
       ignoring `_controller` and other suffixes
- right documentation
