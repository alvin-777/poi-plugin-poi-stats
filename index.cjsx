{React, ReactBootstrap, FontAwesome} = window
remote = require 'remote'
windowManager = remote.require './lib/window'

i18n = remote.require './node_modules/i18n'
path = require 'path-extra'
{__} = i18n

i18n.configure({
  locales:['en-US', 'ja-JP', 'zh-CN'],
  defaultLocale: 'zh-CN',
  directory: path.join(__dirname, "i18n"),
  updateFiles: false,
  indent: "\t",
  extension: '.json'
})
i18n.setLocale(window.language)


window.poiStatsWindow = null

handleWindowMoveResize = ->
  b1 = window.poiStatsWindow.getBounds()
  # console.log "Moved to: #{JSON.stringify(b1)}"
  setTimeout(( ->
    b2 = window.poiStatsWindow.getBounds()
    if JSON.stringify(b2) == JSON.stringify(b1)
      config.set 'plugin.PoiStatistics.bounds', b2
      # console.log "   Saved:  #{JSON.stringify(b2)}"
  ), 5000)

initialPoiStatsWindow = ->
  defaultBounds = {x: 0, y: 0, width: 800, height: 750}
  b = config.get 'plugin.PoiStatistics.bounds', defaultBounds
  newWindow = windowManager.createWindow
    x: b.x
    y: b.y
    width: b.width
    height: b.height
    realClose: true
  window.poiStatsWindow = newWindow
  newWindow.setMinimumSize 600, 425
  newWindow.on 'move', handleWindowMoveResize
  newWindow.on 'resize', handleWindowMoveResize
  newWindow.on 'closed', -> window.poiStatsWindow = null
  newWindow.loadURL "file://#{__dirname}/index.html"
  newWindow.show()
  if process.env.DEBUG?
    window.log 'Poi Stats started.'
    newWindow.openDevTools
      detach: true

module.exports =
  name: 'PoiStatistics'
  priority: 110
  displayName: <span><FontAwesome name='bar-chart' key={0} /> {__ 'Poi Statistics'}</span>
  author: 'Alvin Yu'
  link: 'https://github.com/alvin-777/poi-plugin-poi-stats'
  version: '1.2.0'
  description: __ 'PluginDesc'
  handleClick: ->
    if window.poiStatsWindow != null
      window.poiStatsWindow.show()
    else
      initialPoiStatsWindow()
