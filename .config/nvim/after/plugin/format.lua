function setup_conform()
  require("conform").setup({
    formatters_by_ft = {
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
    },
  })

  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })
end

if not vim.g.vscode then
  setup_conform()
end
