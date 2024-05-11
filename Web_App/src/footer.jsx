import { Typography, Container, Box } from "@mui/material";
import { Instagram, Facebook, Twitter } from '@mui/icons-material';  // Import social media icons

const Footer = () => {
  return (
    <footer style={{
      backgroundColor: "#333",
      color: "#fff",
      padding: "50px 0",
      borderTop: "5px solid #1976d2"  // Add a colored border top for a little flair
    }}>
      <Container maxWidth="lg">
        <Box display="flex" justifyContent="center" alignItems="center" flexDirection="column">
          {/* Social Media Icons */}
          <Box mb={2}>
            <Instagram style={{ color: '#fff', marginRight: '10px', cursor: 'pointer' }} />
            <Facebook style={{ color: '#fff', marginRight: '10px', cursor: 'pointer' }} />
            <Twitter style={{ color: '#fff', cursor: 'pointer' }} />
          </Box>

          {/* Main Text */}
          <Typography variant="body1" align="center" gutterBottom>
            Connecting Riders and Drivers.
          </Typography>

          {/* Sub Text */}
          <Typography variant="caption" align="center" display="block" style={{ opacity: 0.7 }}>
            Follow us on social media for updates.
          </Typography>

          {/* Copyright Notice */}
          <Typography variant="body2" align="center" style={{ marginTop: '20px' }}>
            © 2024 MotoManager Hub. All rights reserved.
          </Typography>
        </Box>
      </Container>
    </footer>
  );
};

export default Footer;