local ansikit = require 'ansikit'
local bait = require 'bait'
local lunacolors = require 'lunacolors'

function dirty()
	local res = io.popen 'git status --porcelain | wc -l'
	local dirt = res:read():gsub('\n', '')
	res:close()

	return (dirt ~= '0' and '*' or '')
end

function isgitrepo()
	local code = os.execute 'git rev-parse --git-dir > /dev/null 2>&1'
	return code == 0
end

function branch()
	local res = io.popen 'git rev-parse --abbrev-ref HEAD 2> /dev/null'
	local gitbranch = res:read()
	res:close()

	return gitbranch
end

local delta = {}

function delta.prompt(exitcode)
	local fail = exitcode ~= 0
	local promptstr = '{blue}%d'

	if isgitrepo() then
		promptstr = promptstr .. ' ' .. ansikit.getCSI('38;5;242')
		.. branch() .. '' .. dirty()
	end
	promptstr = promptstr .. '\n' .. (fail and '{red}' or '{green}') .. '∆ '

	return lunacolors.format(promptstr)
end

function delta.init()
	prompt(delta.prompt(0))

	bait.catch('command.exit', function(code)
		prompt(delta.prompt(code))
	end)

end
return delta
