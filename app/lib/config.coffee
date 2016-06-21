PANOPTES_APP_ID = 'ece9df210cfddac64fb9fc6a0ed87f277bd2d5cbfcb0fb11545f62ca6f229add'
panoptesReturnUrl = 'https://www.wildcamgorongosa.org/'

if window.location.hostname == 'localhost'
  panoptesReturnUrl = 'http://localhost:3434/?env=production'

module.exports =
  projectId: '593'
  workflowId: '338'
  panoptesAppId: PANOPTES_APP_ID
  panoptesReturnUrl: panoptesReturnUrl
