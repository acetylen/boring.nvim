
local colorscheme = {}

local keys = {"ctermfg", "ctermbg", "cterm", "guisp", "guifg", "guibg", "gui"}

-- Allow us to nicely combine style elements
debug.getmetatable("").__add = function(op1, op2) return op1 .. "," .. op2 end

local dark = {
  black   = "0",
  red     = "1",
  green   = "2",
  yellow  = "3",
  blue    = "4",
  magenta = "5",
  cyan    = "6",
  white   = "7",
}

local bright = {
  black   = "8",
  red     = "9",
  green   = "10",
  yellow  = "11",
  blue    = "12",
  magenta = "13",
  cyan    = "14",
  white   = "15",
}

local style = {
  none          = "NONE",
  bold          = "bold",
  underline     = "underline",
  undercurl     = "undercurl",
  strikethrough = "strikethrough",
  inverse       = "inverse",
  italic        = "italic",
  standout      = "standout",
}

--- Theme setup
vim.cmd 'highlight clear'
vim.cmd 'syntax reset'

local function hl(group, args)
  local str = "highlight " .. group .. " "
  for _, key in ipairs(keys) do
    str = str .. key .. "=" .. (args[key] or "NONE") .. " "
  end
  vim.cmd(str)
end

local function link(item, base)
  vim.cmd("highlight! link " .. item .. " " .. base)
end

local function linkall(items, base)
  for _, item in ipairs(items) do
    link(item, base)
  end
end

-- color element definitions
local value = dark.cyan
local accent = dark.white


--- Standard syntax highlighting
hl("Normal", {})
link("Cursor", "Identifier")
linkall({"Identifier", "Type", "Special", "VertSplit", "PreProc"}, "Normal")
linkall({"StorageClass", "Structure", "Typedef"}, "Type")
linkall({"SpecialChar", "Tag", "Delimiter", "SpecialComment", "Debug"}, "Special")
linkall({"Define", "Macro", "Precondit"}, "Preproc")

hl("Noise", {ctermfg=bright.black})
linkall({"Operator", "LineNr"}, "Noise")
linkall({"CursorLineNr", "FoldColumn", "SignColumn"}, "LineNr")

hl("Comment", {ctermfg=bright.black, cterm=style.italic})

hl("Constant", {ctermfg=value})
linkall({"Character", "Number", "Boolean", "Float", "String", "Directory", "Title"}, "Constant")

hl("Statement", {cterm=style.bold})
linkall({"Include", "Conditional", "Repeat", "Label", "Keyword", "Exception"}, "Statement")

hl("Underlined", {cterm=style.underline})

hl("ExtraWhitespace", {ctermbg=dark.red})

hl("ErrorMsg", {ctermbg=dark.red})
linkall({"Error", "Question"}, "Error")

hl("WarningMsg", {ctermbg=bright.yellow})
hl("InfoMsg", {ctermfg=dark.magenta, cterm=style.bold})
hl("MoreMsg", {ctermfg=bright.black, cterm=style.bold})
link("ModeMsg", "MoreMsg")

hl("NonText", {ctermfg=bright.black})
linkall({"Folded", "qfLineNr"}, "NonText")

hl("Visual", {ctermbg=bright.blue})
hl("VisualNOS", {ctermbg=dark.white})
hl("Ignore", {})

hl("DiffAdd", {ctermfg=dark.green})
hl("DiffDelete", {ctermfg=dark.red})
hl("DiffChange", {ctermfg=dark.yellow})
hl("DiffText", {ctermfg=dark.cyan})

hl("SpellBad",   {cterm=style.bold, ctermfg=dark.red})
hl("SpellCap",   {cterm=style.bold, ctermfg=dark.green})
hl("SpellRare",  {cterm=style.bold, ctermfg=dark.red})
hl("SpellLocal", {cterm=style.bold, ctermfg=dark.green})

link("helpHyperTextEntry", "Title")
link("helpHyperTextJump", "String")

hl("StatusLine", {cterm=style.bold + style.underline})
hl("StatusLineNC", {cterm=style.bold + style.underline, ctermfg=bright.black})
hl("StatusLineOk", {cterm=style.bold + style.underline, ctermfg=bright.green})
hl("StatusLineError", {cterm=style.bold + style.underline, ctermfg=bright.red})
hl("StatusLineWarning", {cterm=style.bold + style.underline, ctermfg=bright.yellow})

hl("WildMenu", {cterm=style.bold + style.underline})

hl("Pmenu", {ctermbg=accent})
linkall({"PmenuSbar", "PmenuThumb"}, "Pmenu")
hl("PmenuSel", {ctermbg=accent, cterm=style.bold})

linkall({"TabLine", "TabLineFill"}, "Normal")
link("TabLineSel", "Keyword")

hl("CursorLine", {ctermbg=accent})
hl("ColorColumn", {ctermbg=accent})

hl("MatchParen", {ctermbg=bright.yellow, ctermfg=dark.black})

linkall({"htmlH1","htmlH2","htmlH3","htmlH4","htmlH5","htmlH6"}, "Normal")

link("diffRemoved", "DiffDelete")
link("diffAdded", "DiffAdd")

-- lifted wholesale from vim-colors-plain
link("SignifySignAdd", "LineNr")
link("SignifySignDelete", "LineNr")
link("SignifySignChange", "LineNr")
link("GitGutterAdd", "LineNr")
link("GitGutterDelete", "LineNr")
link("GitGutterChange", "LineNr")
link("GitGutterChangeDelete", "LineNr")

link("jsFlowTypeKeyword", "Statement")
link("jsFlowImportType", "Statement")
link("jsFunction", "Statement")
link("jsGlobalObjects", "Normal")
link("jsGlobalNodeObjects", "Normal")
link("jsArrowFunction", "Noise")
link("StorageClass", "Statement")

link("xmlTag", "Constant")
link("xmlTagName", "xmlTag")
link("xmlEndTag", "xmlTag")
link("xmlAttrib", "xmlTag")

link("markdownH1", "Statement")
link("markdownH2", "Statement")
link("markdownH3", "Statement")
link("markdownH4", "Statement")
link("markdownH5", "Statement")
link("markdownH6", "Statement")
link("markdownListMarker", "Constant")
link("markdownCode", "Constant")
link("markdownCodeBlock", "Constant")
link("markdownCodeDelimiter", "Constant")
link("markdownHeadingDelimiter", "Constant")

link("yamlBlockMappingKey", "Statement")
link("pythonOperator", "Statement")

link("ALEWarning", "WarningMsg")
link("ALEWarningSign", "WarningMsg")
link("ALEError", "ErrorMsg")
link("ALEErrorSign", "ErrorMsg")
link("ALEInfo", "InfoMsg")
link("ALEInfoSign", "InfoMsg")

link("sqlStatement", "Statement")
link("sqlKeyword", "Keyword")

link("wikiHeader1", "Statement")
link("wikiHeader2", "Statement")
link("wikiHeader3", "Statement")
link("wikiHeader4", "Statement")
link("wikiHeader5", "Statement")
link("wikiHeader6", "Statement")
link("wikiList", "Statement")
link("wikiPre", "Constant")
link("wikiCode", "Constant")

link("tsxTag", "Constant")
link("tsxTagName", "Constant")
link("tsxCloseTagName", "Constant")
link("tsxAttrib", "Constant")

return colorscheme
-- --- Vim editor colors
-- hi('Bold', '', '', '', '', 'bold', '')
-- hi('IncSearch', gui01, gui09, cterm01, cterm09, 'none', '')
-- hi('Italic', '', '', '', '', 'none', '')
-- hi('Search', gui01, gui0A, cterm01, cterm0A, '', '')
-- hi('Substitute', gui01, gui0A, cterm01, cterm0A, 'none', '')
-- hi('SpecialKey', gui03, '', cterm03, '', '', '')
-- hi('TooLong', gui08, '', cterm08, '', '', '')
-- hi('CursorColumn', '', gui01, '', cterm01, 'none', '')
-- hi('QuickFixLine', '', gui01, '', cterm01, 'none', '')

-- --- C highlighting
-- hi('cOperator', gui0C, '', cterm0C, '', '', '')
-- hi('cPreCondit', gui0E, '', cterm0E, '', '', '')

-- --- C# highlighting
-- hi('csClass', gui0A, '', cterm0A, '', '', '')
-- hi('csAttribute', gui0A, '', cterm0A, '', '', '')
-- hi('csModifier', gui0E, '', cterm0E, '', '', '')
-- hi('csType', gui08, '', cterm08, '', '', '')
-- hi('csUnspecifiedStatement', gui0D, '', cterm0D, '', '', '')
-- hi('csContextualStatement', gui0E, '', cterm0E, '', '', '')
-- hi('csNewDecleration', gui08, '', cterm08, '', '', '')

-- --- CSS highlighting
-- hi('cssBraces', gui05, '', cterm05, '', '', '')
-- hi('cssClassName', gui0E, '', cterm0E, '', '', '')
-- hi('cssColor', gui0C, '', cterm0C, '', '', '')

-- --- Diff highlighting
-- hi('DiffAdd', gui0B, gui01, cterm0B, cterm01, '', '')
-- hi('DiffChange', gui03, gui01, cterm03, cterm01, '', '')
-- hi('DiffDelocale', gui08, gui01, cterm08, cterm01, '', '')
-- hi('DiffText', gui0D, gui01, cterm0D, cterm01, '', '')
-- hi('DiffAdded', gui0B, gui00, cterm0B, cterm00, '', '')
-- hi('DiffFile', gui08, gui00, cterm08, cterm00, '', '')
-- hi('DiffNewFile', gui0B, gui00, cterm0B, cterm00, '', '')
-- hi('DiffLine', gui0D, gui00, cterm0D, cterm00, '', '')
-- hi('DiffRemoved', gui08, gui00, cterm08, cterm00, '', '')

-- --- Git highlighting
-- hi('gitcommitOverflow', gui08, '', cterm08, '', '', '')
-- hi('gitcommitSummary', gui0B, '', cterm0B, '', '', '')
-- hi('gitcommitComment', gui03, '', cterm03, '', '', '')
-- hi('gitcommitUntracked', gui03, '', cterm03, '', '', '')
-- hi('gitcommitDiscarded', gui03, '', cterm03, '', '', '')
-- hi('gitcommitSelected', gui03, '', cterm03, '', '', '')
-- hi('gitcommitHeader', gui0E, '', cterm0E, '', '', '')
-- hi('gitcommitSelectedType', gui0D, '', cterm0D, '', '', '')
-- hi('gitcommitUnmergedType', gui0D, '', cterm0D, '', '', '')
-- hi('gitcommitDiscardedType', gui0D, '', cterm0D, '', '', '')
-- hi('gitcommitBranch', gui09, '', cterm09, '', 'bold', '')
-- hi('gitcommitUntrackedFile', gui0A, '', cterm0A, '', '', '')
-- hi('gitcommitUnmergedFile', gui08, '', cterm08, '', 'bold', '')
-- hi('gitcommitDiscardedFile', gui08, '', cterm08, '', 'bold', '')
-- hi('gitcommitSelectedFile', gui0B, '', cterm0B, '', 'bold', '')

-- --- GitGutter highlighting
-- hi('GitGutterAdd', gui0B, gui01, cterm0B, cterm01, '', '')
-- hi('GitGutterChange', gui0D, gui01, cterm0D, cterm01, '', '')
-- hi('GitGutterDelocale', gui08, gui01, cterm08, cterm01, '', '')
-- hi('GitGutterChangeDelocale', gui0E, gui01, cterm0E, cterm01, '', '')

-- --- HTML highlighting
-- hi('htmlBold', gui0A, '', cterm0A, '', '', '')
-- hi('htmlItalic', gui0E, '', cterm0E, '', '', '')
-- hi('htmlEndTag', gui05, '', cterm05, '', '', '')
-- hi('htmlTag', gui05, '', cterm05, '', '', '')

-- --- JavaScript highlighting
-- hi('javaScript', gui05, '', cterm05, '', '', '')
-- hi('javaScriptBraces', gui05, '', cterm05, '', '', '')
-- hi('javaScriptNumber', gui09, '', cterm09, '', '', '')

-- --- pangloss/vim-javascript highlighting
-- hi('jsOperator', gui0D, '', cterm0D, '', '', '')
-- hi('jsStatement', gui0E, '', cterm0E, '', '', '')
-- hi('jsReturn', gui0E, '', cterm0E, '', '', '')
-- hi('jsThis', gui08, '', cterm08, '', '', '')
-- hi('jsClassDefinition', gui0A, '', cterm0A, '', '', '')
-- hi('jsFunction', gui0E, '', cterm0E, '', '', '')
-- hi('jsFuncName', gui0D, '', cterm0D, '', '', '')
-- hi('jsFuncCall', gui0D, '', cterm0D, '', '', '')
-- hi('jsClassFuncName', gui0D, '', cterm0D, '', '', '')
-- hi('jsClassMethodType', gui0E, '', cterm0E, '', '', '')
-- hi('jsRegexpString', gui0C, '', cterm0C, '', '', '')
-- hi('jsGlobalObjects', gui0A, '', cterm0A, '', '', '')
-- hi('jsGlobalNodeObjects', gui0A, '', cterm0A, '', '', '')
-- hi('jsExceptions', gui0A, '', cterm0A, '', '', '')
-- hi('jsBuiltins', gui0A, '', cterm0A, '', '', '')

-- --- Mail highlighting
-- hi('mailQuoted1', gui0A, '', cterm0A, '', '', '')
-- hi('mailQuoted2', gui0B, '', cterm0B, '', '', '')
-- hi('mailQuoted3', gui0E, '', cterm0E, '', '', '')
-- hi('mailQuoted4', gui0C, '', cterm0C, '', '', '')
-- hi('mailQuoted5', gui0D, '', cterm0D, '', '', '')
-- hi('mailQuoted6', gui0A, '', cterm0A, '', '', '')
-- hi('mailURL', gui0D, '', cterm0D, '', '', '')
-- hi('mailEmail', gui0D, '', cterm0D, '', '', '')

-- --- Markdown highlighting
-- hi('markdownCode', gui0B, '', cterm0B, '', '', '')
-- hi('markdownError', gui05, gui00, cterm05, cterm00, '', '')
-- hi('markdownCodeBlock', gui0B, '', cterm0B, '', '', '')
-- hi('markdownHeadingDelimiter', gui0D, '', cterm0D, '', '', '')

-- --- NERDTree highlighting
-- hi('NERDTreeDirSlash', gui0D, '', cterm0D, '', '', '')
-- hi('NERDTreeExecFile', gui05, '', cterm05, '', '', '')

-- --- PHP highlighting
-- hi('phpMemberSelector', gui05, '', cterm05, '', '', '')
-- hi('phpComparison', gui05, '', cterm05, '', '', '')
-- hi('phpParent', gui05, '', cterm05, '', '', '')
-- hi('phpMethodsVar', gui0C, '', cterm0C, '', '', '')

-- --- Python highlighting
-- hi('pythonOperator', gui0E, '', cterm0E, '', '', '')
-- hi('pythonRepeat', gui0E, '', cterm0E, '', '', '')
-- hi('pythonInclude', gui0E, '', cterm0E, '', '', '')
-- hi('pythonStatement', gui0E, '', cterm0E, '', '', '')

-- --- Ruby highlighting
-- hi('rubyAttribute', gui0D, '', cterm0D, '', '', '')
-- hi('rubyConstant', gui0A, '', cterm0A, '', '', '')
-- hi('rubyInterpolationDelimiter', gui0F, '', cterm0F, '', '', '')
-- hi('rubyRegexp', gui0C, '', cterm0C, '', '', '')
-- hi('rubySymbol', gui0B, '', cterm0B, '', '', '')
-- hi('rubyStringDelimiter', gui0B, '', cterm0B, '', '', '')

-- --- SASS highlighting
-- hi('sassidChar', gui08, '', cterm08, '', '', '')
-- hi('sassClassChar', gui09, '', cterm09, '', '', '')
-- hi('sassInclude', gui0E, '', cterm0E, '', '', '')
-- hi('sassMixing', gui0E, '', cterm0E, '', '', '')
-- hi('sassMixinName', gui0D, '', cterm0D, '', '', '')

-- --- Signify highlighting
-- hi('SignifySignAdd', gui0B, gui01, cterm0B, cterm01, '', '')
-- hi('SignifySignChange', gui0D, gui01, cterm0D, cterm01, '', '')
-- hi('SignifySignDelocale', gui08, gui01, cterm08, cterm01, '', '')

-- --- Spelling highlighting
-- hi('SpellBad', '', '', '', '', 'undercurl', gui08)
-- hi('SpellLocal', '', '', '', '', 'undercurl', gui0C)
-- hi('SpellCap', '', '', '', '', 'undercurl', gui0D)
-- hi('SpellRare', '', '', '', '', 'undercurl', gui0E)

-- --- Startify highlighting
-- hi('StartifyBracket', gui03, '', cterm03, '', '', '')
-- hi('StartifyFile', gui07, '', cterm07, '', '', '')
-- hi('StartifyFooter', gui03, '', cterm03, '', '', '')
-- hi('StartifyHeader', gui0B, '', cterm0B, '', '', '')
-- hi('StartifyNumber', gui09, '', cterm09, '', '', '')
-- hi('StartifyPath', gui03, '', cterm03, '', '', '')
-- hi('StartifySection', gui0E, '', cterm0E, '', '', '')
-- hi('StartifySelect', gui0C, '', cterm0C, '', '', '')
-- hi('StartifySlash', gui03, '', cterm03, '', '', '')
-- hi('StartifySpecial', gui03, '', cterm03, '', '', '')

-- --- Java highlighting
-- hi('javaOperator', gui0D, '', cterm0D, '', '', '')

-- --- Treesitter highlighting
-- hi('TSFunction', gui0D, '', cterm0D, '', '', '')
-- hi('TSKeywordFunction', gui0E, '', cterm0E, '', '', '')
-- hi('TSMethod', gui0D, '', cterm0D, '', '', '')
-- hi('TSProperty', gui0A, '', cterm0A, '', '', '')
-- hi('TSPunctBracket', gui0C, '', cterm0C, '', '', '')
-- hi('TSType', gui08, '', cterm08, '', 'none', '')
-- hi('TSDefinition', '', gui03, '', cterm03, '', '')
-- hi('TSDefinitionUsage', '', gui02, '', cterm02, 'none', '')

-- --- LSP highlighting
-- hi('LspDiagnosticsDefaultError', gui08, '', cterm08, '', '', '')
-- hi('LspDiagnosticsDefaultWarning', gui09, '', cterm09, '', '', '')
-- hi('LspDiagnosticsDefaultInformation', gui05, '', cterm05, '', '', '')
-- hi('LspDiagnosticsDefaultHint', gui03, '', cterm03, '', '', '')

-- hi('LspDiagnosticsSignError', gui08, gui01, cterm08, '', '', '')
-- hi('LspDiagnosticsSignWarning', gui09, gui01, cterm09, '', '', '')
-- hi('LspDiagnosticsSignInformation', gui05, gui01, cterm05, '', '', '')
-- hi('LspDiagnosticsSignHint', gui03, gui01, cterm03, '', '', '')

