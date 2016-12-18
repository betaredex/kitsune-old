yaml = require 'js-yaml'
fs = require 'fs'
sqlite3 = require('sqlite3').verbose()
fp = require 'firefox-profile'

stylish = ->
	db = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/stylish.sqlite"
	for title in Object.keys doc.stylish.titles
		stylepath = doc.stylish.titles[title]
		console.log stylepath
		stylestring = fs.readFileSync stylepath, 'utf8'
		db.all "SELECT id WHERE name IS '#{title}'", (err, rows) ->
			if rows
				db.run "UPDATE styles SET code=(?) WHERE name IS '#{title}'", stylestring
			else
				db.run "INSERT INTO styles (name,code,enabled) VALUES ('#{title}',(?),1)", stylestring
	db.close()

preferences = ->
	for option in doc.preferences
		profile.setPreference option, doc.preferences[option]
	profile.updatePreferences()

doc = yaml.safeLoad fs.readFileSync "#{process.env.HOME}/.config/kitsune/config.yml", 'utf8'
profile = fp doc.profile
if doc.tasks && doc.tasks.length > 0
	for task in doc.tasks
		switch task
			when 'stylish' then stylish()
			when 'preferences' then preferences()
