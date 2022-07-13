local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
	return
end

local item = require("neogen.types.template").item

local numpydoc_tweaked = {
	{ nil, '""" $1 """', { no_results = true, type = { "class", "func" } } },
	{ nil, '"""$1', { no_results = true, type = { "file" } } },
	{ nil, "", { no_results = true, type = { "file" } } },
	{ nil, "$1", { no_results = true, type = { "file" } } },
	{ nil, '"""', { no_results = true, type = { "file" } } },
	{ nil, "", { no_results = true, type = { "file" } } },

	{ nil, "# $1", { no_results = true, type = { "type" } } },

	{ nil, '"""$1' },
	{ item.HasParameter, "", { type = { "func" } } },
	{ item.HasParameter, "PARAMETERS", { type = { "func" } } },
	{ item.HasParameter, "----------", { type = { "func" } } },
	{
		item.Parameter,
		"%s : $1",
		{ after_each = "    $1", type = { "func" } },
	},
	{
		{ item.Parameter, item.Type },
		"%s : %s",
		{ after_each = "    $1", required = "typed_parameters", type = { "func" } },
	},
	{
		item.ArbitraryArgs,
		"%s",
		{ after_each = "    $1", type = { "func" } },
	},
	{
		item.Kwargs,
		"%s",
		{ after_each = "    $1", type = { "func" } },
	},
	{ item.ClassAttribute, "%s : $1", { before_first_item = { "", "Attributes", "----------" } } },
	{ item.HasReturn, "", { type = { "func" } } },
	{ item.HasReturn, "Returns", { type = { "func" } } },
	{ item.HasReturn, "-------", { type = { "func" } } },
	{
		item.ReturnTypeHint,
		"%s",
		{ after_each = "    $1" },
	},
	{
		item.Return,
		"$1",
		{ after_each = "    $1" },
	},
	{ nil, '"""' },
}

neogen.setup({
	-- Enables Neogen capabilities
	enabled = false,

	-- Go to annotation after insertion, and change to insert mode
	input_after_comment = true,

	-- Use a snippet engine to generate annotations.
	snippet_engine = "luasnip",

	-- Enables placeholders when inserting annotation
	enable_placeholders = true,

	-- Placeholders used during annotation expansion
	placeholders_text = {
		["description"] = "[TODO:description]",
		["tparam"] = "[TODO:tparam]",
		["parameter"] = "[TODO:parameter]",
		["return"] = "[TODO:return]",
		["class"] = "[TODO:class]",
		["throw"] = "[TODO:throw]",
		["varargs"] = "[TODO:varargs]",
		["type"] = "[TODO:type]",
		["attribute"] = "[TODO:attribute]",
		["args"] = "[TODO:args]",
		["kwargs"] = "[TODO:kwargs]",
	},

	-- Placeholders highlights to use. If you don't want custom highlight, pass "None"
	placeholders_hl = "DiagnosticHint",
	languages = {
		lua = {
			template = {
				annotation_convention = "emmylua", -- for a full list of annotation_conventions, see supported-languages below,
			},
		},
		python = {
			template = {
				annotation_convention = "numpydoc_tweaked",
				numpydoc_tweaked = numpydoc_tweaked,
			},
		},
	},
})

-- neogen.configuration.languages.python.template.add_custom_annotation({
-- 	name = "numpydoc_tweaked",
-- 	annotation = numpydoc_tweaked,
-- 	default = true,
-- })
