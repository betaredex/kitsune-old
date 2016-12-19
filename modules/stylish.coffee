fs = require 'fs'
sqlite3 = require 'sqlite3'

stylish = (mode, doc) ->
	db = new sqlite3.Database "#{process.env.HOME}/.mozilla/firefox/#{doc.profile}/stylish.sqlite"
	for title in Object.keys doc.stylish.titles
		stylepath = doc.stylish.titles[title]
		if fs.existsSync stylepath
			stylestring = fs.readFileSync stylepath, 'utf8'
		else
			stylestring = ""
		db.all "SELECT id WHERE name IS '#{title}'", (err, rows) ->
			if mode == "write"
				if rows
					db.run "UPDATE styles SET code=(?) WHERE name IS '#{title}'", stylestring
				else
					db.run "INSERT INTO styles (name,code,enabled) VALUES ('#{title}',(?),1)", stylestring
			if mode == "read"
				unless !rows || stylestring == rows[0].code
					fs.writeFileSync stylepath, rows[0].code
	db.close()

module.exports = stylish
