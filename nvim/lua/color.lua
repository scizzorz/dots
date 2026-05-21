vim.cmd([[
  syntax on
  syntax reset
  hi clear
]])
vim.opt.termguicolors = false

local hi = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

-- non-syntax things
hi('CursorColumn', {ctermbg=0})
hi('ColorColumn',  {ctermbg=0})
hi('CursorLine',   {})
hi('CursorLineNr', {ctermfg=6})
hi('WinSeparator', {ctermfg=0})

hi('SpellBad', {ctermfg=1, ctermbg=0})
hi('SpellCap', {ctermfg=3, ctermbg=0})

hi('MatchParen', {ctermfg=9})

hi('Visual', {ctermbg=0})

-- status line
hi('StatusLine',   {ctermfg=6, ctermbg=0})
hi('StatusLineNC', {ctermfg=7, ctermbg=0})

-- wild menu
hi('WildMenu', {ctermfg=14, ctermbg=0})

-- fold column
hi('Folded',     {ctermfg=8})
hi('FoldColumn', {ctermfg=7})

-- autocomplete menu
hi('Pmenu',      {ctermfg=7, ctermbg=0})
hi('PmenuSel',   {ctermfg=6, ctermbg=0})
hi('PmenuSbar',  {ctermfg=7, ctermbg=7})
hi('PmenuThumb', {ctermfg=8, ctermbg=8})

-- messages
hi('Error',      {ctermfg=1})
hi('ErrorMsg',   {ctermfg=1})
hi('ModeMsg',    {ctermfg=7})
hi('MoreMsg',    {ctermfg=7})
hi('WarningMsg', {ctermfg=1})

-- normal text
hi('Normal', {})

-- syntax formatting (line numbers, whitespace, etc.)
hi('LineNr',        {ctermfg=8})
hi('NonText',       {ctermfg=8})
hi('SpecialKey',    {ctermfg=8})
hi('WhitespaceEOL', {ctermfg=1})
hi('Search',        {ctermbg=0})
hi('IncSearch',     {ctermfg=1, ctermbg=0})
hi('SignColumn',    {})

-- syntax
hi('Error',      {ctermfg=1})
hi('Todo',       {ctermfg=11})
hi('Identifier', {ctermfg=12})
hi('Type',       {ctermfg=4})
hi('Constant',   {ctermfg=11})
hi('String',     {ctermfg=11})
hi('Number',     {ctermfg=10})
hi('Comment',    {ctermfg=5})
hi('Statement',  {ctermfg=6})
hi('PreProc',    {ctermfg=9})
hi('Special',    {ctermfg=14})
hi('Underlined', {ctermfg=15})
hi('Ignore',     {ctermfg=15})
hi('Operator',   {ctermfg=7})

-- diff
hi('DiffAdd',    {ctermfg=2, ctermbg=0})
hi('DiffChange', {ctermfg=3, ctermbg=0})
hi('DiffDelete', {ctermfg=1, ctermbg=0})
hi('DiffText',   {ctermfg=6, ctermbg=0})

-- diagnostics
hi('FloatBorder',          {ctermfg=0})
hi('DiagnosticError',       {})
hi('DiagnosticWarn',        {})
hi('DiagnosticInfo',        {})
hi('DiagnosticHint',        {})
hi('DiagnosticOk',          {})
hi('DiagnosticUnnecessary', {})

-- undercurl colors can't be specified with ANSI
hi('DiagnosticUnderlineError', {undercurl=true, sp='#ff6060'})
hi('DiagnosticUnderlineWarn',  {undercurl=true, sp='#ff9966'})
hi('DiagnosticUnderlineInfo',  {undercurl=true, sp='#f4cc00'})
hi('DiagnosticUnderlineHint',  {undercurl=true, sp='#b17aff'})
hi('DiagnosticUnderlineOk',    {undercurl=true, sp='#21c600'})

hi('DiagnosticSignError',       {ctermfg=1})
hi('DiagnosticSignWarn',        {ctermfg=11})
hi('DiagnosticSignInfo',        {ctermfg=3})
hi('DiagnosticSignHint',        {ctermfg=5})
hi('DiagnosticSignUnnecessary', {ctermfg=5})
hi('DiagnosticSignOk',          {ctermfg=2})

-- rust
hi('rustModPath',       {link='Identifier'})
hi('rustPubScope',      {link='Identifier'})
hi('rustPubScopeDelim', {link='Operator'})
hi('rustQuestionMark',  {link='Operator'})
hi('rustModPathSep',    {link='Operator'})
hi('rustSelf',          {link='Keyword'})
hi('rustSuper',         {link='Keyword'})
hi('rustEnumVariant',   {link='Special'})
hi('rustEscape',        {ctermfg=2})
hi('rustLifetime',      {link='rustEscape'})

-- python
hi('pythonInclude', {link='Keyword'})

-- html / markdown / rst
hi('htmlH1',       {ctermfg=6})
hi('Title',        {ctermfg=6})
hi('htmlLink',     {ctermfg=4})
hi('htmlBold',     {ctermfg=3})
hi('mkdDelimiter', {ctermfg=7})
hi('mkdCode',      {ctermfg=15, ctermbg=0})

hi('mkdCodeDelimiter',       {link='mkdDelimiter'})
hi('mkdListItem',            {link='mkdDelimiter'})
hi('mkdBold',                {link='mkdDelimiter'})
hi('mkdBoldItalic',          {link='mkdDelimiter'})
hi('mkdItalic',              {link='mkdDelimiter'})
hi('mkdHeading',             {link='mkdDelimiter'})
hi('rstEmphasis',            {link='htmlBold'})
hi('rstStrongEmphasis',      {link='htmlBold'})
hi('rstInlineLiteral',       {link='mkdCode'})
hi('rstLiteralBlock',        {link='mkdCode'})
hi('rstStandaloneHyperlink', {link='htmlLink'})
hi('rstFootnote',            {link='htmlLink'})
hi('rstCitation',            {link='htmlLink'})
hi('rstCitationReference',   {link='htmlLink'})
hi('rstDelimiter',           {link='mkdDelimiter'})

hi('htmlBoldUnderline',        {link='htmlBold'})
hi('htmlBoldItalic',           {link='htmlBold'})
hi('htmlBoldUnderlineItalic',  {link='htmlBold'})
hi('htmlBoldItalicUnderline',  {link='htmlBold'})
hi('htmlUnderlineBold',        {link='htmlBold'})
hi('htmlUnderlineItalic',      {link='htmlBold'})
hi('htmlUnderline',            {link='htmlBold'})
hi('htmlUnderlineBoldItalic',  {link='htmlBold'})
hi('htmlUnderlineItalicBold',  {link='htmlBold'})
hi('htmlItalicBold',           {link='htmlBold'})
hi('htmlItalicUnderline',      {link='htmlBold'})
hi('htmlItalic',               {link='htmlBold'})
hi('htmlItalicBoldUnderline',  {link='htmlBold'})
hi('htmlItalicUnderlineBold',  {link='htmlBold'})

vim.cmd('match WhitespaceEOL /\\s\\+$/')
