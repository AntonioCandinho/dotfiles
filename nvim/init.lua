local packages = require "packages"
local settings = require "settings"
local autocommands = require "autocommands"

settings.apply()
packages.setup()
autocommands.setup()
