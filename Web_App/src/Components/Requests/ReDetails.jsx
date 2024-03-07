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
  { id: 1, firstName: "John", lastName: "Doe", age: 30 },
  { id: 2, firstName: "Jane", lastName: "Doe", age: 28 },
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
                <TableCell>First Name</TableCell>
                <TableCell>{rowData.firstName}</TableCell>
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
                <TableCell>Last Name</TableCell>
                <TableCell>{rowData.lastName}</TableCell>
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
                <TableCell>Age</TableCell>
                <TableCell>{rowData.age}</TableCell>
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
