# kitsune (狐)
A config file system for Mozilla Firefox
## Features
kitsune can:
- Extract the CSS from a Stylish theme
- Inject a CSS file into an existing Stylish theme.

(Note: kitsune can NOT make Stylish themes from CSS files. To do that, see [userstyles.org](https://userstyles.org/help).)
## Installation
`npm i -g firefox-kitsune`
That's it!
## Usage and Configuration
So far, kitsune only supports the use of external stylesheets using the Stylish API:
After installing the [Stylish extension](https://addons.mozilla.org/firefox/downloads/latest/stylish/addon-2108-latest.xpi?src=dp-btn-primary), find a CSS theme you want to implement on a site and install it with Stylish.
### Configuration
- `tasks:` Can be an array of `styles`, to set styles, or `readStyles`, to read all styles to the specified external files. Order matters!
- `profile:` The folder name of your Firefox profile (found in ~/.mozilla/firefox.)
- `stylish:` Where stylish settings will go.
- `stylish/styles:` Contains the `name: path` pairs for the stylesheets. The name signifies which Stylish theme the stylesheet will be applied to, or in the case of `readStyles`, the path signifies the path to which the style will be saved.
#### Example configuration ####
`~/.config/kitsune/config.yml`
```yaml
tasks:
	- "readStyles"
	- "styles"
profile: "gkr0wqkl.default"
stylish:
	titles:
		"4chan - Midnight Caek": "/home/ebrock/midnight-caek.css"
```
Once you have the configuration set up, simply run `kitsune` and reload pages/restart Firefox.
