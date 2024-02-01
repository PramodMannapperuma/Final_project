import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import DeleteIcon from "@mui/icons-material/Delete";
import SendIcon from "@mui/icons-material/Send";
import Container from "@mui/material/Container";
import KeyboardArrowRightIcon from "@mui/icons-material/KeyboardArrowRight";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid"; // Import Grid component
import { useState } from "react";
import Radio from "@mui/material/Radio";
import RadioGroup from "@mui/material/RadioGroup";
import FormControlLabel from '@mui/material/FormControlLabel';
import FormLabel from '@mui/material/FormLabel';
import { Link } from "react-router-dom";

const SignUp = () => {
  const [FName, setFName] = useState('');
  const [LName, setLName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [gender, setGender] = useState('');

  // const [formDataError, setFormDataError] = useState(false)

  const handleSubmit = (e) => {
    e.preventDefault();
    // const { FName, LName, email, password } = e.target.value;
    if (FName && LName && email && password && gender) {
      console.log(FName, LName, email, password, gender);
      // Here you can perform any actions like submitting the form data
    }
  };

  const handleDeleteClick = () => {
    // Clear the form data
    setFName('');
    setLName('');
    setEmail('');
    setPassword('');
    setConfirmPassword('');
    setGender('Female');
  };



  return (
    <Container maxWidth='sm' style={{marginTop:'150px'}}>
      <Typography variant="h5" component="h2" gutterBottom color="textPrimary">
        SignUp
      </Typography>
      <form autoComplete="off" onSubmit={handleSubmit}>
        <Grid container justifyContent='center' spacing={2}>
          <Grid item xs={6}>
            <TextField
              name="FName"
              value={FName}
              onChange={ (e)=> setFName(e.target.value)}
              size="small"
              required
              label="First Name"
              variant="outlined"
              fullWidth
              // error={formData.FName === ""}
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              name="LName"
              value={LName}
              onChange={ (e) => setLName(e.target.value)}
              size="small"
              required
              label="Last Name"
              variant="outlined"
              fullWidth
              // error={formData.LName === ""}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              name="email"
              value={email}
              onChange={ (e) => setEmail(e.target.value)}
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
              onChange={ (e) => setPassword(e.target.value)}
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
              onChange={ (e) => setConfirmPassword(e.target.value)}
              size="small"
              required
              label="Confirm Password"
              type="password"
              variant="outlined"
              fullWidth
            />
          </Grid>
          <Grid item xs={12} >
            <FormLabel>Gender</FormLabel>
            <RadioGroup row value={gender} onChange={(e) => setGender(e.target.value)}>
              <FormControlLabel value="Male" control={<Radio />} label="Male" />
              <FormControlLabel value="Female" control={<Radio />} label="Female" />
              <FormControlLabel value="Other" control={<Radio />} label="Other" />
            </RadioGroup>
          </Grid>
        </Grid>
        <Grid  style={{ display: 'flex', justifyContent: 'center',marginTop:'20px' }} item xs={12}>
        <Button
          onClick={handleDeleteClick}
          variant="outlined"
          startIcon={<DeleteIcon />}
          style={{ marginRight: '25px',}}
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
          Send
        </Button>
        </Grid>
        <Grid item xs={12}>
          <Typography padding={2} variant="body2" color="textSecondary" align="center">
            Already have an account? <Link to="/login">Login</Link> 
          </Typography>
        </Grid>
      </form>
    </Container>
  );
};

export default SignUp;
