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
window.setCSS = (selectror, path) ->
  $(selectror)?.setAttribute 'href', path
window.setTheme = (t) ->
  if t is '__default__'
    setCSS '#bootstrap-css', "#{ROOT}/components/bootstrap/dist/css/bootstrap.css"
  else
    setCSS '#bootstrap-css', "#{ROOT}/assets/themes/#{t}/css/#{t}.css"

window.theme = config.get 'poi.theme', '__default__'
setTheme window.theme

window.handleThemeChange = (e) ->
  window.theme = e.detail.theme
  setTheme(window.theme)
window.addEventListener 'theme.change', window.handleThemeChange

setCSS '#font-awesome', "#{ROOT}/components/font-awesome/css/font-awesome.min.css"

require 'coffee-react/register'
require './views'
