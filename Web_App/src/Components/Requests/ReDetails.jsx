import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Paper, Typography, Table, TableContainer, TableBody, TableRow, TableCell, Button, CircularProgress, Grid } from "@mui/material";
import CheckIcon from "@mui/icons-material/Check";
import { doc, getDoc } from "firebase/firestore";
import { firestore } from "../../firebase";
import { Link as RouterLink } from 'react-router-dom';
const ReDetails = () => {
  const { id } = useParams();
  const [rowData, setRowData] = useState(null);
  const [fileData, setFileData] = useState([]);
  const [vehicleDetails, setVehicleDetails] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      const docRef = doc(firestore, "fileIds", id);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        const fileIds = docSnap.data();
        const files = [
          { key: 'certificate', url: fileIds.certificateUrl, name: 'Certificate Document', description: 'Document certifying the vehicle compliance.' },
          { key: 'ecoTest', url: fileIds.ecoTestUrl, name: 'Eco Test Document', description: 'Results of the ecological impact test.' },
          { key: 'insurance', url: fileIds.insuranceUrl, name: 'Insurance Document', description: 'Proof of current insurance coverage.' }
        ];

        const vehicleData = fileIds.vehicleData;
        setVehicleDetails({
          ...vehicleData,
          email: vehicleData.email // Optionally include more details
        });

        setFileData(files);
      } else {
        console.log("No such document!");
      }
      setLoading(false);
    };

    fetchData();
  }, [id]);

  return (
    <Paper
      elevation={3}
      style={{
        padding: "20px",
        maxWidth: "800px",
        margin: "auto",
        marginTop: "50px",
      }}
    >
      <Typography variant="h5" gutterBottom>
        Detail Page for ID: {id}
      </Typography>
      {loading ? (
        <CircularProgress style={{ display: 'block', margin: '20px auto' }} />
      ) : (
        <>
          <TableContainer>
            <Table>
              <TableBody>
                {fileData.map((file, index) => (
                  <TableRow key={index}>
                    <TableCell>{file.name}</TableCell>
                    <TableCell>{file.description}</TableCell>
                    <TableCell>
                      <Button
                        variant="contained"
                        color="primary"
                        startIcon={<CheckIcon />}
                        onClick={() => window.open(file.url, "_blank")}
                      >
                        View
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
          {vehicleDetails && (
              <Grid container spacing={2}>
              <Grid item xs={6}><Typography>Make: {vehicleDetails.make}</Typography></Grid>
              <Grid item xs={6}><Typography>Model: {vehicleDetails.model}</Typography></Grid>
              <Grid item xs={6}><Typography>Year: {vehicleDetails.year}</Typography></Grid>
              <Grid item xs={6}><Typography>Engine Type: {vehicleDetails.engineType}</Typography></Grid>
              <Grid item xs={6}><Typography>Horse Power: {vehicleDetails.horsePower}</Typography></Grid>
              <Grid item xs={6}><Typography>License Plate Number: {vehicleDetails.licensePlateNumber}</Typography></Grid>
              <Grid item xs={6}><Typography>Color: {vehicleDetails.color}</Typography></Grid>
              <Grid item xs={6}><Typography>VIN: {vehicleDetails.vin}</Typography></Grid>
              <Grid item xs={6}><Typography>Fuel Type: {vehicleDetails.fuelType}</Typography></Grid>
            </Grid>
          )}
                  <div style={{ marginTop: '20px' }}>
            {/* Generate License Button */}
            <Button
                component={RouterLink}
                to={`/revenue/${id}`}
                variant="contained"
                color="primary"
                style={{ marginRight: '10px' }}  // Add some margin if needed
            >
                Generate License
            </Button>

            {/* Back to List Button */}
            <Button
                component={RouterLink}
                to="/reqdash"
                variant="contained"
                color="primary"
            >
                Back to List
            </Button>
        </div>
        </>
      )}
    </Paper>
  );
};

export default ReDetails;
