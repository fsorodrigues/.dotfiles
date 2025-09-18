local s = require("luasnip.nodes.snippet").S
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local c = require("luasnip.nodes.choiceNode").C
local fmta = require("luasnip.extras.fmt").fmta

return {
	-- ref
	s("ref", {
		t("{{ ref("),
		t("'"),
		i(1, "model_name", { key = "i1" }),
		t("'"),
		t(") }}"),
	}),
	-- config
	s("config", fmta([[{{ config( materialized = '<type>') }}]], { type = c(1, { t("table"), t("view") }) })),
	-- config_incremental
	s(
		"config_inc",
		fmta(
			[[
      {{
        config(
          materialized = 'incremental',
          unique_key = '<key>',
        )
      }}
    ]],
			{ key = i(1, "unique_key") }
		)
	),
	-- source
	s(
		"source",
		fmta([[{{ source('<schema>', '<table>') }}]], { schema = i(1, "schema_name"), table = i(2, "table_name") })
	),
}
