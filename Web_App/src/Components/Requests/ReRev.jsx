import React, { useState, useEffect } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
} from "@mui/material";
import Button from "@mui/material/Button";
import CheckIcon from "@mui/icons-material/Check";
import DoneIcon from "@mui/icons-material/Done";
import { Link, useLocation } from "react-router-dom";

const CustomActionsCell = ({ id }) => {
  const [isChecked, setIsChecked] = useState(false);
  const [isCompleteEnabled, setIsCompleteEnabled] = useState(false);

  // Use location to get the current pathname
  const location = useLocation();

  // Parse the URL search params to check if 'isChecked' and 'isCompleteEnabled' are set
  const urlParams = new URLSearchParams(location.search);
  const checkedParam = urlParams.get("checked");
  const completeEnabledParam = urlParams.get("completeEnabled");

  // Set state based on URL parameters when the component mounts
  React.useEffect(() => {
    setIsChecked(checkedParam === "true");
    setIsCompleteEnabled(completeEnabledParam === "true");
  }, [checkedParam, completeEnabledParam]);

  // Update URL parameters when state changes
  React.useEffect(() => {
    const newSearchParams = new URLSearchParams();
    newSearchParams.set("checked", isChecked.toString());
    newSearchParams.set("completeEnabled", isCompleteEnabled.toString());
    window.history.replaceState({}, "", `${location.pathname}?${newSearchParams.toString()}`);
  }, [isChecked, isCompleteEnabled, location.pathname]);

  const handleCheckClick = () => {
    setIsChecked(true);
    setIsCompleteEnabled(true);
  };

  const handleCompleteClick = () => {
    console.log("Complete clicked for row id:", id);
  };

  return (
    <TableCell align="right">
      <Button
        variant="contained"
        color="primary"
        startIcon={<CheckIcon />}
        onClick={handleCheckClick}
      >
        <Link
         to={`/redetails/${id}`}
          style={{ textDecoration: "none", color: "inherit" }}
        >
          Check
        </Link>
      </Button>

      <Button
        variant="contained"
        style={{ marginLeft: 8, backgroundColor: "green" }}
        startIcon={<DoneIcon />}
        onClick={handleCompleteClick}
        disabled={!isChecked}
      >
        Generate
      </Button>
    </TableCell>
  );
};

const rows = [
  { id: 1, lastName: "Snow", firstName: "Jon", age: 35 },
  { id: 2, lastName: "Lannister", firstName: "Cersei", age: 42 },
  { id: 3, lastName: "Lannister", firstName: "Jaime", age: 45 },
  { id: 4, lastName: "Stark", firstName: "Arya", age: 16 },
  { id: 5, lastName: "Targaryen", firstName: "Daenerys", age: null },
  { id: 6, lastName: "Melisandre", firstName: null, age: 150 },
  { id: 7, lastName: "Clifford", firstName: "Ferrara", age: 44 },
  { id: 8, lastName: "Frances", firstName: "Rossini", age: 36 },
  { id: 9, lastName: "Roxie", firstName: "Harvey", age: 65 },
  { id: 10, lastName: "Lannister", firstName: "Jaime", age: 45 },
  { id: 11, lastName: "Stark", firstName: "Arya", age: 16 },
  { id: 12, lastName: "Targaryen", firstName: "Daenerys", age: null },
  { id: 13, lastName: "Melisandre", firstName: null, age: 150 },
  { id: 14, lastName: "Clifford", firstName: "Ferrara", age: 44 },
  { id: 15, lastName: "Frances", firstName: "Rossini", age: 36 },
  { id: 16, lastName: "Roxie", firstName: "Harvey", age: 65 },
];

const ReRev = () => {
  return (
    <TableContainer
      component={Paper}
      style={{ width: "100%", height: "100vh" }}
    >
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell align="center">First name</TableCell>
            <TableCell align="center">Last name</TableCell>
            <TableCell align="center">Age</TableCell>
            <TableCell align="right">Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <TableRow key={row.id}>
              <TableCell align="left">{row.id}</TableCell>
              <TableCell align="center">{row.firstName}</TableCell>
              <TableCell align="center">{row.lastName}</TableCell>
              <TableCell align="center">{row.age}</TableCell>
              <CustomActionsCell id={row.id} />
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default ReRev;
