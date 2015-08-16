{$, $$, _, React, ReactBootstrap, FontAwesome, ROOT} = window
{Panel, Button, Input, Col, Grid, Row, Table} = ReactBootstrap
NavigationBar = require './navigation-bar'
WebArea = React.createClass
  render: ->
    $('inner-page')?.style?.height = "#{window.innerHeight - 50}px"
    $('inner-page webview')?.style?.height = $('inner-page webview /deep/ object[is=browserplugin]')?.style?.height = "#{window.innerHeight - 50}px"
    <form id="nav-area">
      <div className="form-group" id='navigator-bar'> {# Damn "navigator bar" is wrong English!}
        <h5>   </h5>
        <NavigationBar />
      </div>
    </form>
React.render <WebArea />, $('web-area')
