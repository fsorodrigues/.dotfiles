import { Plugin } from "@opencode/plugin/tui";

export default Plugin.define({
  id: "custom.close.tab",
  setup(context) {
    context.keymap.layer(() => ({
      mode: "global",
      commands: [
        {
          id: "custom.close.tab",
          title: "Close current tab",
          slash: { name: "close" },
          run: () => context.ui.tabs.close(),
        },
      ],
    }));
  },
});
