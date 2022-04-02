<div align="center">
	<h1>Delta</h1>
	<blockquote>🧪 A simple, minimal prompt for Hilbish.</blockquote>
	<br>
	<img src="showcase.png">
</div>

Delta is pretty, minimalist prompt for [Hilbish](https://github.com/Rosettea/Hilbish),
inspired by [Pure](https://github.com/sindresorhus/pure).

Delta shows all that you'll really need:
current working directory, git branch and if its dirty, and of course the delta
prompt character.

# Installation
> Requires Hilbish 2.0+ (master branch or lua5.4 branch)

### Manually
Clone this directory to one of the paths Hilbish looks for libraries at.
```
git clone https://github.com/TorchedSammy/Delta ~/.local/share/hilbish/libs/delta
```

# Getting Started
Require Delta (`local delta = require 'delta'`) then initalize:
```lua
delta.init()
```  
It will handle the prompt on its own.
If desired, Delta can be configured like so:  
```lua
-- The values provided here are the defaults
delta.init {
	shlvl = 3 -- What $SHLVL is on launch. Delta will show the current level number if it goes above this. Set to `nil` to not show at all
}
```

But if you want to manage your hooks/how it works more, you can go with the more
manual approach. Assuming you have the default config, replace the `doPrompt`
function with:  
```lua
function doPrompt(exitcode, o)
	prompt(delta.prompt(exitcode, o))
end
```  
Add `0` as an arg to the first call, then just pass `code` in the command.exit hook:
```lua
-- Default Options
local opts = {
	shlvl = 3
}

doPrompt(0, opts)

bait.catch('command.exit', function(code)
	doPrompt(code, opts)
end)
```  
To which you can now `dofile(os.getenv 'HOME' .. '/.hilbishrc.lua')` or restart
the shell.

# License
Delta is licensed under the BSD 3-Clause license.  
[Read here](LICENSE) for more info.
