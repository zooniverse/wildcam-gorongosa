PanoptesClient = require 'panoptes-client'
config = require './config'

oauth = require 'panoptes-client/lib/oauth'
client = require 'panoptes-client/lib/api-client'
PANOPTES_APP_ID = 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add';

module.exports =
  api: client
  client: client
  oauth: oauth
  PANOPTES_APP_ID: PANOPTES_APP_ID
