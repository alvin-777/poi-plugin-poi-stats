{React, ReactBootstrap, FontAwesome} = window
windowManager = remote.require './lib/window'
path = remote.require 'path-extra'

i18n = new (require 'i18n-2')
  locales:['en-US', 'ja-JP', 'zh-CN'],
  defaultLocale: 'zh-CN',
  directory: path.join(__dirname, "i18n"),
  updateFiles: false,
  indent: "\t",
  extension: '.json'
i18n.setLocale(window.language)


window.plugin ?= {}
window.plugin.poiStats =
  window: null
  bounds: null

handleWindowMoveResize = ->
  plugin.poiStats.bounds = plugin.poiStats.window.getBounds()
  # console.log "Poi Stats Bounds: #{JSON.stringify(plugin.poiStats.bounds)}"

initialPoiStatsWindow = ->
  defaultBounds = {x: 0, y: 0, width: 800, height: 750}
  b = config.get 'plugin.PoiStatistics.bounds', defaultBounds
  newWindow = windowManager.createWindow
    x: b.x
    y: b.y
    width: b.width
    height: b.height
    realClose: true
  ps = window.plugin.poiStats
  ps.window = newWindow
  newWindow.setMinimumSize 600, 425
  newWindow.on 'move', handleWindowMoveResize
  newWindow.on 'resize', handleWindowMoveResize
  newWindow.on 'close', ->
    if ps.bounds?
      config.set 'plugin.PoiStatistics.bounds', ps.bounds
  newWindow.on 'closed', ->
    ps.window = ps.bounds = null
  if process.env.DEBUG?
    window.log 'Poi Stats started.'
    newWindow.openDevTools
      detach: true
  newWindow.loadURL "file://#{__dirname}/index.html"
  newWindow.show()

module.exports =
  name: 'PoiStatistics'
  priority: 110
  displayName: <span><FontAwesome name='bar-chart' key={0} /> {i18n.__ 'Poi Statistics'}</span>
  author: 'Alvin Yu'
  link: 'https://github.com/alvin-777/poi-plugin-poi-stats'
  version: '1.2.0'
  description: i18n.__ 'PluginDesc'
  handleClick: ->
    if window.plugin.poiStats.window?
      window.plugin.poiStats.window.show()
    else
      initialPoiStatsWindow()
