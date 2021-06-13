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
local icons = {
	'' -- shlvl
}

function delta.prompt(exitcode, opts)
	local fail = exitcode ~= 0
	local promptstr = '{blue}%d'

	if isgitrepo() then
		promptstr = promptstr .. ' ' .. ansikit.getCSI('38;5;242')
		.. branch() .. '' .. dirty()
	end
	if os.getenv 'SHLVL' - opts.shlvl ~= 0 then
		promptstr = promptstr .. ' ' .. icons[1] .. ' ' .. (os.getenv 'SHLVL' + 1) - opts.shlvl
	end
	promptstr = promptstr .. '\n' .. (fail and '{red}' or '{green}') .. '∆ '

	return lunacolors.format(promptstr)
end

function delta.init(o)
	local opts = {}
	o = o or {
		shlvl = 3
	}
	setmetatable(opts, {__index = o})

	prompt(delta.prompt(0, opts))

	bait.catch('command.exit', function(code)
		prompt(delta.prompt(code, opts))
	end)

end
return delta
