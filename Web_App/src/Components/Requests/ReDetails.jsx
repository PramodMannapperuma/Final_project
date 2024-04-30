import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Paper, Typography, Table, TableContainer, TableBody, TableRow, TableCell, Button, CircularProgress } from "@mui/material";
import CheckIcon from "@mui/icons-material/Check";
import { firestore } from "../../firebase";
import { doc, getDoc } from "firebase/firestore";

const ReDetails = () => {
  const { id } = useParams();
  const [rowData, setRowData] = useState(null);
  const [fileData, setFileData] = useState([]);
  const [vehicleDetails, setVehicleDetails] = useState();
  const [loading, setLoading] = useState(true);  // State to handle loading indicator

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);  // Start loading
      const docRef = doc(firestore, "fileIds", id);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        setRowData(docSnap.data());
        const fileIds = docSnap.data(); // Contains { certificateId, ecoTestId, insuranceId }
        const files = [];

        // Use URLs directly from Firestore
        const certificateUrl = fileIds.certificateUrl;
        const ecoTestUrl = fileIds.ecoTestUrl;
        const insuranceUrl = fileIds.insuranceUrl;


        // Create file objects with URLs
        files.push({ key: 'certificateUrl', url: certificateUrl, name: 'Certificate Document' });
        files.push({ key: 'ecoTestUrl', url: ecoTestUrl, name: 'Eco Test Document' });
        files.push({ key: 'insuranceUrl', url: insuranceUrl, name: 'Insurance Document' });

        const vehicleData = fileIds.vehicleData;
        const vehicleDetails = {
          make: vehicleData.make,
          model: vehicleData.model,
          year: vehicleData.year,
          engineType: vehicleData.engineType,
          horsePower: vehicleData.horsePower,
          licensePlateNumber: vehicleData.licensePlateNumber,
          color: vehicleData.color,
          vin: vehicleData.vin,
          fuelType: vehicleData.fuelType,
          email: vehicleData.email
          // Add more vehicle details as needed
        };
        console.log(vehicleDetails);
        setVehicleDetails(vehicleDetails);

        setFileData(files);
      } else {
        console.log("No such document!");
      }
      setLoading(false);  // Stop loading
    };

    fetchData();
  }, [id]);

  return (
    <Paper
      elevation={3}
      style={{
        padding: "20px",
        maxWidth: "600px",
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
                    <TableCell>{file.key.charAt(0).toUpperCase() + file.key.slice(1)}</TableCell>
                    <TableCell>{file.name}</TableCell>
                    <TableCell>
                      <Button
                        variant="contained"
                        color="primary"
                        startIcon={<CheckIcon />}
                        onClick={(e) => {
                          e.preventDefault();
                          window.open(file.url, "_blank");
                        }}
                      >
                        Check
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
          <div>
              <Typography variant="h6">Vehicle Details</Typography>
              <Typography>Make: {vehicleDetails.make}</Typography>
              <Typography>Model: {vehicleDetails.model}</Typography>
              <Typography>Year: {vehicleDetails.year}</Typography>
              <Typography>Engine Type: {vehicleDetails.engineType}</Typography>
              <Typography>Horse Power: {vehicleDetails.horsePower}</Typography>
              <Typography>License Plate Number: {vehicleDetails.licensePlateNumber}</Typography>
              <Typography>Color: {vehicleDetails.color}</Typography>
              <Typography>VIN: {vehicleDetails.vin}</Typography>
              <Typography>Fuel Type: {vehicleDetails.fuelType}</Typography>

            </div>
            <div>
      {/* Your ReDetails component UI */}
      <Link to={`/revenue/${id}`}>
        Generate License
      </Link>
    </div>
                      <br></br>
  
          {/* Link back to List */}
          <Link to="/reqdash">Back to List</Link>
        </>
      )}
    </Paper>
  );
};

export default ReDetails;
