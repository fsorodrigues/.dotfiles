import type { Plugin } from "@opencode-ai/plugin"

const COPILOT_MODEL = "github-copilot/gpt-5.5"
const COPILOT_SMALL_MODEL = "github-copilot/gpt-5-mini"
const LOCAL_MODEL = "opencode-go/deepseek-v4-pro"
const LOCAL_SMALL_MODEL = "opencode/big-pickle"
type Config = Parameters<NonNullable<Plugin["config"]>>[0]

const AGENT_COLORS = {
  build: "primary",
  plan: "accent",
  review: "secondary",
} as const

const setAgent = (
  cfg: Config,
  name: keyof typeof AGENT_COLORS,
  model: string,
  temperature: number,
) => {
  cfg.agent ??= {}
  cfg.agent[name] = {
    ...cfg.agent[name],
    model,
    temperature,
    color: AGENT_COLORS[name],
  }
}

const setCopilotAgents = (cfg: Config) => {
  cfg.small_model = COPILOT_SMALL_MODEL
  setAgent(cfg, "build", COPILOT_MODEL, 0.3)
  setAgent(cfg, "plan", COPILOT_MODEL, 0.1)
}

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

      if (isWindows) {
        cfg.shell = "powershell"
        cfg.formatter = false
        setCopilotAgents(cfg)
        return
      }

      if (isWsl) {
        cfg.shell = "/bin/zsh"
        cfg.formatter = false
        setCopilotAgents(cfg)
        setAgent(cfg, "review", "github-copilot/claude-opus-4.6", 0.1)
        return
      }

      if (isMac) {
        cfg.small_model = LOCAL_SMALL_MODEL
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
        setAgent(cfg, "build", LOCAL_MODEL, 0.3)
        setAgent(cfg, "plan", LOCAL_MODEL, 0.1)
        setAgent(cfg, "review", LOCAL_MODEL, 0.1)
      }
    },
  }
}) satisfies Plugin
