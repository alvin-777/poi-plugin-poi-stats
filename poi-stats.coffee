# Shortcuts and Components
window._ = require "#{ROOT}/node_modules/underscore"
window.$ = (param) -> document.querySelector(param)
window.$$ = (param) -> document.querySelectorAll(param)
window.React = require "#{ROOT}/node_modules/react"
window.ReactDOM = require "#{ROOT}/node_modules/react-dom"
window.ReactBootstrap = require "#{ROOT}/node_modules/react-bootstrap"
window.FontAwesome = require "#{ROOT}/node_modules/react-fontawesome"

# Node modules
window.config = remote.require './lib/config'

# language setting
window.language = config.get 'poi.language', 'zh-CN'

# Custom theme
window.theme = config.get 'poi.theme', '__default__'
if theme == '__default__'
  $('#bootstrap-css')?.setAttribute 'href', "#{ROOT}/components/bootstrap/dist/css/bootstrap.css"
else
  $('#bootstrap-css')?.setAttribute 'href', "#{ROOT}/assets/themes/#{theme}/css/#{theme}.css"
window.addEventListener 'theme.change', (e) ->
  window.theme = e.detail.theme
  if theme == '__default__'
    $('#bootstrap-css')?.setAttribute 'href', "#{ROOT}/components/bootstrap/dist/css/bootstrap.css"
  else
    $('#bootstrap-css')?.setAttribute 'href', "#{ROOT}/assets/themes/#{theme}/css/#{theme}.css"

$('#font-awesome')?.setAttribute 'href', "#{ROOT}/components/font-awesome/css/font-awesome.min.css"

require 'coffee-react/register'
require './views'
