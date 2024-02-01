import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import DeleteIcon from "@mui/icons-material/Delete";
import SendIcon from "@mui/icons-material/Send";
import Container from "@mui/material/Container";
import KeyboardArrowRightIcon from "@mui/icons-material/KeyboardArrowRight";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid"; // Import Grid component
import { useState } from "react";
import { useNavigate } from "react-router-dom";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    // const { FName, LName, email, password } = e.target.value;
    if (email && password) {
      console.log(email, password);
      navigate('/home');
      // Here you can perform any actions like submitting the form data
    }
  };

  const handleDeleteClick = () => {
    // Clear the form data
    setEmail("");
    setPassword("");
  };

  return (
    <Container maxWidth="sm" style={{ marginTop: "150px" }}>
      <Typography variant="h5" component="h2" gutterBottom color="textPrimary">
        Login
      </Typography>
      <form autoComplete="off" onSubmit={handleSubmit}>
        <Grid container justifyContent="center" spacing={2}>
          <Grid item xs={12}>
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
          <Grid item xs={12}>
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
          <Grid
            style={{
              display: "flex",
              justifyContent: "center",
              marginTop: "20px",
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
              Send
            </Button>
          </Grid>
        </Grid>
      </form>
    </Container>
  );
};

export default Login;
