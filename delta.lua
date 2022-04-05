local ansikit = require 'ansikit'
local bait = require 'bait'
local lunacolors = require 'lunacolors'

local function dirty()
	local _, dirt = hilbish.run('git status --porcelain | wc -l', false)
	dirt = dirt:gsub('\n', '')

	return (dirt ~= '0' and '*' or '')
end

local function isgitrepo()
	local code = hilbish.run 'git rev-parse --git-dir > /dev/null 2>&1'
	return code == 0
end

local function branch()
	local _, gitbranch = hilbish.run('git rev-parse --abbrev-ref HEAD', false)

	return gitbranch:gsub('\n', '')
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
	if os.getenv 'SHLVL' - (opts.shlvl and opts.shlvl or os.getenv 'SHLVL') > 0 then
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

	hilbish.prompt(delta.prompt(0, opts))

	bait.catch('command.exit', function(code)
		local p = delta.prompt(code, opts)
		hilbish.prompt(p)
	end)
end

return delta
