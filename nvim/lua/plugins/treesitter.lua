require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {  -- list of language that will be disabled
      "bash",     -- bash's highlight by treesitter is not that good at present(2021-06-02)
    },
  },
}
