local promptua = require 'promptua'
local git = require 'promptua.providers.git'
promptua.setConfig {
	delta = {
		shlvl = 3
	}
}

return {
	{
		provider = 'dir.path',
		style = 'blue'
	},
	{
		provider = function(segment)
			segment.defaults = {
				separator = git.isDirty() and '' or ' '
			}
			local branch = git.getBranch()
			if not branch then
				return ''
			end

			return branch
		end,
		condition = git.isRepo,
		style = 'gray'
	},
	{
		provider = 'git.dirty',
		style = 'gray'
	},
	{
		provider = 'command.execTime',
		style = 'bold cyan'
	},
	{
		provider = function() return (os.getenv 'SHLVL' + 1) - promptua.config.delta.shlvl end,
		condition = function() return os.getenv 'SHLVL' - promptua.config.delta.shlvl > 0 end,
		icon = ' ',
		style = 'red',
	},
	{
		separator = '\n'
	},
	{
		provider = 'prompt.failSuccess',
		icon = '∆',
		style = 'green'
	}
}
