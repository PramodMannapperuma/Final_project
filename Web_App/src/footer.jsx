import { Typography, Container } from "@mui/material";

const Footer = () => {
  return (
    <footer style={{ backgroundColor: "#333", color: "#fff", padding: "50px 0" }}>
      <Container maxWidth="lg">
        <Typography variant="body1" align="center">
          © 2024 MotoManager Hub. All rights reserved.
        </Typography>
      </Container>
    </footer>
  );
};

export default Footer;
