#!/usr/bin/env node
// Generated by CoffeeScript 1.12.1
(function() {
	var doc, fs, i, len, readStyles, ref, sqlite3, stylish, task, yaml;

	yaml = require('js-yaml');

	fs = require('fs');

	sqlite3 = require('sqlite3').verbose();

	stylish = function() {
		var db, i, len, ref, stylepath, stylestring, title;
		db = new sqlite3.Database(process.env.HOME + "/.mozilla/firefox/" + doc.profile + "/stylish.sqlite");
		ref = Object.keys(doc.stylish.titles);
		for (i = 0, len = ref.length; i < len; i++) {
			title = ref[i];
			stylepath = doc.stylish.titles[title];
			stylestring = fs.readFileSync(stylepath, 'utf8');
			db.all("SELECT id WHERE name IS '" + title + "'", function(err, rows) {
				if (rows) {
					return db.run("UPDATE styles SET code=(?) WHERE name IS '" + title + "'", stylestring);
				} else {
					return db.run("INSERT INTO styles (name,code,enabled) VALUES ('" + title + "',(?),1)", stylestring);
				}
			});
		}
		return db.close();
	};

	readStyles = function() {
		var db, i, len, ref, results, stylepath, stylestring, title;
		db = new sqlite3.Database(process.env.HOME + "/.mozilla/firefox/" + doc.profile + "/stylish.sqlite");
		ref = Object.keys(doc.stylish.titles);
		results = [];
		for (i = 0, len = ref.length; i < len; i++) {
			title = ref[i];
			stylepath = doc.stylish.titles[title];
			if (fs.existsSync(stylepath)) {
				stylestring = fs.readFileSync(stylepath, 'utf8');
			} else {
				stylestring = "";
			}
			if (!stylestring) {
				results.push(db.all("SELECT code FROM styles WHERE name IS '" + title + "'", function(err, rows) {
					if (rows[0].code && stylestring !== rows[0].code) {
						return fs.writeFileSync(stylepath, rows[0].code);
					}
				}));
			} else {
				results.push(void 0);
			}
		}
		return results;
	};

	doc = yaml.safeLoad(fs.readFileSync(process.env.HOME + "/.config/kitsune/config.yml", 'utf8'));

	if (doc.tasks && doc.tasks.length > 0) {
		ref = doc.tasks;
		for (i = 0, len = ref.length; i < len; i++) {
			task = ref[i];
			switch (task) {
				case 'stylish':
					stylish();
					break;
				case 'readStyles':
					readStyles();
			}
		}
	}

}).call(this);
