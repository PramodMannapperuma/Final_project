import Nav from "../Components/Navigation/Nav";
import Stack from "@mui/material/Stack";
import Grid from "@mui/material/Grid";
import Footer from "../footer";
// import Card from "./Card";
import NCard from "./Card";
import NewCard from "./NewCard";
import ImageSlider from "./ImageSlider";
import { Typography } from "@mui/material";
import BasicTabs from "./HomeTab";
import { Box, Paper, } from '@mui/material';
// import { Box, CardMedia, Typography } from "@mui/material";

const Home = () => {
  return (
    <div>
      
      <Nav />
      <BasicTabs />
      
        <ImageSlider />
        
        <Paper elevation={3} style={{ padding: '20px', marginTop: '20px', backgroundColor: '#f0f2f5' }}>
        <Typography variant="h4" gutterBottom align="center">
          Welcome to the MotoManager Hub Admin Dashboard
        </Typography>
        <Typography variant="subtitle1" gutterBottom align="center">
          Your comprehensive platform for managing operations efficiently.
        </Typography>
        <Box mt={4}>
          <Typography variant="body1" paragraph>
            As a valued team member, this dashboard is your gateway to overseeing all operational facets of MotoManager Hub. From here, you can effortlessly manage user accounts, track bookings, adjust settings, and view real-time data analytics to ensure our service meets the highest standards.
          </Typography>
          <Typography variant="h6" gutterBottom>
            Quick Tips:
          </Typography>
          <ul>
            <li>
              <Typography variant="body1">
                <strong>User Management:</strong> View, add, or modify user profiles to ensure everyone gets the support they need.
              </Typography>
            </li>
            <li>
              <Typography variant="body1">
                <strong>Bookings Dashboard:</strong> Keep an eye on ongoing and upcoming rides, and manage disputes or issues as they arise.
              </Typography>
            </li>
            <li>
              <Typography variant="body1">
                <strong>Analytics:</strong> Access comprehensive reports on user engagement, revenue growth, and service utilization to make informed decisions.
              </Typography>
            </li>
          </ul>
          <Typography variant="body1" paragraph>
            We're committed to providing a seamless experience for both our team and our customers. If you need any assistance or have suggestions for improvements, please do not hesitate to reach out.
          </Typography>
          <Typography variant="body2" align="center" color="textSecondary">
            Let’s drive success together!
          </Typography>
        </Box>
      </Paper>

      <Stack
        spacing={4}
        sx={{
          display: "flex",
          mx: "auto",
          px: 30,
          pt: 5,
          //   pb: 5,
        }}
      >
        <Grid container spacing={5}>
          <Grid item xs={6}>
            {/* <NCard /> */}
          </Grid>
          
          <Grid item xs={6}>
            {/* <NewCard /> */}
          </Grid>
        </Grid>
        
      </Stack>
      <Footer />
    </div>
  );
};

export default Home;
