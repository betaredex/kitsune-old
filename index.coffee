yaml = require 'js-yaml'
fs = require 'fs'
build = require './server'
stylish = require './modules/stylish'
storage = require './modules/storage'

doc = yaml.safeLoad fs.readFileSync "#{process.env.HOME}/.config/kitsune/config.yml", 'utf8'
if doc.tasks && doc.tasks.length > 0
	for task in doc.tasks
		switch task
			when 'stylish'
				switch doc.stylish.mode
					when "read" then stylish "read", doc
					when "write" then stylish "write", doc
			when 'storage' then build "firefox", doc.profile, (server) -> storage doc.storage, server
