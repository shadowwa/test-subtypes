-- Some outer files may get marked as "mason" type before this script is reached.
-- Vim's own scripts.vim forces the type if it detects a `<%` at the start of
-- the file. All files ending in .outer should be outer
vim.filetype.add({
    extension = {
        outer =
            function(path, bufnr)
                -- current test
                local root = vim.fn.fnamemodify(path, ':r')
                local matched = vim.filetype.match({ buf = bufnr, filename = root })
                -- subtype not detected in lua file, return nil so detection fallback
                -- on ftdetect/*.vim
                if matched == nil then
                    return nil
                elseif matched ~= 'mason' then
                    if vim.g.debug_test_subtype then
                        print('LUA matched subtype ' .. matched .. '.outer')
                    end
                    return matched .. '.outer'
                end
                if vim.g.debug_test_subtype then
                    print("LUA did't matched subtype")
                end
                if vim.g.outer_default_subtype ~= nil then
                    return vim.g.outer_default_subtype .. '.outer'
                else
                    return 'outer'
                end
            end,
    }
})
