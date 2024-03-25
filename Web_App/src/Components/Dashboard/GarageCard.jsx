import React, { useState, useEffect } from "react";
import {
  List,
  Grid,
  ListItem,
  ListItemText,
  ListItemAvatar,
  Avatar,
  Typography,
  IconButton,
  ListItemSecondaryAction,
  Card,
  CardContent,
} from "@mui/material";
import DeleteIcon from "@mui/icons-material/Delete";
import EditIcon from "@mui/icons-material/Edit";
import AddGarage from "./AddGarage";
import { collection, getDocs, deleteDoc, doc } from "firebase/firestore";
import { firestore } from "../../firebase";

function Garage() {
  const [garages, setGarages] = useState([]);

  useEffect(() => {
    const fetchGarages = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, "garages"));
        const garageData = querySnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setGarages(garageData);
      } catch (error) {
        console.error("Error fetching garages:", error);
      }
    };
    fetchGarages();
  }, []);

  const handleDelete = async (garageId) => {
    try {
      await deleteDoc(doc(firestore, "garages", garageId));
      const updatedGarages = garages.filter((garage) => garage.id !== garageId);
      setGarages(updatedGarages);
    } catch (error) {
      console.error("Error deleting garage:", error);
    }
  };

  const handleUpdate = (garageId) => {
    console.log("Updating garage with ID:", garageId);
    // Implement update logic here
  };

  const handleAddGarage = (newGarage) => {
    setGarages((prevGarages) => [...prevGarages, newGarage]);
    // Hide the AddGarage component after adding the garage
  };

  return (
    <Grid container spacing={2}>
      <Grid item xs={6}>
        <Card>
          <CardContent>
            <List>
              {garages.map((garage) => (
                <ListItem key={garage.id} alignItems="flex-start">
                  <ListItemAvatar>
                    <Avatar alt={garage.name} src={garage.avatarUrl} />
                  </ListItemAvatar>
                  <ListItemText
                    primary={garage.name}
                    secondary={
                      <React.Fragment>
                        <Typography
                          sx={{ display: "inline" }}
                          component="span"
                          variant="body2"
                          color="text.primary"
                        >
                          Email: {garage.email}
                        </Typography>
                      </React.Fragment>
                    }
                  />
                  <ListItemSecondaryAction>
                    {/* <IconButton
                      sx={{ padding: 4 }}
                      edge="end"
                      aria-label="edit"
                      onClick={() => handleUpdate(garage.id)}
                    >
                      <EditIcon />
                    </IconButton> */}
                    <IconButton
                      sx={{ padding: 4, color: "red" }}
                      edge="end"
                      aria-label="delete"
                      onClick={() => handleDelete(garage.id)}
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
        <AddGarage onAddGarage={handleAddGarage} />
      </Grid>
    </Grid>
  );
}

export default Garage;