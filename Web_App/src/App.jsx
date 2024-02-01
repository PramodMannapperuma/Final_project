import SignUp from './Pages/UserAuth/UserSignup'
import Login from './Pages/UserAuth/UserLogin';
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from './Pages/Home';

function App() {

  return (
    <>
    <Router>
    <Routes>
      <Route path='/' element={<SignUp />} />
      <Route path='/login' element={<Login />} />
      <Route path='home' element={<Home />} />
    </Routes>
    </Router>
       
    </>
  )
}

export default App
