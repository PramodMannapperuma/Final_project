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
// import { Box, CardMedia, Typography } from "@mui/material";

const Home = () => {
  return (
    <div>
      
      <Nav />
      <BasicTabs />
      
        <ImageSlider />
        
        <Typography variant="h6">Lorem ipsum dolor sit amet consectetur adipisicing elit.
         Rem reprehenderit esse repudiandae non temporibus itaque, illum quod magnam pariatur? 
         Ad illo quae inventore, odio repellat velit consequatur impedit voluptatem modi?
         Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem porro totam illum dolorum
          quaerat consequatur, doloremque est iure. Atque, repellendus
          recusandae ab, placeat, iusto inventore quaerat ut corrupti natus libero vitae ex.
         </Typography>

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
            <NCard />
          </Grid>
          
          <Grid item xs={6}>
            <NewCard />
          </Grid>
        </Grid>
        
      </Stack>
      <Footer />
    </div>
  );
};

export default Home;
