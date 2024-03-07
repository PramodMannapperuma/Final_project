import * as React from "react";
import Box from "@mui/material/Box";
import Tab from "@mui/material/Tab";
import TabContext from "@mui/lab/TabContext";
import TabList from "@mui/lab/TabList";
import TabPanel from "@mui/lab/TabPanel";
import Nav from "../Navigation/Nav";
import Admin from "./Admin";
import { Grid } from "@mui/material";
import Garage from "./GarageCard";
import InsurenceCo from "./InsurenceCo";
import User from "./User";

export default function Dashboard() {
  const [value, setValue] = React.useState("1");

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <div>
      <Nav />
      <Box sx={{ width: "100%", typography: "body1", marginTop: '64px' }}>
        <TabContext value={value}>
          <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
            <TabList onChange={handleChange} aria-label="lab API tabs example">
              <Tab sx={{ fontSize: "1.5rem", fontWeight:'bold' }} label="User Panel" value="1" />
              <Tab sx={{ fontSize: "1.5rem", fontWeight:'bold' }} label="Admin Panel" value="2" />
              <Tab sx={{ fontSize: "1.5rem", fontWeight:'bold'}} label="Garage Panel" value="3" />
              <Tab sx={{ fontSize: "1.5rem", fontWeight:'bold'}} label="Insurance Co." value="4" />
            </TabList>
          </Box>
          <TabPanel value="1">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <User />
              </Grid>
            </Grid>
          </TabPanel>
          <TabPanel value="2">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <Admin />
              </Grid>
            </Grid>
          </TabPanel>
          <TabPanel value="3">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <Garage />
              </Grid>
            </Grid>
          </TabPanel>
          <TabPanel value="4">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <InsurenceCo />
              </Grid>
              
            </Grid>
          </TabPanel>
        </TabContext>
      </Box>
    </div>
  );
}


// import Nav from "../Navigation/Nav";
// import AddInsurence from "./AddInsurence";
// import AddAdmin from "./AddAdmin";
// import Garage from "./GarageCard";
// import InsurenceCo from "./InsurenceCo";
// import User from "./Admin";
// import { Grid, Stack } from "@mui/material";
// import AddGarage from "./AddGarage";

// const Dashbord = () => {
//   return (
//     <div>
//       <Nav />
//       <Stack
//         spacing={4}
//         sx={{
//           display: "flex",
//           mx: "auto",
//           px: 10,
//           pt: 5,
//           //   pb: 5,
//         }}
//       >
//         <Grid container spacing={2}>
//           {/* <Grid item spacing={14} sx={12}>
//             <Garage />
//           </Grid> */}
//           <Grid item xs={6}>
//             <InsurenceCo />
//           </Grid>
//           <Grid item xs={6}>
//             <AddInsurence />
//           </Grid>
//           <Grid item xs={6}>
//             <Garage />
//           </Grid>
//           <Grid item xs={6}>
//             <AddGarage />
//           </Grid>
//           <Grid item xs={6}>
//             <User />
//           </Grid>
//           <Grid item xs={6}>
//             <AddAdmin />
//           </Grid>
//         </Grid>
//         {/* <Garage />
//         <InsurenceCo />
//         <AddInsurence />
//         <User /> */}
//       </Stack>
//     </div>
//   );
// };

// export default Dashbord;
