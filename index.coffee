yaml = require 'js-yaml'
fs = require 'fs'
sqlite3 = require('sqlite3').verbose()

stylish = ->
	db = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/stylish.sqlite"
	for title in Object.keys doc.stylish.titles
		stylepath = doc.stylish.titles[title]
		stylestring = fs.readFileSync stylepath, 'utf8'
		db.all "SELECT id WHERE name IS '#{title}'", (err, rows) ->
			if rows
				db.run "UPDATE styles SET code=(?) WHERE name IS '#{title}'", stylestring
			else
				db.run "INSERT INTO styles (name,code,enabled) VALUES ('#{title}',(?),1)", stylestring
	db.close()

readStyles = ->
	db = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/stylish.sqlite"
	for title in Object.keys doc.stylish.titles
		stylepath = doc.stylish.titles[title]
		if fs.existsSync stylepath
			stylestring = fs.readFileSync stylepath, 'utf8'
		else
			stylestring = ""
		unless stylestring
			db.all "SELECT code FROM styles WHERE name IS '#{title}'", (err, rows) ->
				if rows[0].code && stylestring != rows[0].code
					fs.writeFileSync stylepath, rows[0].code

doc = yaml.safeLoad fs.readFileSync "#{process.env.HOME}/.config/kitsune/config.yml", 'utf8'
if doc.tasks && doc.tasks.length > 0
	for task in doc.tasks
		switch task
			when 'stylish' then stylish()
			when 'readStyles' then readStyles()
