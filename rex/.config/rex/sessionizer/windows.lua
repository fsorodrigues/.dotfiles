local M = {}

M.shell = "com.superlogical.terminal.shell"

function M.zsh(cwd)
  return {
    layout = rex.layout.block({
      flavor = M.shell,
      options = {
        command = { "zsh" },
        cwd = cwd,
      },
    }),
  }
end

function M.lazygit(cwd)
  return {
    layout = rex.layout.block({
      flavor = M.shell,
      options = {
        cwd = cwd,
        initial_input = "lazygit\n",
      },
    }),
  }
end

function M.picker(command)
  return {
    bounds = { 0.2, 0.15, 0.6, 0.7 },
    focus = true,
    layout = rex.layout.block({
      flavor = M.shell,
      options = {
        shell = "none",
        path_prepend = { "/usr/local/bin" },
        command = command,
        exit = {
          on_completion = true,
          quick_exit_threshold_ms = 0,
        },
      },
    }),
  }
end

return M
