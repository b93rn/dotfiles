local ls = require  "luasnip"
ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "-- this is what was expanded! --"),
  },
  lua = {},
}



-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })


