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
          cwd = "~/.dotfiles",
          hidden = true,
      })
end

M.fuzzy_project_search = function()
  require("telescope.builtin").live_grep({
          prompt_title = "< Project Find >",
          hidden = true,
          cwd = "./"
      })
end

local function dirLookup(dir)
   local p = io.popen('find ' .. dir .. ' -maxdepth 1 -type d')  --Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all files.     
   -- local p = io.popen('find "'..dir..'" -maxdepth 1 -type d')  --Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all files.     
   local t = {}
   local i = 0
   for file in p:lines() do                         --Loop through all files
      i = i + 1
      t[i] = file
   end
   p:close()
   return t
end

M.mdf = function()
    local dir = "~/Documents/mdf"
	require("telescope.pickers").new({}, {
		prompt_title = "Mydatafactory Projects",
		finder = require("telescope.finders").new_table({
			results = dirLookup(dir),
		}),
		sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", function()
                local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
                vim.api.nvim_command("cd " .. content.value)
                require("telescope.actions").close(prompt_bufnr)
                require("telescope.builtin").find_files()
            end)
            return true
        end,
	}):find()
end

return M
