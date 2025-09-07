-- Vue Language Server configuration
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', 'vue.config.js', '.git' },
  settings = {
    vue = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        autoImports = true,
      },
    },
  },
}
