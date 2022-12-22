local M = {}

function M.set_hi()
    local hl = function(group, opts)
        opts.default = true
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Misc {{{
    hl("@comment", { link = "Comment" })
    -- hl('@error', {link = 'Error'})
    hl("@none", { bg = "NONE", fg = "NONE" })
    hl("@preproc", { link = "PreProc" })
    hl("@define", { link = "Define" })
    hl("@operator", { link = "TSOperator" })
    -- }}}

    -- Punctuation {{{
    hl("@punctuation.delimiter", { link = "Delimiter" })
    hl("@punctuation.bracket", { link = "Delimiter" })
    hl("@punctuation.special", { link = "Delimiter" })
    -- }}}

    -- Literals {{{
    hl("@string", { link = "TSString" })
    hl("@string.regex", { link = "TSStringRegex" })
    hl("@string.escape", { link = "TSStringEscape" })
    hl("@string.special", { link = "SpecialChar" })

    hl("@character", { link = "TSCharacter" })
    hl("@character.special", { link = "SpecialChar" })

    hl("@boolean", { link = "TSBoolean" })
    hl("@number", { link = "TSNumber" })
    hl("@float", { link = "TSFloat" })
    -- }}}

    -- Functions {{{
    hl("@function", { link = "TSFunc" })
    hl("@function.call", { link = "Function" })
    hl("@function.builtin", { link = "TSFuncBuiltin" })
    hl("@function.macro", { link = "TSFuncMacro" })

    hl("@method", { link = "TSMethod" })
    hl("@method.call", { link = "Function" })

    hl("@constructor", { link = "TSConstructor" })
    hl("@parameter", { link = "TSParameter" })
    -- }}}

    -- Keywords {{{
    hl("@keyword", { link = "Keyword" })
    hl("@keyword.function", { link = "Keyword" })
    hl("@keyword.operator", { link = "Keyword" })
    hl("@keyword.return", { link = "Keyword" })

    hl("@conditional", { link = "Conditional" })
    hl("@repeat", { link = "Repeat" })
    hl("@debug", { link = "Debug" })
    hl("@label", { link = "Label" })
    hl("@include", { link = "Include" })
    hl("@exception", { link = "Exception" })
    -- }}}

    -- Types {{{
    hl("@type", { link = "Type" })
    hl("@type.builtin", { link = "Type" })
    hl("@type.qualifier", { link = "Type" })
    hl("@type.definition", { link = "Typedef" })

    hl("@storageclass", { link = "StorageClass" })
    hl("@attribute", { link = "PreProc" })
    hl("@field", { link = "Identifier" })
    hl("@property", { link = "Identifier" })
    -- }}}

    -- Identifiers {{{
    hl("@variable", { link = "TSVariable" })
    hl("@variable.builtin", { link = "TSVariableBuiltin" })

    hl("@constant", { link = "TSConstant" })
    hl("@constant.builtin", { link = "TSConstantBuiltin" })
    hl("@constant.macro", { link = "TSConstantMacro" })

    hl("@namespace", { link = "TSNamaspace" })
    hl("@symbol", { link = "Identifier" })
    -- }}}

    -- Text {{{
    hl("@text", { link = "TSText" })
    hl("@text.strong", { link = "TSStrong" })
    hl("@text.emphasis", { link = "TSEmphasis" })
    hl("@text.underline", { link = "TSUnderline" })
    hl("@text.strike", { strikethrough = true })
    hl("@text.title", { link = "TSTitle" })
    hl("@text.literal", { link = "TSLiteral" })
    hl("@text.uri", { link = "TSURI" })
    hl("@text.math", { link = "Special" })
    hl("@text.environment", { link = "Macro" })
    hl("@text.environment.name", { link = "Type" })
    hl("@text.reference", { link = "Constant" })

    hl("@text.todo", { link = "Todo" })
    hl("@text.note", { link = "SpecialComment" })
    hl("@text.warning", { link = "WarningMsg" })
    hl("@text.danger", { link = "ErrorMsg" })
    -- }}}

    -- Tags {{{
    hl("@tag", { link = "TSTag" })
    hl("@tag.attribute", { link = "TSAttribute" })
    hl("@tag.delimiter", { link = "Delimiter" })
    -- }}}
end

return M
