import type { Plugin } from "@opencode-ai/plugin"

export default (async () => {
  return {
    config: (cfg) => {
      const isMac = process.platform === "darwin"
      const isWindows = process.platform === "win32"
      const isWsl = Boolean(
        process.env.WSL_DISTRO_NAME ||
          process.env.WSL_INTEROP ||
          process.env.WSLENV,
      )

      cfg.agent ??= {}

      if (isWindows) {
        cfg.shell = "powershell"
        cfg.formatter = false
        cfg.small_model = "github-copilot/gpt-5-mini"
        cfg.agent.build = {
          ...cfg.agent.build,
          model: "github-copilot/gpt-5.5",
          temperature: 0.3,
        }
        cfg.agent.plan = {
          ...cfg.agent.plan,
          model: "github-copilot/gpt-5.5",
          temperature: 0.1,
        }
        return
      }

      if (isWsl) {
        cfg.shell = "/bin/zsh"
        cfg.formatter = false
        cfg.small_model = "github-copilot/gpt-5-mini"
        cfg.agent.build = {
          ...cfg.agent.build,
          model: "github-copilot/gpt-5.5",
          temperature: 0.3,
        }
        cfg.agent.plan = {
          ...cfg.agent.plan,
          model: "github-copilot/gpt-5.5",
          temperature: 0.1,
        }
        return
      }

      if (isMac) {
        cfg.small_model = "opencode/big-pickle"
        cfg.provider ??= {}
        cfg.provider.ollama = {
          npm: "@ai-sdk/openai-compatible",
          name: "Ollama (local)",
          options: {
            baseURL: "http://ollama.lan.fsorodrigues.dev/v1",
          },
          models: {
            "gemma4:e4b-32k": {
              name: "Gemma4",
            },
          },
        }
        cfg.agent.build = {
          ...cfg.agent.build,
          model: "opencode-go/deepseek-v4-pro",
          temperature: 0.3,
        }
        cfg.agent.plan = {
          ...cfg.agent.plan,
          model: "opencode-go/deepseek-v4-pro",
          temperature: 0.1,
        }
      }
    },
  }
}) satisfies Plugin
