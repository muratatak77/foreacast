import React, { Component } from "react";
import Home from "./components/Home";

class App extends Component {
  render() {
    return (
      <div className="mainContainer">
        <div className="topHeading">
          <h1>A Simple To-Do List App</h1>
        </div>
        <Home />
      </div>
    );
  }
}

export default App;