import SignUp from "./Pages/UserAuth/UserSignup";
import Login from "./Pages/UserAuth/UserLogin";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./Pages/Home";
import Dashbord from "./Components/Dashboard/DashBord";
import Landing from "./Components/Revenue/LandingPage";
import ReqDash from "./Components/Requests/ReqDash";
import ReDetails from "./Components/Requests/ReDetails";
import Hellooo from "./Components/Requests/shit";
import RevenueLiscense from "./Components/Revenue/Revenue";

function App() {
  return (
    <>
      <Router>
        <Routes>
          <Route path="/signup" element={<SignUp />} />
          <Route path="/login" element={<Login />} />
          <Route path="/" element={<Home />} />
          <Route path="/dashbord" element={<Dashbord />} />
          <Route path="/landing" element={<Landing />} />
          <Route path="/reqdash" element={<ReqDash />} />
          <Route path="/redetails/:id" element={<ReDetails />} />
          <Route path="/hellooo" element={<Hellooo />} />
          <Route path="/revenue" element={<RevenueLiscense />} />
        </Routes>
      </Router>
    </>
  );
}

export default App;
