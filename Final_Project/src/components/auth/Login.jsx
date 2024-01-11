import React from "react";
import { FaUser, FaLock } from "react-icons/fa";
import { Link } from "react-router-dom";
import './Form.css'
const Login = () => {
    return (
        <div className="container1">
            <div className="wrapper">
                <form>
                    <h1>Login</h1>
                    <div className="input-box">
                        <input
                            type="text"
                            placeholder="Email"
                        
                        />
                        <FaUser className="icon" />
                    </div>
                    <div className="input-box">
                        <input
                            type="password"
                            placeholder="Password"
   
                            
                        />
                        <FaLock className="icon" />

                    </div>
                    <button type="submit">Login</button>

                    <div className="register-link">
                        <p>
                            Don&apos;t have an account ?{" "}
                            <Link to="/signup">Register</Link>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default Login;
