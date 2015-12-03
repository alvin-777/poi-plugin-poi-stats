{$, $$, _, React, ReactBootstrap, FontAwesome, ROOT} = window
{Panel, Button, Input, Col, Grid, Row, Table} = ReactBootstrap
NavigationBar = require './navigation-bar'
WebArea = React.createClass
  render: ->
    h = "#{window.innerHeight - 50}px"
    $('inner-page')?.style?.height = h
    $('inner-page webview')?.style?.height = h
    $('inner-page webview')?.shadowRoot?.querySelector('object[is=browserplugin]')?.style?.height = h
    <form id="nav-area">
      <div className="form-group" id='navigator-bar'> {# Damn "navigator bar" is wrong English!}
        <h5>   </h5>
        <NavigationBar />
      </div>
    </form>
React.render <WebArea />, $('web-area')
