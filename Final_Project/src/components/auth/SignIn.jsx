/* eslint-disable no-unused-vars */
import React from 'react';
// const SignIn = () => {
//     return ( 
//         <div>

//         </div>
//      );
// }
 
// export default SignIn;

import { useState } from "react";
import { FaUser, FaLock } from "react-icons/fa";
import { MdEmail } from "react-icons/md";
import "./Form.css";
import { Link, useNavigate } from "react-router-dom";


const SignIn = () => {
    const [formData, setFormData] = useState({
        name: "",
        email: "",
        password: "",
        confirmPassword: "",
    });
    const navigate = useNavigate();

    const [errors, setErrors] = useState({});


    return (
        <div className="container1">
            <div className="wrapper">
                <form action="/" method="POST">
                    <h1>Sign up</h1>
                    <div className="input-box">
                        <input
                            type="text"
                            placeholder="Name"
                            required
                            onChange={(e) =>
                                setFormData({
                                    ...formData,
                                    name: e.target.value,
                                })
                            }
                        />
                        <FaUser className="icon" />
                        {errors.name && (
                            <p className="error-message">{errors.name}</p>
                        )}
                    </div>
                    <div className="input-box">
                        <input
                            type="text"
                            placeholder="Email"
                            required
                            onChange={(e) =>
                                setFormData({
                                    ...formData,
                                    email: e.target.value,
                                })
                            }
                        />
                        <MdEmail className="icon" />
                        {errors.email && (
                            <p className="error-message">{errors.email}</p>
                        )}
                    </div>
                    <div className="input-box">
                        <input
                            type="password"
                            placeholder="Password"
                            required
                            onChange={(e) =>
                                setFormData({
                                    ...formData,
                                    password: e.target.value,
                                })
                            }
                        />
                        <FaLock className="icon" />
                        {errors.password && (
                            <p className="error-message">{errors.password}</p>
                        )}
                    </div>
                    <div className="input-box">
                        <input
                            type="password"
                            placeholder="Confirm Password"
                            required
                            onChange={(e) =>
                                setFormData({
                                    ...formData,
                                    confirmPassword: e.target.value,
                                })
                            }
                        />
                        <FaLock className="icon" />
                        {errors.confirmPassword && (
                            <p className="error-message">
                                {errors.confirmPassword}
                            </p>
                        )}
                    </div>
                    <button type="submit">Sign up</button>

                    <div className="register-link">
                        <p>
                            Already have an account ?{" "}
                            <Link to="/Login">Login</Link>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default SignIn;
