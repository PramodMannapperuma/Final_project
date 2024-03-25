import React, { useState, useEffect } from 'react';
import { List, ListItem, ListItemText, ListItemAvatar, Avatar, Typography, IconButton, ListItemSecondaryAction, Card, CardContent, Grid } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import EditIcon from '@mui/icons-material/Edit';
import AddInsurence from './AddInsurence';
import { collection, getDocs, deleteDoc, doc } from 'firebase/firestore';
import { firestore } from '../../firebase';
// import { deleteUser } from 'firebase/auth';

function InsurenceCo() {
  const [insurances, setInsurances] = useState([]);

  useEffect(() => {
    const fetchInsurances = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, 'insurenceCo'));
        const insuranceData = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        setInsurances(insuranceData);
      } catch (error) {
        console.error('Error fetching insurances:', error);
      }
    };
    fetchInsurances();
  }, []);

  const handleDelete = async (insuranceId) => {
    try {
      await deleteDoc(doc(firestore, 'insurenceCo', insuranceId));
      // await deleteUser(auth, email);
      const updatedInsurances = insurances.filter(insurance => insurance.id !== insuranceId);
      setInsurances(updatedInsurances);
    } catch (error) {
      console.error('Error deleting insurance:', error);
    }
  };

  const handleUpdate = (insuranceId) => {
    // Implement update logic here
    console.log('Updating insurance with ID:', insuranceId);
    // Perform further actions, such as opening a modal or navigating to an edit page
  };

  const handleAddInsurence = (newInsurance) => {
    // Update the insurance list with the new insurance
    setInsurances(prevInsurances => [...prevInsurances, newInsurance]);
  };

  return (
    <Grid container spacing={2}>
      <Grid item xs={6}>
        <Card>
          <CardContent>
            <List>
              {insurances.map(insurance => (
                <ListItem key={insurance.id} alignItems="flex-start">
                  <ListItemAvatar>
                    <Avatar alt={insurance.name} src={insurance.avatarUrl} />
                  </ListItemAvatar>
                  <ListItemText
                    primary={insurance.name}
                    secondary={
                      <React.Fragment>
                        <Typography
                          sx={{ display: 'inline' }}
                          component="span"
                          variant="body2"
                          color="text.primary"
                        >
                          Email: {insurance.email}
                        </Typography>
                      </React.Fragment>
                    }
                  />
                  <ListItemSecondaryAction>
                    {/* <IconButton sx={{padding:4}} edge="end" aria-label="edit" onClick={() => handleUpdate(insurance.id)}>
                      <EditIcon />
                    </IconButton> */}
                    <IconButton sx={{padding:4, color:'red'}} edge="end" aria-label="delete" onClick={() => handleDelete(insurance.id)}>
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
        <AddInsurence onAddInsurence={handleAddInsurence} />
      </Grid>
    </Grid>
  );
}

export default InsurenceCo;
