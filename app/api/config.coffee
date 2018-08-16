
# Configuration Settings
# ----------------------
# The config settings change depending on which environment the app is running in.
# By default, this is the development environment, but this can be changed either by:
# * An env query string, e.g. localhost:3998?env=production
#   (This changes the Panoptes JS Client does)
# * The NODE_ENV environment variable on the system running the app.

# Try and match the location.search property against a regex. Basically mimics
# the CoffeeScript existential operator, in case we're not in a browser.
locationMatch = (regex) =>
  match;
  if typeof location isnt 'undefined' and location isnt null
    match = location.search.match(regex);

  if match and match[1] then match[1] else undefined

DEFAULT_ENV = 'development'
envFromBrowser = locationMatch(/\W?env=(\w+)/)
envFromShell = process.env.NODE_ENV
env = envFromBrowser or envFromShell or DEFAULT_ENV

if not env.match(/^(production|staging|development)$/)
  throw new Error("Error: Invalid Environment - #{envFromShell}")


baseConfig =
  development:
    panoptesAppId: 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add'
  staging:
    panoptesAppId: 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add'
  production:
    panoptesAppId: 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add'


baseConfig.staging = baseConfig.development

config = baseConfig[env]
module.exports =
  env: env
  config: config


# API_HOSTS =
#   production: 'https://panoptes.zooniverse.org'
#   staging: 'https://panoptes-staging.zooniverse.org'

# API_APPLICATION_IDS =
#   production: 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add'

# hostFromBrowser = location?.search.match(/\W?panoptes-api-host=([^&]+)/)?[1]
# appFromBrowser = location?.search.match(/\W?panoptes-api-application=([^&]+)/)?[1]

# hostFromShell = process.env.PANOPTES_API_HOST
# appFromShell = process.env.PANOPTES_API_APPLICATION

# envFromBrowser = location?.search.match(/\W?env=(\w+)/)?[1]
# envFromShell = process.env.NODE_ENV

# env = envFromBrowser ? envFromShell ? DEFAULT_ENV
# env = 'production'

# module.exports =
#   host: hostFromBrowser ? hostFromShell ? API_HOSTS[env]
#   clientAppID: appFromBrowser ? appFromShell ? API_APPLICATION_IDS[env]
