" Search for files similar to the current one (ignoring the current file
" extensions in filenames like feed.component.spec.ts and also '-test' in
" 'game-test.js'). For example, you want to switch between html, css,
" javascript and files - or even spec and implementation in different
" directories. Note: This may pick up irrelevant files, but hopefully they
" should not appear at the bottom of the search results (where the most
" relevant ones are).

function! fzf_similar#find_similar_files()
  " Get rid of extensions
  let base_file_name = substitute(expand('%:t'), '\v([^\.]+)%(\..*|$)', '\1', '')
  " Get rid of -test and such
  let base_file_name = substitute(base_file_name, '\v\c%(-|_)%(test|spec)', '', '')

  let is_in_subdirectory = expand('%') =~ '/'
  if is_in_subdirectory
    " Include directory structure in search to improve the accuracy of search
    " results. Very useful in situations where you have files like
    " app/controllers/api/v4/foo_controller.rb with v4, v3, etc
    let simplified_directory = substitute(
          \   expand('%:h'),
          \   '\v(app|src|spec|test|__test__|__tests__)',
          \   '',
          \   'g'
          \ )
    let simplified_directory = substitute(simplified_directory, '//', '/', 'g')
    let simplified_directory = substitute(simplified_directory, '^/', '', 'g')
    " simplify_directory may not exactly match the actual directory of the file
    " you are looking for, but that is okay because fzf does a fuzzy search
    let main_search_term = simplified_directory . '/' . base_file_name
  else
    let main_search_term = "'" . base_file_name
  endif

  let query = '!^./' . expand('%') . "$\\ " . main_search_term
  let command = ':FZF --tiebreak=end,length -q ' . query
  execute command
endfunction
