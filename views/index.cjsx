{$, $$, _, React, ReactDOM, ReactBootstrap, FontAwesome, ROOT} = window
NavigationBar = require './navigation-bar'

WebArea = React.createClass
  render: ->
    h = "#{window.innerHeight - 50}px"
    $('inner-page')?.style?.height = h
    $('inner-page webview')?.style?.height = h
    $('inner-page webview')?.shadowRoot?.querySelector('object[is=browserplugin]')?.style?.height = h
    <form id="nav-area">
      <div className="form-group" id='navigation-bar'>
        <h5>   </h5>
        <NavigationBar />
      </div>
    </form>

ReactDOM.render <WebArea />, $('web-area')
