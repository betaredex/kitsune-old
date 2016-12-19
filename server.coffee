webdriver = require 'selenium-webdriver'
firefox = require 'selenium-webdriver/firefox'

build = (browser, profile, cb) ->
	switch browser
		when "firefox"
			profile = new firefox.Profile "#{process.env.HOME}/.mozilla/firefox/#{profile}"
			options = new firefox.Options().setProfile(profile)
			server = new webdriver.Builder()
				.forBrowser 'firefox'
				.withCapabilites webdriver.Capabilities.phantomjs()
				.setFirefoxOptions options
				.build()
			cb server

module.exports = build
