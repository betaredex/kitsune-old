yaml = require 'js-yaml'
fs = require 'fs'
sqlite3 = require 'sqlite3'

doc = yaml.safeLoad fs.readFileSync "#{process.env.XDG_CONFIG_HOME || process.env.HOME + '/.config'}/kitsune/config.yml", 'utf8'
storage = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/webappsstore.sqlite"
for key in Object.keys doc.storage
	

