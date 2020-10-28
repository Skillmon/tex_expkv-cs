-- Build script for expkv-cs
module     = "expkv-cs"
pkgversion = "0.7"
pkgdate    = "2020-10-28"

-- update package date and version
tagfiles = {"expkv-cs.dtx", "README.md", "CTAN.md"}
function update_tag(file, content, tagname, tagdate)
  if tagname == nil then
    tagname = pkgversion
    tagdate = pkgdate
  end
  if string.match(file, "%.md") then
    return string.gsub(content,
      "%d%d%d%d%-%d%d%-%d%d v%d%.%d%w?",
      tagdate .. " v" .. tagname)
  elseif file == "expkv-cs.dtx" then
    content = string.gsub(content,
      "\\def\\ekvcDate{%d%d%d%d%-%d%d%-%d%d}",
      "\\def\\ekvcDate{" .. tagdate .. "}")
    return string.gsub(content,
      "\\def\\ekvcVersion{%d%.%d%w?}",
      "\\def\\ekvcVersion{" .. tagname .. "}")
  end
  return content
end

-- test with pdfTeX and the LaTeX format
checkengines = {"pdftex"}
checkformat  = "latex"

-- from which files to build
sourcefiles = {"expkv-cs.dtx"}
unpackfiles = sourcefiles

-- which files to put in the tds
installfiles = {"expkv-cs.sty", "expkv-cs.tex"}
textfiles    = {"README.md", "CTAN.md"}
docfiles     = {"expkv-cs.pdf"}

-- how the documentation is build
typesetfiles = {"expkv-cs.dtx"}
typesetruns  = 4

-- make sure that expkv-cs.tex ends up in the generic path
packtdszip   = true
tdslocations = {
  "tex/generic/expkv-cs/expkv-cs.tex",
}

-- CTAN upload
ctanreadme    = "CTAN.md"
uploadconfig  = {
  pkg         = module,
  author      = "Jonathan P. Spratte",
  version     = pkgversion .. " " .. pkgdate,
  license     = "lppl1.3c",
  summary     = "Define expandable key=val macros using expkv",
  topic       = "keyval, macro-supp",
  ctanPath    = "/macros/generic/expkv-cs",
  repository  = "https://github.com/Skillmon/tex_expkv-cs",
  bugtracker  = "https://github.com/Skillmon/tex_expkv-cs/issues",
  update      = true,
  description = [[
`expkv-cs` is a frontend to define expandable macros with key=val arguments.
It provides four syntaxes, each of which will define `<cs>` to take a single
key=val argument:

* `\ekvcSplit<cs>{<key>=<initial>, ...}{<definition>}`
* `\ekvcSplitAndForward<cs><cs2>{<key>=<initial>, ...}`
* `\ekvcHash<cs>{<key>=<initial>, ...}{<definition>}`
* `\ekvcHashAndForward<cs><cs2>{<key>=<initial>, ...}`

Additional keys for each `<cs>` might be defined using

* `\ekvcSecondaryKeys<cs>{<prefix> <key>=<definition>, ...}`
  ]]
}
