import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import DeleteIcon from "@mui/icons-material/Delete";
import SendIcon from "@mui/icons-material/Send";
import Container from "@mui/material/Container";
import KeyboardArrowRightIcon from "@mui/icons-material/KeyboardArrowRight";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid"; // Import Grid component
import { useState } from "react";

const SignUp = () => {
  const [formData, setFormData] = useState({
    FName: "",
    LName: "",
    email: "",
    password: "",
    confirmPassword: ""
  });

  const [formDataError, setFormDataError] = useState(false)

  const handleSubmit = (e) => {
    e.preventDefault();
    const { FName, LName, email, password } = formData;
    if (FName && LName && email && password) {
      console.log(FName, LName, email, password);
      // Here you can perform any actions like submitting the form data
    }
  };

  const handleDeleteClick = () => {
    // Clear the form data
    setFormData({
      FName: "",
      LName: "",
      email: "",
      password: "",
      confirmPassword: ""
    });
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value
    }));
  };

  return (
    <Container>
      <Typography variant="h5" component="h2" gutterBottom color="textPrimary">
        SignUp
      </Typography>
      <form autoComplete="off" onSubmit={handleSubmit}>
        <Grid container spacing={2}>
          <Grid item xs={6}>
            <TextField
              name="FName"
              value={formData.FName}
              onChange={handleInputChange}
              size="small"
              required
              label="First Name"
              variant="outlined"
              fullWidth
              error={formData.FName === ""}
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              name="LName"
              value={formData.LName}
              onChange={handleInputChange}
              size="small"
              required
              label="Last Name"
              variant="outlined"
              fullWidth
              error={formData.LName === ""}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              name="email"
              value={formData.email}
              onChange={handleInputChange}
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
              value={formData.password}
              onChange={handleInputChange}
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
              value={formData.confirmPassword}
              onChange={handleInputChange}
              size="small"
              required
              label="Confirm Password"
              type="password"
              variant="outlined"
              fullWidth
            />
          </Grid>
        </Grid>
        <Button onClick={handleDeleteClick} variant="outlined" startIcon={<DeleteIcon />}>
          Delete
        </Button>
        <Button type="submit" variant="contained" startIcon={<SendIcon />} endIcon={<KeyboardArrowRightIcon />}>
          Send
        </Button>
      </form>
    </Container>
  );
};

export default SignUp;
