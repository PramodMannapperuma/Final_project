import * as React from "react";
import Box from "@mui/material/Box";
import SwipeableDrawer from "@mui/material/SwipeableDrawer";
import Button from "@mui/material/Button";
import List from "@mui/material/List";
// import Divider from '@mui/material/Divider';
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
// import InboxIcon from '@mui/icons-material/MoveToInbox';
// import MailIcon from '@mui/icons-material/Mail';
import ContactIcon from "@mui/icons-material/ContactMail";
import UserIcon from "@mui/icons-material/Person";
import AdminIcon from "@mui/icons-material/SupervisorAccount";
import EmailIcon from "@mui/icons-material/Email";

export default function BasicTabs() {
  const [drawer1Open, setDrawer1Open] = React.useState(false);
  const [drawer2Open, setDrawer2Open] = React.useState(false);
  const [drawer3Open, setDrawer3Open] = React.useState(false);

  const toggleDrawer1 = (open) => (event) => {
    if (
      event &&
      event.type === "keydown" &&
      (event.key === "Tab" || event.key === "Shift")
    ) {
      return;
    }
    setDrawer1Open(open);
  };

  const toggleDrawer2 = (open) => (event) => {
    if (
      event &&
      event.type === "keydown" &&
      (event.key === "Tab" || event.key === "Shift")
    ) {
      return;
    }
    setDrawer2Open(open);
  };

  const toggleDrawer3 = (open) => (event) => {
    if (
      event &&
      event.type === "keydown" &&
      (event.key === "Tab" || event.key === "Shift")
    ) {
      return;
    }
    setDrawer3Open(open);
  };

  const list1 = (
    <Box
      sx={{ width: 250 }}
      role="presentation"
      onClick={toggleDrawer1(false)}
      onKeyDown={toggleDrawer1(false)}
    >
      <List>
        {[
          { text: "Contact", icon: <ContactIcon /> },
          { text: "User", icon: <UserIcon /> },
          { text: "Admin", icon: <AdminIcon /> },
          { text: "Email", icon: <EmailIcon /> },
        ].map((item, index) => (
          <ListItem key={item.text} disablePadding>
            <ListItemButton>
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </Box>
  );

  const list2 = (
    <Box
      sx={{ width: 250,}}
      role="presentation"
      onClick={toggleDrawer2(false)}
      onKeyDown={toggleDrawer2(false)}
    >
      <List>
        {[
          { text: "Contact", icon: <ContactIcon /> },
          { text: "User", icon: <UserIcon /> },
          { text: "Admin", icon: <AdminIcon /> },
          { text: "Email", icon: <EmailIcon /> },
        ].map((item, index) => (
          <ListItem key={item.text} disablePadding>
            <ListItemButton>
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </Box>
  );

  const list3 = (
    <Box
      sx={{ width: 250,}}
      role="presentation"
      onClick={toggleDrawer3(false)}
      onKeyDown={toggleDrawer3(false)}
    >
      <List>
        {[
          { text: "Contact", icon: <ContactIcon /> },
          { text: "User", icon: <UserIcon /> },
          { text: "Admin", icon: <AdminIcon /> },
          { text: "Email", icon: <EmailIcon /> },
        ].map((item, index) => (
          <ListItem key={item.text} disablePadding>
            <ListItemButton>
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </Box>
  );

  return (
    <div>
      <Button sx={{marginTop: '60px'}} onClick={toggleDrawer1(true)}>Open Drawer 1</Button>
      <Button sx={{marginTop: '60px'}} onClick={toggleDrawer2(true)}>Open Drawer 2</Button>
      <Button sx={{marginTop: '60px'}} onClick={toggleDrawer3(true)}>Open Drawer 3</Button>
      <SwipeableDrawer
        anchor="top"
        open={drawer1Open}
        onClose={toggleDrawer1(false)}
        onOpen={toggleDrawer1(true)}
      >
        {list1}
      </SwipeableDrawer>
      <SwipeableDrawer
        anchor="top"
        open={drawer2Open}
        onClose={toggleDrawer2(false)}
        onOpen={toggleDrawer2(true)}
      >
        {list2}
      </SwipeableDrawer>
      <SwipeableDrawer
        anchor="top"
        open={drawer3Open}
        onClose={toggleDrawer3(false)}
        onOpen={toggleDrawer3(true)}
      >
        {list3}
      </SwipeableDrawer>
    </div>
  );
}
