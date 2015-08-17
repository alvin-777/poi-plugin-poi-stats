{React, ReactBootstrap, FontAwesome} = window
remote = require 'remote'
windowManager = remote.require './lib/window'

i18n = remote.require './node_modules/i18n'
path = require 'path-extra'
{__} = i18n

i18n.configure({
    locales:['en_US', 'ja_JP', 'zh_CN'],
    defaultLocale: 'zh_CN',
    directory: path.join(__dirname, "i18n"),
    updateFiles: false,
    indent: "\t",
    extension: '.json'
})
i18n.setLocale(window.language)


window.poiStatsWindow = null

savePoiStatsWindowPosition = ->
    if window.poiStatsWindow != null
        config.set 'plugin.PoiStatistics.pos', window.poiStatsWindow.getPosition()
        if process.env.DEBUG?
            window.log 'New position: ' + window.poiStatsWindow.getPosition()

savePoiStatsWindowSize = ->
    if window.poiStatsWindow != null
        config.set 'plugin.PoiStatistics.size', window.poiStatsWindow.getSize()
        if process.env.DEBUG?
            window.log 'New size: ' + window.poiStatsWindow.getSize()

onPoiStatsWindowClosed = ->
    window.poiStatsWindow = null
    if process.env.DEBUG?
        window.log 'Poi Stats closed.'

initialPoiStatsWindow = ->
    pos = config.get 'plugin.PoiStatistics.pos', [0, 0]
    size = config.get 'plugin.PoiStatistics.size', [800, 750]
    newWindow = windowManager.createWindow
        x: pos[0]
        y: pos[1]
        width: size[0]
        height: size[1]
        realClose: true
    window.poiStatsWindow = newWindow
    newWindow.setMinimumSize 600, 425
    newWindow.on 'move', savePoiStatsWindowPosition
    newWindow.on 'resize', savePoiStatsWindowSize
    newWindow.on 'closed', onPoiStatsWindowClosed
    newWindow.loadUrl "file://#{__dirname}/index.html"
    newWindow.show()
    if process.env.DEBUG?
        window.log 'Poi Stats started.'
        newWindow.openDevTools
            detach: true

module.exports =
    name: 'PoiStatistics'
    priority: 110
    displayName: <span><FontAwesome name='bar-chart' key={0} /> {__ 'PluginName'}</span>
    author: 'Alvin Yu'
    link: 'https://github.com/alvin-777/poi-plugin-poi-stats'
    version: '1.1.0'
    description: __ 'PluginDesc'
    handleClick: ->
        if window.poiStatsWindow != null
            window.poiStatsWindow.show()
        else
            initialPoiStatsWindow()
