import React, { useState, useEffect } from "react";
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from "@mui/material";
import Button from "@mui/material/Button";
import CheckIcon from "@mui/icons-material/Check";
import { Link } from "react-router-dom";
import { firestore } from "../../firebase";
import { getDocs, collection } from "firebase/firestore";

const CustomActionsCell = ({ id }) => {
  const [isChecked, setIsChecked] = useState(false);
  const [isCompleteEnabled, setIsCompleteEnabled] = useState(false);

  const handleCheckClick = () => {
    setIsChecked(true);
    setIsCompleteEnabled(true);
  };

  return (
    <TableCell align="right">
      <Button
        variant="contained"
        color="primary"
        startIcon={<CheckIcon />}
        onClick={handleCheckClick}
      >
        <Link to={`/redetails/${id}`} style={{ textDecoration: "none", color: "inherit" }}>
          Check
        </Link>
      </Button>
    </TableCell>
  );
};

const ReRev = () => {
  const [documents, setDocuments] = useState([]);

  useEffect(() => {
    const fetchDocuments = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, "fileIds"));
        const documentsData = querySnapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setDocuments(documentsData);
      } catch (error) {
        console.error("Error fetching documents:", error);
      }
    };

    fetchDocuments();
  }, []);

  return (
    <TableContainer component={Paper} style={{ width: "100%", height: "100vh" }}>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell align="center">Name</TableCell>
            <TableCell align="center">Eco Test</TableCell>
            <TableCell align="center">Insurance</TableCell>
            <TableCell align="center">Old Revenue License</TableCell>
            <TableCell align="right">Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {documents.map((doc) => (
            <TableRow key={doc.id}>
              <TableCell component="th" scope="row">
                {doc.id}
              </TableCell>
              <TableCell align="center">{doc.name || 'Name Placeholder'}</TableCell>
              <TableCell align="center">{doc.ecoTest || 'Eco Test Placeholder'}</TableCell>
              <TableCell align="center">{doc.insurance || 'Insurance Placeholder'}</TableCell>
              <TableCell align="center">{doc.oldRevenueLicense || 'Old Revenue License Placeholder'}</TableCell>
              <CustomActionsCell id={doc.id} />
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default ReRev;
