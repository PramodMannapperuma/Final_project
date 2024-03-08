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
import PropTypes from "prop-types";
import { collection, addDoc } from "firebase/firestore";
import { auth, firestore } from "../../firebase"; // Adjust the import path as per your project structure
import { createUserWithEmailAndPassword } from "firebase/auth";
const AddUser = ({ onAddUser }) => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [role, setRole] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    // Check if password matches confirmPassword
    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    try {
      const userCredentials = await createUserWithEmailAndPassword(
        auth,
        email,
        password
      );
      const newUsr = userCredentials.user;

      if (!newUsr) {
        console.error("User does not exist");
        return;
      }

      // Create user object
      const newUser = {
        name,
        email,
        password,
        role,
        userId: newUsr.uid, // Save the user ID associated with this user
      };

      // Save user data to Firestore
      const docRef = await addDoc(collection(firestore, "users"), newUser);
      newUser.id = docRef.id; // Add the document ID to the user object

      onAddUser(newUser); // Invoke the callback function with the new user object

      setName("");
      setEmail("");
      setPassword("");
      setConfirmPassword("");
      setRole("");
    } catch (error) {
      console.error("Error adding user: ", error);
      // Handle error here (e.g., show an error message to the user)
    }
  };

  const handleDeleteClick = () => {
    // Clear the form data
    setName("");
    setEmail("");
    setPassword("");
    setConfirmPassword("");
    setRole("");
  };

  return (
    <Card>
      <CardContent>
        <Typography variant="h6" sx={{ paddingBottom: 4 }}>
          Add a User
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
            <Grid item xs={12} style={{ justifyContent: "center" }}>
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
                  value="Insurence Co."
                  control={<Radio />}
                  label="Insurance Co."
                />
              </RadioGroup>
            </Grid>
            <Grid
              style={{
                display: "flex",
                justifyContent: "center",
                marginTop: "10px",
              }}
              item
              xs={12}
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

AddUser.propTypes = {
  onAddUser: PropTypes.func.isRequired, // Validate onAddUser prop
};

export default AddUser;
