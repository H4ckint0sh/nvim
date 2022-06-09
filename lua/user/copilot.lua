local M = {};

function M:setup()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
        ['*'] = false,
        ['javascript'] = true,
        ['javascriptreact'] = true,
        ['typescript'] = true,
        ['typescriptreact'] = true,
        ['html'] = true,
        ['css'] = true,
        ['less'] = true,
        ['scss'] = true,
        ['lua'] = true,
        ['rust'] = true,
        ['c'] = true,
        ['c#'] = true,
        ['c++'] = true,
        ['go'] = true,
        ['python'] = true,
        ['markdown'] = true,
    }
    vim.api.nvim_set_keymap('i', '<leader>ac', 'copilot#Accept("")', { silent = true, expr = true })

end

return M;

