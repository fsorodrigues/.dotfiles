import { Model, Plugin, Provider } from "@opencode/plugin"

const COPILOT_MODEL = "github-copilot/gpt-5.6-sol"
const COPILOT_SMALL_MODEL = "github-copilot/gpt-5-mini"
const LOCAL_MODEL = "opencode-go/gpt-5.6-luna"
const LOCAL_SMALL_MODEL = "opencode/deepseek-v4-flash"

const AGENT_COLORS = {
  build: "#7aa2f7",
  plan: "#ff9e64",
  review: "#9d7cd8",
  explore: "#0db9d7",
  general: "#9ece6a",
  scout: "#e0af68",
} as const

const modelRef = (value: string) => {
  const separator = value.indexOf("/")
  return {
    providerID: Provider.ID.make(value.slice(0, separator)),
    id: Model.ID.make(value.slice(separator + 1)),
  }
}

export default Plugin.define({
  id: "environment-profile",
  async setup(ctx) {
    const isMac = process.platform === "darwin"
    const isWindows = process.platform === "win32"
    const isWsl = Boolean(
      process.env.WSL_DISTRO_NAME ||
        process.env.WSL_INTEROP ||
        process.env.WSLENV,
    )

    if (!isMac && !isWindows && !isWsl) return

    const model = isMac ? LOCAL_MODEL : COPILOT_MODEL
    const smallModel = isMac ? LOCAL_SMALL_MODEL : COPILOT_SMALL_MODEL
    const agentNames = ["build", "plan", "review", "explore", "general", "scout"] as const

    await ctx.agent.transform((editor) => {
      agentNames.forEach((name) => {
        editor.update(name, (agent) => {
          agent.model = modelRef(
            !isMac && name === "review"
              ? "github-copilot/gpt-6-astra"
              : model,
          )
          agent.color = AGENT_COLORS[name as keyof typeof AGENT_COLORS]
          if (name === "scout") {
            agent.hidden = false
            agent.mode = "subagent"
          }
        })
      })

      editor.update("title", (agent) => {
        agent.model = modelRef(smallModel)
      })
    })

    if (isWindows || isWsl) {
      await ctx.shell.hook("create.before", (event) => {
        event.shell = isWindows ? "powershell" : "/bin/zsh"
      })
    }

    if (isMac) {
      const providerID = Provider.ID.make("ollama")
      const models = [
        {
          ...Model.Info.default(providerID, Model.ID.make("gemma4:e4b-32k")),
          name: "Gemma4",
        },
        {
          ...Model.Info.default(providerID, Model.ID.make("qwen3.5:9b-64k")),
          name: "Qwen3.5",
        },
      ]

      await ctx.provider.transform((editor) => {
        editor.add({
          info: {
            ...Provider.Info.empty(providerID),
            name: "Ollama (local)",
            activation: "enabled",
            package: "aisdk:@ai-sdk/openai-compatible",
            settings: {
              baseURL: "http://ollama.lan.fsorodrigues.dev/v1",
            },
          },
          models,
        })
      })
    }
  },
})
