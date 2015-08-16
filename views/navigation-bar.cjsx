{$, $$, _, React, ReactBootstrap, FontAwesome, ROOT} = window
{Grid, Col, Button, ButtonGroup, Input, Modal, Alert, OverlayTrigger, DropdownButton, MenuItem, Popover, Row, Tooltip} = ReactBootstrap
remote = require 'remote'
webview = $('inner-page webview')
innerpage = $('inner-page')

# i18n = remote.require './node_modules/i18n'
# path = require 'path-extra'
# {__} = i18n
#
# i18n.configure({
#     locales:['en_US', 'ja_JP', 'zh_CN'],
#     defaultLocale: 'zh_CN',
#     directory: path.join(__dirname, '..', "i18n"),
#     updateFiles: false,
#     indent: "\t",
#     extension: '.json'
# })
# i18n.setLocale(window.language)


NavigationBar = React.createClass
  getInitialState: ->
    navigateStatus: 'Loading'
  getIcon: ->
    switch @state.navigateStatus
      when 'Failed'
        <FontAwesome name='times' />
      when 'OK'
        <FontAwesome name='check' />
      when 'Loading'
        <FontAwesome name='spinner' spin />
  onResize: (e) ->
    $('inner-page')?.style?.height = "#{window.innerHeight - 50}px"
    $('inner-page webview')?.style?.height = $('inner-page webview /deep/ object[is=browserplugin]')?.style?.height = "#{window.innerHeight - 50}px"
  onStartedLoading: (e) ->
    @setState
      navigateStatus: 'Loading'
  onStoppedLoading: ->
    @setState
      navigateStatus: 'OK'
  onFailedToLoad: ->
    @setState
      navigateStatus: 'Failed'
  componentDidMount: ->
    window.addEventListener 'resize', @onResize
    webview.addEventListener 'did-start-loading', @onStartedLoading
    webview.addEventListener 'did-stop-loading', @onStoppedLoading
    webview.addEventListener 'did-fail-load', @onFailedToLoad
  componentWillUmount: ->
    window.removeEventListener 'resize', @onResize
    webview.removeEventListener 'did-start-loading', @onStartedLoading
    webview.removeEventListener 'did-stop-loading', @onStoppedLoading
    webview.removeEventListener 'did-fail-load', @onFailedToLoad

  goBack: ->
    if webview.canGoBack()
      webview.goBack()
  goForward: ->
    if webview.canGoForward()
      webview.goForward()
  refreshPage: ->
    webview.reload()
  maximiseWindow: ->
    # MacOSX can handle maximize & unmaximize automatically.
    # May need to call unmaximize() on some OS??
    remote.getCurrentWindow().maximize()
  toggleFullscreen: ->
    currWin = remote.getCurrentWindow()
    currWin.setFullScreen(!currWin.isFullScreen())
  copyToClipboard: ->
    webview.copy()
  render: ->
    <Grid>
      <Col xs={9}>
        <ButtonGroup>
          <Button bsSize='small' bsStyle='info' disabled={!webview.canGoBack()} onClick={@goBack} title='Back'><FontAwesome name='arrow-left' /></Button>
          <Button bsSize='small' bsStyle='info' disabled={!webview.canGoForward()} onClick={@goForward} title='Forward'><FontAwesome name='arrow-right' /></Button>
        </ButtonGroup>
        <span>　</span>
        <span class="label label-primary">{@getIcon()}</span>
        <span>　</span>
        <Button bsSize='small' bsStyle='warning' onClick={@refreshPage} title='Refresh'><FontAwesome name='refresh' /></Button>
        <span>　</span>
        <ButtonGroup>
          <Button bsSize='small' bsStyle='primary' onClick={@maximiseWindow} title='Zoom'><FontAwesome name='arrows' /></Button>
          <Button bsSize='small' bsStyle='primary' onClick={@toggleFullscreen} title='Toggle Fullscreen'><FontAwesome name='arrows-alt' /></Button>
        </ButtonGroup>
        <span>　</span>
        <Button bsSize='small' bsStyle='default' onClick={@copyToClipboard} title='Copy To Clipboard'><FontAwesome name='clipboard' /></Button>
      </Col>
    </Grid>
module.exports = NavigationBar
