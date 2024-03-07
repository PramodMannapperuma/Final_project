import React, { useState, useEffect } from "react";
import {
  List,
  ListItem,
  ListItemText,
  ListItemAvatar,
  Avatar,
  Typography,
  IconButton,
  ListItemSecondaryAction,
  Card,
  CardContent,
  Grid,
} from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import AddAdmin from "./AddAdmin";
import { collection, getDocs, deleteDoc, doc } from "firebase/firestore";
import { firestore } from "../../firebase"; // Adjust the import path as per your project structure

function Admin() {
  const [admins, setAdmins] = useState([]);

  useEffect(() => {
    const fetchAdmins = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, "admins"));
        const adminData = querySnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setAdmins(adminData);
      } catch (error) {
        console.error("Error fetching admins:", error);
      }
    };
    fetchAdmins();
  }, []);

  const handleDelete = async (adminId) => {
    try {
      await deleteDoc(doc(firestore, "admins", adminId));
      const updatedAdmins = admins.filter((admin) => admin.id !== adminId);
      setAdmins(updatedAdmins);
    } catch (error) {
      console.error("Error deleting admin:", error);
    }
  };

  const handleUpdate = (adminId) => {
    console.log("Updating admin with ID:", adminId);
    // Implement update logic here
  };

  const handleAddAdmin = (newAdmin) => {
    setAdmins((prevAdmins) => [...prevAdmins, newAdmin]);
  };

  return (
    <Grid container spacing={2}>
      <Grid item xs={6}>
        <Card>
          <CardContent>
            <List>
              {admins.map((admin) => (
                <ListItem key={admin.id} alignItems="flex-start">
                  <ListItemAvatar>
                    <Avatar alt={admin.name} src={admin.avatarUrl} />
                  </ListItemAvatar>
                  <ListItemText
                    primary={admin.name}
                    secondary={
                      <React.Fragment>
                        <Typography
                          sx={{ display: "inline" }}
                          component="span"
                          variant="body2"
                          color="text.primary"
                        >
                          Email: {admin.email}
                        </Typography>
                      </React.Fragment>
                    }
                  />
                  <ListItemSecondaryAction>
                    <IconButton
                      sx={{ padding: 4 }}
                      edge="end"
                      aria-label="edit"
                      onClick={() => handleUpdate(admin.id)}
                    >
                      <EditIcon />
                    </IconButton>
                    <IconButton
                      sx={{ padding: 4, color: "red" }}
                      edge="end"
                      aria-label="delete"
                      onClick={() => handleDelete(admin.id)}
                    >
                      <DeleteIcon />
                    </IconButton>
                  </ListItemSecondaryAction>
                </ListItem>
              ))}
            </List>
          </CardContent>
        </Card>
      </Grid>
      <Grid item xs={6}>
        <AddAdmin onAddAdmin={handleAddAdmin} />
      </Grid>
    </Grid>
  );
}

export default Admin;
