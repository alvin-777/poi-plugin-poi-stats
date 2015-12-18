{$, $$, _, React, ReactDOM, ReactBootstrap, FontAwesome, ROOT} = window
NavigationBar = require './navigation-bar'

WebArea = React.createClass
  handleResize: ->
    h = "#{window.innerHeight - 50}px"
    $('inner-page')?.style?.height = h
    $('inner-page webview')?.style?.height = h
    $('inner-page webview')?.shadowRoot?.querySelector('object[is=browserplugin]')?.style?.height = h
  componentWillMount: ->
    @handleResize()
  componentDidMount: ->
    window.addEventListener 'resize', @handleResize
  componentWillUmount: ->
    window.removeEventListener 'resize', @handleResize
  render: ->
    <form id="nav-area">
      <div className="form-group" id='navigation-bar'>
        <h5>   </h5>
        <NavigationBar />
      </div>
    </form>

ReactDOM.render <WebArea />, $('web-area')
