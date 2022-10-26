local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
	return
end

local i = require("neogen.types.template").item

local numpydoc_tweaked = {
	{ nil, '"""$1"""', { no_results = true, type = { "class", "func" } } },
	{ nil, '"""$1', { no_results = true, type = { "file" } } },
	{ nil, "", { no_results = true, type = { "file" } } },
	{ nil, "$1", { no_results = true, type = { "file" } } },
	{ nil, '"""', { no_results = true, type = { "file" } } },
	{ nil, "", { no_results = true, type = { "file" } } },

	{ nil, "# $1", { no_results = true, type = { "type" } } },

	{ nil, '"""' },
	{ nil, "$1" },
	{ i.HasParameter, "", { type = { "func" } } },
	{ i.HasParameter, "Parameters/", { type = { "func" } } },
	{ i.HasParameter, "----------", { type = { "func" } } },
	{
		i.Parameter,
		"%s : $1",
		{ after_each = "    $1", type = { "func" } },
	},
	{
		{ i.Parameter, i.Type },
		"%s : %s",
		{ after_each = "    $1", required = "typed_parameters", type = { "func" } },
	},
	{
		{ i.Parameter, i.Type, i.DefaultValue },
		"%s : %s, optional",
		{ after_each = "    $1", required = "default_parameters", type = { "func" } },
	},
	{
		i.ArbitraryArgs,
		"%s :",
		{ after_each = "    $1", type = { "func" } },
	},
	{
		i.Kwargs,
		"%s :",
		{ after_each = "    $1", type = { "func" } },
	},
	{ i.ClassAttribute, "%s : $1", { before_first_item = { "", "Attributes", "----------" } } },
	{ i.HasReturn, "", { type = { "func" } } },
	{ i.HasReturn, "Returns", { type = { "func" } } },
	{ i.HasReturn, "-------", { type = { "func" } } },
	{
		i.ReturnTypeHint,
		"%s",
		{ after_each = "    $1" },
	},
	{
		i.Return,
		"$1",
		{ after_each = "    $1" },
	},
	{ nil, '"""' },
}

neogen.setup({
	-- Enables Neogen capabilities
	enabled = true,

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
		["kwargs"] = "[TODO:kwargs/]",
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
				-- numpydoc_tweaked = numpydoc_tweaked,
			},
		},
	},
})

-- local python_tpl = neogen.get_template("python")
-- python_tpl:add_custom_annotation("numpydoc_tweaked", numpydoc_tweaked, true)

-- local conf = require("neogen.config").get()
-- python_tpl:add_custom_annotation("numpydoc_tweaked", numpydoc_tweaked, true)
