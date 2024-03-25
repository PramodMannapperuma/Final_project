// import * as React from 'react';
// import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

// const bull = (
//   <Box
//     component="flex"
//     sx={{ display: 'inline-block', mx: '2px', transform: 'scale(0.8)' }}
//   >
//     •
//   </Box>
// );

export default function NewCard() {
  return (
    <Card sx={{ minWidth: 275}}>
      <CardContent>
        
        <Typography variant="h5" component="div">
          Request A report for a vehicle
        </Typography>
        
        <Typography variant="body2">
          Get the report that you need for your vehicle.
          <br />
          Request it here.
        </Typography>
      </CardContent>
      <CardActions>
        <Button size="small">Learn More</Button>
      </CardActions>
    </Card>
  );
}