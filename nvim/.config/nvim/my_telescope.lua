require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = " >",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,

    mappings = {
      i = {
        ["<c-a>"] = function() print("Hello world!") end
      }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        }
    }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
          prompt_title = "< dotfiles >",
          cwd = "~/dotfiles",
          hidden = true,
      })
end

M.search_mdf = function()
  require("telescope.builtin").file_browser({
          prompt_title = "< Mydatafactory >",
          cwd = "~/Documents/mdf/",
      })
end

return M
