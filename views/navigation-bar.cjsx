{$, $$, _, React, ReactBootstrap, FontAwesome, ROOT} = window
{Grid, Col, Row, Button, ButtonGroup} = ReactBootstrap
remote = require 'remote'
webview = $('inner-page webview')

psLog = (msg) ->
  now = new Date()
  console.log "#{now.getTime()}: #{msg}"
psAddEventLogger = (ev) ->
  webview.addEventListener ev, psLog.bind(@, ev)

# if remote.getCurrentWindow().isDevToolsOpened()
  # psAddEventLogger 'did-start-loading'
  # psAddEventLogger 'did-stop-loading'
  # psAddEventLogger 'did-finish-load'
  # psAddEventLogger 'did-fail-load'

NavigationBar = React.createClass
  canSetState: true
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
  onResize: ->
    h = "#{window.innerHeight - 50}px"
    $('inner-page')?.style?.height = h
    $('inner-page webview')?.style?.height = h
    $('inner-page webview')?.shadowRoot?.querySelector('object[is=browserplugin]')?.style?.height = h
  onStartedLoading: ->
    if @canSetState and @state.navigateStatus isnt 'Loading'
      @setState
        navigateStatus: 'Loading'
  onStoppedLoading: ->
    if @canSetState and @state.navigateStatus isnt 'OK'
      @setState
        navigateStatus: 'OK'
  onFailedToLoad: ->
    if @canSetState and @state.navigateStatus isnt 'Failed'
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
  componentWillUpdate: ->
    @canSetState = false
  componentDidUpdate: ->
    @canSetState = true

  canGoBack: ->
    try
      webview.canGoBack()
    catch error
      false
  goBack: ->
    if @canGoBack()
      webview.goBack()
  canGoForward: ->
    try
      webview.canGoForward()
    catch error
      false
  goForward: ->
    if @canGoForward()
      webview.goForward()
  refreshPage: ->
    webview.reload()
  maximiseWindow: ->
    # MacOSX can handle maximize & unmaximize automatically.
    # May need to call unmaximize() on some OS??
    remote.getCurrentWindow().maximize()
  resetWindow: ->
    remote.getCurrentWindow().setBounds
      x: (config.get 'poi.window.x', 0) + 800
      y: config.get 'poi.window.y', 0
      width: 800
      height: 750
  toggleFullscreen: ->
    currWin = remote.getCurrentWindow()
    currWin.setFullScreen(!currWin.isFullScreen())
  hideWindow: ->
    remote.getCurrentWindow().hide()
  copyToClipboard: ->
    webview.copy()
  render: ->
    <Grid fluid=true>
      <Row>
        <Col lg={11} md={11} xs={11}>
          <ButtonGroup>
            <Button bsSize='small' bsStyle='info' disabled={!@canGoBack()} onClick={@goBack} title='Back'><FontAwesome name='arrow-left' /></Button>
            <Button bsSize='small' bsStyle='info' disabled={!@canGoForward()} onClick={@goForward} title='Forward'><FontAwesome name='arrow-right' /></Button>
          </ButtonGroup>
          <span>　{@getIcon()}　</span>
          <Button bsSize='small' bsStyle='warning' onClick={@refreshPage} title='Refresh'><FontAwesome name='refresh' /></Button>
          <span>　</span>
          <ButtonGroup>
            <Button bsSize='small' bsStyle='primary' onClick={@maximiseWindow} onContextMenu={@resetWindow} title='Zoom/Reset Window'><FontAwesome name='arrows' /></Button>
            <Button bsSize='small' bsStyle='primary' onClick={@toggleFullscreen} title='Toggle Fullscreen'><FontAwesome name='arrows-alt' /></Button>
          </ButtonGroup>
          <span>　</span>
          <Button bsSize='small' onClick={@copyToClipboard} title='Copy To Clipboard'><FontAwesome name='clipboard' /></Button>
        </Col>
        <Col lg={1} md={1} xs={1}>
          <Button bsSize='small' onClick={@hideWindow} title='Hide Window'><FontAwesome name='times' /></Button>
        </Col>
      </Row>
    </Grid>
module.exports = NavigationBar
