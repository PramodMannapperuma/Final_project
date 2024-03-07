import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import { Link } from 'react-router-dom';

export default function NCard() {
  return (
    <Card sx={{minWidth: 400}} >
      <CardContent>
        <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
          Word of the Day
        </Typography>
        <Typography variant="h5" component="div">
          Reveneu License 
        </Typography>
        <Typography variant="body2">
          Need Insurence, Revenue Liscense, or any other document? Request it here.
          <br />
        </Typography>
      </CardContent>
      <CardActions>
        <Button size="small" component={Link} to="/landing">Learn More</Button>
      </CardActions>
    </Card>
  );
}