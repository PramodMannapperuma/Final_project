import "./Revenue.css";
import { useEffect, useState } from "react";
import { useParams } from 'react-router-dom';
import { firestore } from "../../firebase";
import { doc, getDoc } from "firebase/firestore";

const RevenueLiscense = () => {

  const { id } = useParams();
  const [rowData, setRowData] = useState(null);
  const [fileData, setFileData] = useState([]);
  const [vehicleDetails, setVehicleDetails] = useState();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);  // Start loading
      const docRef = doc(firestore, "fileIds", id);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        setRowData(docSnap.data());
        const fileIds = docSnap.data(); // Contains { certificateId, ecoTestId, insuranceId }
        const files = [];

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
          // Add more vehicle details as needed
        };
        setVehicleDetails(vehicleDetails);

        setFileData(files);
      } else {
        console.log("No such document!");
      }
      setLoading(false);  // Stop loading
    };

    fetchData();
  }, [id]);


  const documentData = {
    title: "Vehicle Revenue License",
    number: "License No: XYZ-123456",
    date: "Issue Date: 2024-02-15",
    details: "Class of Vehicle,Fuel Type and Vehicle No.",
    data: "MOTOR CAR/PETROL/KB-2705",
    ownerInfo: {
      name: "Owner : John Doe",
      address: "Address: 123, Hometown, Country",
    },
    vehicleInfo: {
      type: "Vehicle: Car/Petrol",
      model: "Model: ABC-Model",
      weight: "Weight: 1430 kg",
    },
    feesInfo: {
      annualFee: "Annual Fee: $100.00",
      arrears: "Arrears: $20.00",
      fines: "Fines: $5.00",
    },
    // ... additional content
  };

  return (
    <div className="revenue-license-container">
      <div className="watermark">Confidential</div>
      <h1 className="revenue-license-title">{documentData.title}</h1>
      <p className="revenue-license-detail">{documentData.number}</p>
      <p className="revenue-license-detail">{documentData.date}</p>
      <p className="revenue-license-detail">{documentData.details}</p>
      <p className="revenue-license-detail">{documentData.data}</p>

      <div className="details-row">
        <div className="owner-details">
          <h5>Owner Information</h5>
          {vehicleDetails ? (
            <>
              <p>Horse Power: {vehicleDetails.horsePower}</p>
              <p>License Plate Number: {vehicleDetails.licensePlateNumber}</p>
              <p>Color: {vehicleDetails.color}</p>
              <p>VIN: {vehicleDetails.vin}</p>
              <p>Fuel Type: {vehicleDetails.fuelType}</p>
              
            </>
          ) : (
            <p>Vehicle details not available.</p>
          )}
        </div>

        <div className="vehicle-details">
          <h5>Vehicle Information</h5>
          {vehicleDetails ? (
            <>
              <p>Make: {vehicleDetails.make}</p>
              <p>Model: {vehicleDetails.model}</p>
              <p>Year: {vehicleDetails.year}</p>
              <p>Engine Type: {vehicleDetails.engineType}</p>
              
            </>
          ) : (
            <p>Vehicle details not available.</p>
          )}
        </div>
      </div>

      <div className="fees-details">
        <h5>Fees Information</h5>
        <p>{documentData.feesInfo.annualFee}</p>
        <p>{documentData.feesInfo.arrears}</p>
        <p>{documentData.feesInfo.fines}</p>
      </div>
      {/* ...additional sections as needed */}
    </div>
  );
};

export default RevenueLiscense;
