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
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import PropTypes from "prop-types";
import { collection, addDoc } from "firebase/firestore";
import { firestore, auth } from "../../firebase";
import { createUserWithEmailAndPassword } from "firebase/auth";

const AddGarage = ({ onAddGarage }) => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [ConfirmPassword, setConfirmPassword] = useState("");
  const [role, setRole] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (password !== ConfirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    try {
      const garageCredentials = await createUserWithEmailAndPassword(
        auth,
        email,
        password
      );
      const newGarag = garageCredentials.user;

      if (!newGarag.uid) {
        console.error("uid not found");
        return;
      }
      const newGarage = {
        name,
        email,
        password,
        role,
        userId: newGarag.uid,
      };

      const docRef = await addDoc(collection(firestore, "garages"), newGarage);
      newGarage.id = docRef.id;

      onAddGarage(newGarage);

      setName("");
      setEmail("");
      setPassword("");
      setConfirmPassword("");
      setRole("");
      navigate("/dashbord"); // Redirect to dashboard after adding admin
    } catch (error) {
      console.error("Error adding admin: ", error);
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
          Add a Service Station
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
                //   type="password"
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
                name="Confirmpassword"
                value={ConfirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                size="small"
                required
                label="Confirm Password"
                type="password"
                variant="outlined"
                fullWidth
              />
            </Grid>
            <Grid
              item
              xs={12}
              style={{
                justifyContent: "center",
              }}
            >
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
                  label="Insurence Co."
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
                // style={{display: "flex"}}
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

AddGarage.propTypes = {
  onAddGarage: PropTypes.func.isRequired, // Validate onAddUser prop
};

export default AddGarage;
