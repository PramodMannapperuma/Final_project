import NewRev from "./NewRev";
import ReRev from "./ReRev";
import * as React from "react";
import Box from "@mui/material/Box";
import Tab from "@mui/material/Tab";
import TabContext from "@mui/lab/TabContext";
import TabList from "@mui/lab/TabList";
import TabPanel from "@mui/lab/TabPanel";
import { Grid } from "@mui/material";
import Nav from "../Navigation/Nav";

const ReqDash = () => {
  const [value, setValue] = React.useState("1");

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <div>
      <Nav />
      <Box sx={{ width: "100%", typography: "body1", marginTop: "64px" }}>
        <TabContext value={value}>
          <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
            <TabList onChange={handleChange} aria-label="lab API tabs example">
              <Tab
                sx={{ fontSize: "1.2rem", fontWeight: "bold" }}
                label="Reneval Requests"
                value="1"
              />
              <Tab
                sx={{ fontSize: "1.2rem", fontWeight: "bold" }}
                label="New Revenue Requests"
                value="2"
              />
            </TabList>
          </Box>
          <TabPanel value="1">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <ReRev />
              </Grid>
            </Grid>
          </TabPanel>
          <TabPanel value="2">
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <NewRev />
              </Grid>
            </Grid>
          </TabPanel>
        </TabContext>
      </Box>
    </div>
  );
};

export default ReqDash;
