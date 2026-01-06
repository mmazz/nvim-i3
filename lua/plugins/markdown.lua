-- lua/plugins/markdown.lua
return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
}

