-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps --
---------------------
-- Options for the keymaps (noremap is default in vim.keymap.set, but silent is useful)

-- Map 'jk' to <Esc> in Insert mode ('i')
vim.keymap.set("i", "jk", "<Esc>", { silent = true })

-- get default file explorer
keymap.set("n", "<leader>ex", "<CMD>Ex<CR>", { desc = "netrw file navigator" })
keymap.set("n", "<leader>sx", "<CMD>Ex<CR>", { desc = "netrw file navigator" })

-- reload current file
keymap.set(
  "n",
  "<leader>so",
  "<CMD>source<CR>",
  { desc = "Source current file" }
)

-- clear search highlights
keymap.set(
  "n",
  "<leader>nh",
  "<CMD>nohl<CR>",
  { desc = "Clear search highlights" }
)

-- keep pasting
keymap.set("x", "<leader>p", [["_dP]])

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set(
  "n",
  "<leader>sm",
  "<C-w>|",
  { desc = "Maximize the split width-wise" }
) -- make split the max width
keymap.set(
  "n",
  "<leader>sx",
  "<cmd>close<CR>",
  { desc = "Close current split" }
) -- close current split window

-- move lines
keymap.set("n", "<M-j>", ":m .+1<CR>==") -- <A-∆> move line up(n)
keymap.set("n", "<M-k>", ":m .-2<CR>==") -- <A-˚> move line down(n)
keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- remove arrow keys mappings
keymap.set("n", "<Up>", "")
keymap.set("n", "<Down>", "")
keymap.set("n", "<Left>", "")
keymap.set("n", "<Right>", "")

-- toggle display of whitespace characters (aka :set list / :set list!)
keymap.set("n", "<leader>ww", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle display of whitespace characters" })

-- lsp-related keymaps
keymap.set(
  "n",
  "gR",
  "<cmd>Telescope lsp_references<CR>",
  { desc = "Show LSP references" }
) -- show definition, references
keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }) -- go to declaration
keymap.set(
  "n",
  "gd",
  "<cmd>Telescope lsp_definitions<CR>",
  { desc = "Show LSP definitions" }
) -- show lsp definitions
keymap.set(
  "n",
  "gi",
  "<cmd>Telescope lsp_implementations<CR>",
  { desc = "Show LSP implementations" }
) -- show lsp implementations
keymap.set(
  "n",
  "gt",
  "<cmd>Telescope lsp_type_definitions<CR>",
  { desc = "Show LSP type definitions" }
) -- show lsp type definitions
keymap.set(
  { "n", "v" },
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = "See available code actions" }
) -- see available code actions, in visual mode will apply to selection
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" }) -- smart rename
keymap.set(
  "n",
  "<leader>D",
  "<cmd>Telescope diagnostics bufnr=0<CR>",
  { desc = "Show buffer diagnostics" }
) -- show  diagnostics for file
keymap.set(
  "n",
  "<leader>d",
  vim.diagnostic.open_float,
  { desc = "Show line diagnostics" }
) -- show diagnostics for line
keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous diagnostic" }
) -- jump to previous diagnostic in buffer
keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next diagnostic" }
) -- jump to next diagnostic in buffer
keymap.set(
  "n",
  "K",
  vim.lsp.buf.hover,
  { desc = "Show documentation for what is under cursor" }
) -- show documentation for what is under cursor
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary
