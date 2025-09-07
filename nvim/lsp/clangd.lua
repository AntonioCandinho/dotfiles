-- C/C++ Language Server configuration
return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { 
    '.clangd', 
    '.clang-tidy', 
    '.clang-format', 
    'compile_commands.json', 
    'compile_flags.txt', 
    'configure.ac', 
    '.git' 
  },
  cmd_env = {
    CLANGD_FLAGS = "--log=verbose",
  },
}
