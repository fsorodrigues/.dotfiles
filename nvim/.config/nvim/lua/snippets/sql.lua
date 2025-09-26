local s = require("luasnip.nodes.snippet").S
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local c = require("luasnip.nodes.choiceNode").C
local fmta = require("luasnip.extras.fmt").fmta
return {
  --[[------------------------------
      DBT SNIPPETS
  --------------------------------]]
  -- ref
  s({ trig = "ref", desc = "dbt ref block to reference a different model." }, {
    t("{{ ref("),
    t("'"),
    i(0, "model_name", { key = "i1" }),
    t("'"),
    t(") }}"),
  }),
  -- config
  s(
    {
      trig = "config",
      desc = "dbt config block to configure materialization. Allows for choice between table and",
    },
    fmta(
      [[{{ config( materialized = '<type>') }}]],
      { type = c(1, { t("table"), t("view") }) }
    )
  ),
  -- config_incremental
  s(
    {
      trig = "config_inc",
      desc = "dbt config block to configure incremental materialization.",
    },
    fmta(
      [[
      {{
        config(
          materialized = 'incremental',
          unique_key = '<key>',
        )
      }}
    ]],
      { key = i(0, "unique_key") }
    )
  ),
  -- source
  s(
    { trig = "source", desc = "dbt config block to reference a source table." },
    fmta(
      [[{{ source('<schema>', '<table>') }}]],
      { schema = i(1, "schema_name"), table = i(0, "table_name") }
    )
  ),
  -- for loop
  s(
    { trig = "for", desc = "jinja for loop block for arrays/sequences." },
    fmta(
      [[
      {% for <item> in <seq> %}
        <action>  
      {% endfor }
    ]],
      {
        item = i(1, "item"),
        seq = c(2, { i(1, "seq"), { t("[ "), i(1, "el"), t(" ]") } }),
        action = i(0, "action"),
      }
    )
  ),
  -- dict for loop
  s(
    { trig = "dict_for", desc = "jinja for loop block for arrays/sequences." },
    fmta(
      [[
      {% for <key>, <value> in <dict>.items() %}
        <action>  
      {% endfor }
    ]],
      {
        key = i(1, "item"),
        value = i(2, "seq"),
        dict = i(3, "dict"),
        action = i(0, "action"),
      }
    )
  ),
  s(
    { trig = "if", desc = "jinja for if blocks." },
    fmta(
      [[
      {% if <expr> %}
        <action>  
      {% endif }
    ]],
      {
        expr = i(1, "expr"),
        action = i(0, "action"),
      }
    )
  ),
  --[[------------------------------
      SQL SNIPPETS
  --------------------------------]]
  s(
    { trig = "sel", desc = "sql shorthand for SELECT *" },
    fmta(
      [[
      SELECT
        *
      FROM <table>
    ]],
      { table = i(0, "table") }
    )
  ),
}
