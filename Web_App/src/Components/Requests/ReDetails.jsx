import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import {
  Paper,
  Typography,
  Table,
  TableContainer,
  TableBody,
  TableRow,
  TableCell,
  Button,
} from "@mui/material";
import CheckIcon from "@mui/icons-material/Check";

const data = [
  { id: 1, EcoTest: "Eco.pdf", Name: "Jon", Insurence: "Insurense.pdf", OldRevenueLicense: "rev.pdf" },
  { id: 2, EcoTest: "Green.pdf", Name: "Alice", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  
  // Add more sample data as needed
];

const ReDetails = () => {
  const { id } = useParams();
  const [rowData, setRowData] = useState(null);

  useEffect(() => {
    // Find the item with the matching ID
    const item = data.find((item) => item.id === parseInt(id));
    if (item) {
      setRowData(item);
    } else {
      // Handle the case where the item with the specified ID is not found
      console.log(`Item with ID ${id} not found`);
    }
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
        Detail Page
      </Typography>
      {rowData ? (
        <TableContainer>
          <Table>
            <TableBody>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>{rowData.id}</TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Name</TableCell>
                <TableCell>{rowData.Name}</TableCell>
               
              </TableRow>
              <TableRow>
                <TableCell>Eco Test</TableCell>
                <TableCell>{rowData.EcoTest}</TableCell>
                <TableCell>
                  <Button
                    variant="contained"
                    color="primary"
                    startIcon={<CheckIcon />}
                    // onClick={handleCheckClick}
                  >
                    <Link
                      style={{ textDecoration: "none", color: "inherit" }}
                      onClick={(e) => {
                        e.preventDefault(); // Prevent the default behavior of the link
                        window.open("/hellooo", "_blank"); // Open the link in a new tab
                      }}
                    >
                      Check
                    </Link>
                  </Button>
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Insurence</TableCell>
                <TableCell>{rowData.Insurence}</TableCell>
                <TableCell>
                  <Button
                    variant="contained"
                    color="primary"
                    startIcon={<CheckIcon />}
                    // onClick={handleCheckClick}
                  >
                    <Link
                      style={{ textDecoration: "none", color: "inherit" }}
                      onClick={(e) => {
                        e.preventDefault(); // Prevent the default behavior of the link
                        window.open("/hellooo", "_blank"); // Open the link in a new tab
                      }}
                    >
                    
                      Check
                    </Link>
                  </Button>
                </TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Old Revenue License</TableCell>
                <TableCell>{rowData.OldRevenueLicense}</TableCell>
                <TableCell>
                  <Button
                    variant="contained"
                    color="primary"
                    startIcon={<CheckIcon />}
                    // onClick={handleCheckClick}
                  >
                    <Link
                      style={{ textDecoration: "none", color: "inherit" }}
                      onClick={(e) => {
                        e.preventDefault(); // Prevent the default behavior of the link
                        window.open("/hellooo", "_blank"); // Open the link in a new tab
                      }}
                    >
                    
                      Check
                    </Link>
                  </Button>
                </TableCell>
              </TableRow>
            </TableBody>
          </Table>
        </TableContainer>
      ) : (
        <p>Loading...</p>
      )}
      <Link to="/reqdash">Back to List</Link>
    </Paper>
  );
};

export default ReDetails;
