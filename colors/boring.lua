
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
linkall({"FoldColumn", "SignColumn"}, "LineNr")


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

hl("NonText", {ctermfg=dark.white})
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
link("CursorLineNr", "CursorLine")

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
