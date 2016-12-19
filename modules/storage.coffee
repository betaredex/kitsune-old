storage = (data, browser) ->
	for url in Object.keys data
		value = data[url].value.replace /('|")/, "\\$1"
		browser.get url
		console.log "At #{url}"
		browser.executeScript "localStorage.setItem('#{data[url].key}', '#{value}')"
module.exports = storage
