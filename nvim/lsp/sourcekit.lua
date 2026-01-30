-- Swift Language Server configuration
--
-- Goal: avoid background indexing. Prefer build settings coming from SwiftPM
-- (Package.swift). If you later adopt BSP (.bsp/buildServer.json), leaving
-- ".bsp" in root_markers makes it work without further config.
return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift" },
  root_markers = { "Package.swift", ".bsp", "*.xcodeproj", "*.xcworkspace", ".git" },
  settings = {
    sourcekit_lsp = {
      indexWhileBuilding = false,
      indexStoreEnable = false,
      backgroundIndexing = false,
    },
  },
}
