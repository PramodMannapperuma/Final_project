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
        const certificateUrl = fileIds.certificateId;
        const ecoTestUrl = fileIds.ecoTestId;
        const insuranceUrl = fileIds.insuranceId;

        // Create file objects with URLs
        files.push({ key: 'certificateId', url: certificateUrl, name: 'Certificate Document' });
        files.push({ key: 'ecoTestId', url: ecoTestUrl, name: 'Eco Test Document' });
        files.push({ key: 'insuranceId', url: insuranceUrl, name: 'Insurance Document' });

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
      ) : fileData.length > 0 ? (
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
      ) : (
        <p>No files available.</p>
      )}
      <Link to="/reqdash">Back to List</Link>
    </Paper>
  );
};

export default ReDetails;
