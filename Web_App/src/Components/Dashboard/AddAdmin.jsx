import PropTypes from 'prop-types';
import { useState } from "react";
import {
  Card,
  CardContent,
  Typography,
  TextField,
  Grid,
  FormLabel,
  RadioGroup,
  FormControlLabel,
  Radio,
} from "@mui/material";
import Button from "@mui/material/Button";
import DeleteIcon from "@mui/icons-material/Delete";
import SendIcon from "@mui/icons-material/Send";
import KeyboardArrowRightIcon from "@mui/icons-material/KeyboardArrowRight";
import { useNavigate } from "react-router-dom";
import { collection, addDoc } from 'firebase/firestore';
import { firestore, auth } from '../../firebase';
import { createUserWithEmailAndPassword } from 'firebase/auth';

const AddAdmin = ({ onAddAdmin }) => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [role, setRole] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    // Check if password matches confirmPassword
    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    try {
      // Create admin with email and password
      const adminCredintials = await createUserWithEmailAndPassword(auth, email, password);
      console.log(adminCredintials.user)
      const newAdmn = adminCredintials.user;
      
      // Check if the user has a UID
      if (!newAdmn.uid) {
        console.error("User UID not found.");
        return;
      }
      
      // Create admin object
      const newAdmin = {
        name,
        email,
        password,
        role,
        userId: newAdmn.uid, // Save the admin ID associated with this admin
      };

      // Save admin data to Firestore
      const docRef = await addDoc(collection(firestore, 'admins'), newAdmin);
      newAdmin.id = docRef.id; // Add the document ID to the admin object

      // Invoke the callback function with the new admin object
      onAddAdmin(newAdmin); 

      // Clear the form fields after adding the admin
      setName("");
      setEmail("");
      setPassword("");
      setConfirmPassword("");
      setRole("");
      navigate("/dashbord"); // Redirect to dashboard after adding admin
    } catch (error) {
      console.error("Error adding admin:", error.message);
      // Handle error adding admin (display error message to the admin, etc.)
    }
  };

  const handleDeleteClick = () => {
    // Clear the form data
    setEmail("");
    setPassword("");
    setConfirmPassword("");
    setName("");
    setRole("");
  };
  return (
    <Card>
      <CardContent>
        <Typography variant="h6" sx={{ paddingBottom: 4 }}>
          Add a Admin
        </Typography>
        <form autoComplete="off" onSubmit={handleSubmit}>
          <Grid container justifyContent="center" spacing={2}>
            <Grid item xs={6}>
              <TextField
                name="name"
                value={name}
                onChange={(e) => setName(e.target.value)}
                size="small"
                required
                label="Name"
                variant="outlined"
                fullWidth
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                name="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                size="small"
                required
                label="E-mail"
                variant="outlined"
                fullWidth
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                name="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                size="small"
                required
                label="Password"
                type="password"
                variant="outlined"
                fullWidth
              />
            </Grid>
            <Grid item xs={6}>
              <TextField
                name="confirmPassword"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                size="small"
                required
                label="Confirm Password"
                type="password"
                variant="outlined"
                fullWidth
              />
            </Grid>
            <Grid item xs={12}>
              <FormLabel>Role</FormLabel>
              <RadioGroup
                row
                value={role}
                onChange={(e) => setRole(e.target.value)}
              >
                <FormControlLabel
                  value="Admin"
                  control={<Radio />}
                  label="Admin"
                />
                <FormControlLabel
                  value="Garage"
                  control={<Radio />}
                  label="Garage"
                />
                <FormControlLabel
                  value="Insurance Co."
                  control={<Radio />}
                  label="Insurance Co."
                />
              </RadioGroup>
            </Grid>
            <Grid
              item
              xs={12}
              style={{ display:'flex', justifyContent: "center", marginTop: "10px" }}
            >
              <Button
                onClick={handleDeleteClick}
                variant="outlined"
                startIcon={<DeleteIcon />}
                style={{ marginRight: "25px" }}
              >
                Delete
              </Button>
              <Button
                type="submit"
                variant="contained"
                startIcon={<SendIcon />}
                endIcon={<KeyboardArrowRightIcon />}
              >
                Add
              </Button>
            </Grid>
          </Grid>
        </form>
      </CardContent>
    </Card>
  );
};

AddAdmin.propTypes = {
  onAddAdmin: PropTypes.func.isRequired, // Validate onAddUser prop
};

export default AddAdmin;
