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
import AddUser from "./AddUser"; // Import AddUser component here
import { collection, getDocs, deleteDoc, doc } from "firebase/firestore";
import { firestore } from "../../firebase"; // Adjust the import path as per your project structure
// import { deleteUser } from 'firebase/auth';

function User() {
  const [users, setUsers] = useState([]);

  // Fetch user data from Firestore when the component mounts
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, "users"));
        const userData = querySnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setUsers(userData);
      } catch (error) {
        console.error("Error fetching users:", error);
      }
    };
    fetchUsers();
  }, []); // Empty dependency array to fetch data only once when the component mounts

  const handleDelete = async (uid) => {
    try {
      // Step 1: Delete user document from Firestore
      await deleteDoc(doc(firestore, "users", uid));

      // Step 2: Delete user from Firebase Authentication
      // await deleteUser(auth, email);

      // Filter out the deleted user from the state
      const updatedUsers = users.filter((user) => user.id !== uid);

      // Update the state with the filtered user list
      setUsers(updatedUsers);
      console.log("deleted user");
    } catch (error) {
      console.error("Error deleting user:", error);
    }
  };

  const handleUpdate = (userId) => {
    // Implement update logic here
    console.log("Update user with ID:", userId);
    // Perform further actions, such as opening a modal or navigating to an edit page
  };

  const handleAddUser = (newUser) => {
    // Update the user list with the new user
    setUsers((prevUsers) => [...prevUsers, newUser]);
  };

  return (
    <Grid container spacing={2}>
      <Grid item xs={6}>
        <Card>
          <CardContent>
            <List>
              {users.map((user) => (
                <ListItem key={user.id} alignItems="flex-start">
                  <ListItemAvatar>
                    <Avatar alt={user.name} src={user.avatarUrl} />
                  </ListItemAvatar>
                  <ListItemText
                    primary={user.name}
                    secondary={
                      <React.Fragment>
                        <Typography
                          sx={{ display: "inline" }}
                          component="span"
                          variant="body2"
                          color="text.primary"
                        >
                          Email: {user.email}
                        </Typography>
                      </React.Fragment>
                    }
                  />
                  <ListItemSecondaryAction>
                    <IconButton
                      sx={{ padding: 4 }}
                      edge="end"
                      aria-label="edit"
                      onClick={() => handleUpdate(user.id)}
                    >
                      <EditIcon />
                    </IconButton>
                    <IconButton
                      sx={{ padding: 4, color: "red" }}
                      edge="end"
                      aria-label="delete"
                      onClick={() => handleDelete(user.id, user.email)}
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
        <AddUser onAddUser={handleAddUser} />{" "}
        {/* Render AddUser component and pass handleAddUser function */}
      </Grid>
    </Grid>
  );
}

export default User;
