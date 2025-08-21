return {
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      mode = "virtualtext",
      virtualtext_inline = 'after',
    }
  },
  config = true,
}
