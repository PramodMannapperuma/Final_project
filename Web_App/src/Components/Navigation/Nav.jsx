// import React from 'react';
import { AppBar, Toolbar, IconButton, Typography, Button } from '@mui/material';
import { Link } from 'react-router-dom';
import MenuIcon from '@mui/icons-material/Menu';

function Nav() {
  return (
    <AppBar position="fixed">
      <Toolbar>
        {/* <IconButton edge="start" color="inherit" aria-label="menu">
          <MenuIcon />
        </IconButton> */}
        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
          Hello
        </Typography>
        <Button component={Link} to='/' color="inherit">Home</Button>
        <Button color="inherit">Services</Button>
        <Button component={Link} to="/dashbord" color="inherit">Users</Button>
        <Button component={Link} to="/revenue" color="inherit">About</Button>
        <Button component={Link} to="/login" color="inherit">Login</Button>
      </Toolbar>
    </AppBar>
  );
}

export default Nav;
