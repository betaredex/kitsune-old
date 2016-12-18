yaml = require 'js-yaml'
fs = require 'fs'
sqlite3 = require('sqlite3').verbose()

doc = yaml.safeLoad fs.readFileSync "#{process.env.HOME}/.config/kitsune/config.yml", 'utf8'
stylish = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/stylish.sqlite"
for title in Object.keys doc.stylish.titles
	stylepath = doc.stylish.titles[title]
	stylestring = fs.readFileSync stylepath, 'utf8'
	stylish.run "UPDATE styles SET code=(?) WHERE name IS '#{title}'", stylestring
stylish.close()
