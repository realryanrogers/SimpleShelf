import React, { Component } from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import Dashboard from "./Dashboard";
import Home from "./Home";
import Testpage from "./Testpage";
import Auth from "../modules/Auth";
import Media from "./Media";
import "../css/bootstrap-theme-BT.css";
import Navbar from "./Navbar";

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      loggedInStatus: Auth.isLoggedIn().toString(),
      user: {}
    };
  }

  render() {
    const navRender = <Navbar loggedInStatus={Auth.isLoggedIn().toString()} />;

    return (
      <div className="app">
        {navRender}
        <BrowserRouter>
          <Switch>
            <Route
              exact
              path={"/"}
              render={props => (
                <Home
                  {...props}
                  loggedInStatus={Auth.isLoggedIn().toString()}
                />
              )}
            />
            <Route
              exact
              path={"/dashboard"}
              render={props => (
                <Dashboard
                  {...props}
                  loggedInStatus={Auth.isLoggedIn().toString()}
                />
              )}
            />
            <Route
              exact
              path={"/media/:type/:id"}
              render={props => (
                <Media
                  {...props}
                  loggedInStatus={Auth.isLoggedIn().toString()}
                />
              )}
            />
          </Switch>
        </BrowserRouter>
      </div>
    );
  }
}
