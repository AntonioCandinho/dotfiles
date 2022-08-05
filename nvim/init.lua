local packages = require "packages"
local settings = require "settings"
local autocommands = require "autocommands"

packages.setup()
settings.apply()
autocommands.setup()
