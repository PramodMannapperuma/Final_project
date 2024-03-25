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
  
  { id: 1, EcoTest: "Eco.pdf", Name: "Jon", Insurence: "Insurense.pdf", OldRevenueLicense: "rev.pdf" },
  { id: 2, EcoTest: "Green.pdf", Name: "Alice", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 3, EcoTest: "Sustainability.pdf", Name: "Max", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 4, EcoTest: "Environment.pdf", Name: "Sophie", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 5, EcoTest: "Conservation.pdf", Name: "Oliver", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 6, EcoTest: "Renewable.pdf", Name: "Emma", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 7, EcoTest: "Greenery.pdf", Name: "Jacob", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 8, EcoTest: "Sustainable.pdf", Name: "Ava", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 9, EcoTest: "Nature.pdf", Name: "Liam", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 10, EcoTest: "Biodiversity.pdf", Name: "Mia", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 11, EcoTest: "Earth.pdf", Name: "Ella", Insurence: "Policy.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 12, EcoTest: "Planet.pdf", Name: "Noah", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 13, EcoTest: "Greenhouse.pdf", Name: "Aiden", Insurence: "Coverage.pdf", OldRevenueLicense: "rev.pdf" },
  { id: 14, EcoTest: "Recycle.pdf", Name: "Charlotte", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 15, EcoTest: "Sustainability.pdf", Name: "Ethan", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 16, EcoTest: "EcoFriendly.pdf", Name: "Aria", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 17, EcoTest: "CleanEnergy.pdf", Name: "Mason", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 18, EcoTest: "Renewable.pdf", Name: "Liam", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 19, EcoTest: "Recyclable.pdf", Name: "Amelia", Insurence: "Coverage.pdf", OldRevenueLicense: "rev.pdf" },
  { id: 20, EcoTest: "EarthDay.pdf", Name: "Olivia", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 21, EcoTest: "Greenery.pdf", Name: "Lucas", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 22, EcoTest: "EcoSystem.pdf", Name: "Lily", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 23, EcoTest: "Nature.pdf", Name: "James", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 24, EcoTest: "ClimateChange.pdf", Name: "Evelyn", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 25, EcoTest: "GlobalWarming.pdf", Name: "Alexander", Insurence: "Coverage.pdf", OldRevenueLicense: "rev.pdf" },
  { id: 26, EcoTest: "Reduce.pdf", Name: "Mia", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 27, EcoTest: "Reuse.pdf", Name: "Benjamin", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  { id: 28, EcoTest: "GreenLife.pdf", Name: "Ava", Insurence: "Coverage.pdf", OldRevenueLicense: "renewal.pdf" },
  { id: 29, EcoTest: "Renew.pdf", Name: "William", Insurence: "Policy.pdf", OldRevenueLicense: "oldrev.pdf" },
  { id: 30, EcoTest: "Recycling.pdf", Name: "Isabella", Insurence: "Claims.pdf", OldRevenueLicense: "license.pdf" },
  
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
            <TableCell align="center">Name</TableCell>
            <TableCell align="center">Eco Test</TableCell>
            <TableCell align="center">Insurence </TableCell>
            <TableCell align="center">Old Revenue License </TableCell>
            <TableCell align="right">Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <TableRow key={row.id}>
              <TableCell align="left">{row.id}</TableCell>
              <TableCell align="center">{row.Name}</TableCell>
              <TableCell align="center">{row.EcoTest}</TableCell>
              <TableCell align="center">{row.Insurence}</TableCell>
              <TableCell align="center">{row.OldRevenueLicense}</TableCell>
              <CustomActionsCell id={row.id} />
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default ReRev;
