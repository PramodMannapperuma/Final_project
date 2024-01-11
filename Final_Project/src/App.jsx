import React from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import "./App.css";
// import Home from './pages/home';
// import NavBar from './components/navigation/NavBar'
import SignIn from './components/auth/SignIn';
import  Login  from "./components/auth/Login";

function App() {
  return (
    <>
    {/* <NavBar /> */}
    <BrowserRouter>
      <Routes>
      <Route path="/" element={< SignIn />} />
      <Route path="/Login" element={< Login />} />
      </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
