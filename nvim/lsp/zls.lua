-- Zig Language Server configuration
return {
  cmd = { 'zls' },
  filetypes = { 'zig' },
  root_markers = { 'build.zig', 'build.zig.zon', '.git' },
}
