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
> Requires Hilbish 2.0+

### Manually
Install Promptua with the steps listed [here](https://github.com/TorchedSammy/Promptua#install)

Then clone Delta to the Promptua theme directory:
```
git clone https://github.com/TorchedSammy/Delta ~/.config/promptua/themes/delta
```

# Getting Started
Require Promptua and set it as your theme and initialize:
```lua
local promptua = require 'promptua'

promptua.setTheme 'delta'
promptua.init()
```

To which you can now `dofile(hilbish.userDir.config .. '/hilbish/init.lua')` or restart
the shell.

# License
Delta is licensed under the BSD 3-Clause license.  
[Read here](LICENSE) for more info.
