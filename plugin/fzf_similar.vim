" Search for files similar to the current one (ignoring the current file
" extensions in filenames like feed.component.spec.ts and also '-test' in
" 'game-test.js'). For example, you want to switch between html, css,
" javascript and files - or even spec and implementation in different
" directories. Note: This may pick up irrelevant files, but hopefully they
" should not appear at the bottom of the search results (where the most
" relevant ones are).

function! fzf_similar#find_similar_files()
  let base_file_name = s:get_base_file_name()

  let is_in_subdirectory = expand('%') =~ '/'
  if is_in_subdirectory
    " Include directory structure in search to improve the accuracy of search
    " results. Very useful in situations where you have files like
    " app/controllers/api/v4/foo_controller.rb with v4, v3, etc
    let simplified_directory = substitute(
          \   expand('%:h'),
          \   '\v(app|lib|main|src|spec|test|__test__|__tests__)',
          \   '',
          \   'g'
          \ )
    let simplified_directory = substitute(simplified_directory, '//', '/', 'g')
    let simplified_directory = substitute(simplified_directory, '^/', '', 'g')
    " simplify_directory may not exactly match the actual directory of the file
    " you are looking for, but that is okay because fzf does a fuzzy search
    call s:run_query(simplified_directory . '/' . base_file_name, 1)
  else
    call s:run_query(base_file_name, 1)
  endif
endfunction

function! fzf_similar#find_similarly_named_files()
  let base_file_name = s:get_base_file_name()

  let is_in_subdirectory = expand('%') =~ '/'
  if is_in_subdirectory
    call s:run_query("/" . base_file_name, 1)
  else
    call s:run_query(base_file_name, 1)
  endif
endfunction

function! fzf_similar#find_files_in_the_same_directory()
  let directory = expand('%:h')
  let file_name = expand('%:t:r')
  let extension = expand('%:e')

  call s:run_query("/" . directory . "\\ " . file_name . "\\ " . extension, 0)
endfunction

function! s:get_base_file_name()
  " Get rid of extensions (.rb, .spec.ts)
  let base_file_name = substitute(expand('%:t'), '\v([^\.]+)%(\..*|$)', '\1', '')
  " Get rid of -test and such
  let base_file_name = substitute(base_file_name, '\v\c%(-|_)%(test|spec)', '', '')
  return base_file_name
endfunction

function! s:run_query(query, include_ignore_current_file_query)
  let base_query = ':FZF --tiebreak=end,length'
  let ignore_current_file_query = '!^./' . expand('%') . '$'

  if a:include_ignore_current_file_query
    let command = base_query . ' -q ' . ignore_current_file_query . "\\ " . a:query
  else
    let command = base_query . ' -q ' . "\\ " . a:query
  endif
  execute command
endfunction
