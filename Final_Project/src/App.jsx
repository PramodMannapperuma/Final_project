import React from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import "./App.css";
import Home from './pages/home';
import NavBar from './components/navigation/NavBar'

function App() {
  return (
    <>
    <NavBar />
    <BrowserRouter>
      <Routes>
      <Route path="/" element={<Home />} />
      </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
