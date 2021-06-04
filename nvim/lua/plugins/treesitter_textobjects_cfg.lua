require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        -- FIXME: can only select one line at present(2021-06-04),
        --        how to select the comment block?
        ["ac"] = "@comment.outer",

        -- Or you can define your own textobjects like this
        -- ["ac"] = {
        --   python = "(comment)+ @comment",
        --   c = "(comment)+ @comment",
        --   cpp = "(comment)+ @commentttt",
        -- },
      },
    },
  },
}
