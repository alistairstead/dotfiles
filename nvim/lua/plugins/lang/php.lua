return {

  -- add typescript to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'php', 'twig' })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.intelephense
        intelephense = {
          settings = {},
        },
      },
      setup = {
        intelephense = function(_, opts)
          require('typescript').setup({
            server = opts,
            init_options = {
              licenceKey = '/Users/alistairstead/Documents/intelephense.txt',
            },
          })
          return true
        end,
      },
    },
  },
}
