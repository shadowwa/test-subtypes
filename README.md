# vim subtype detection

epuppet files are templating files where a file can be any type of file with tags that will be replaced by puppet before creating the file on target system.

vim-puppet was original loading only *sh* syntax highlight, then setting the filetype as epuppet, that were load the *epuppet* highlight

in <https://github.com/rodjek/vim-puppet/pull/146>, I tried to add subtype detection for epuppet files allowing:

- syntax highlight of epuppet and of the true filetype as detected by vim (by extension, content or file path)
- setting the filetype to subtype.epuppet to allow various plugins as ALE of coc.nvim to recognise the original filetype and getting linting or autocompletion.

The resulting code had several problems:

- consistency: results were different depending on the users or in github workflows
- it did not provide any loop-breaking checks before launching doautocmd
- it was setting `filetype` from within the syntax file instead of the ftdetect file.

The detection was modified to only take account file extension.

I'm trying now to:

- [x] get github test run for several versions of (n)vim. OK
- [x] just setting the filetype as 'subtype.type' and letting vim loading ftplugins and syntax file for both type
- [x] setup the extension detection in ftdetect for file not already declared in vim (outer).
- [ ] setup the extension detection in ftdetect for file already declared in vim (puppet).
- [ ] setting up detection for extension, content or file path
- [ ] if possible, allows subtype detection for any kind of template files, not only puppet
