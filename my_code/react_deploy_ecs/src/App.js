import React from 'react';
import logo from './logo.svg';
import './App.css';
import { useEffect, useState } from "react";


function App() {
  const[s3Image, stateS3Image] = useState('');

  useEffect(() => {

  }, [])

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>CODE</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          duongdx - testing
        </a>
      </header>
    </div>
  );
}

export default App;
