import "./Revenue.css";
import { useEffect, useState } from "react";
import { useParams } from 'react-router-dom';
import { firestore } from "../../firebase";
import { doc, getDoc, setDoc, deleteDoc, } from "firebase/firestore";

const RevenueLiscense = () => {

  const { id } = useParams();
  const [rowData, setRowData] = useState(null);
  const [fileData, setFileData] = useState([]);
  const [vehicleDetails, setVehicleDetails] = useState();
  const [loading, setLoading] = useState(true);
  const [licenseNumber, setLicenseNumber] = useState("");

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
          userEmail: vehicleData.userEmail
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

  useEffect(() => {
    if (vehicleDetails) {
      // Generate a random number between 100000 and 999999
      const randomNumber = Math.floor(Math.random() * 900000) + 100000;
      setLicenseNumber(`XYZ-${randomNumber}`);
    }
  }, [vehicleDetails]);

  const handleSaveLicense = async () => {
    try {
      console.log("Saving license...");
      const licenseDocRef = doc(firestore, "licenses", id);
      await setDoc(licenseDocRef, { licenseNumber, id, vehicleDetails });

      // Delete collection from fileIds
      const fileDocRef = doc(firestore, "fileIds", id);
      await deleteDoc(fileDocRef);
      

      console.log("License and vehicle details saved successfully, and fileIds document deleted!");
    } catch (error) {
      console.error("Error saving license and vehicle details:", error);
    }
  };

  if (loading) {
    return <div>Loading...</div>;
  }
  const currentDate = new Date(); // Get current date and time
const formattedDate = `${currentDate.getFullYear()}-${(currentDate.getMonth() + 1).toString().padStart(2, '0')}-${currentDate.getDate().toString().padStart(2, '0')}`;


  return (
    <div className="revenue-license-container">
      <div className="watermark">Confidential</div>
      <h1 className="revenue-license-title">Vehicle Revenue License</h1>
      <p className="revenue-license-detail">License No: XYZ-123456</p>
      <p className="revenue-license-detail">Issue Date: {formattedDate}</p>
      <p className="revenue-license-detail">Class of Vehicle,Fuel Type and Vehicle No.</p>
      {vehicleDetails ? (
            <>
              <p>{vehicleDetails.make}/{vehicleDetails.fuelType}/{vehicleDetails.licensePlateNumber}</p>
            </>
          ) : (
            <p>Vehicle details not available.</p>
          )}

      <div className="details-row">
        <div className="owner-details">
          <h5>Owner Information</h5>
          {vehicleDetails ? (
            <>
              <p>Horse Power: {vehicleDetails.horsePower}</p>
              <p>License Plate Number: {vehicleDetails.licensePlateNumber}</p>
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
              <p>Email {vehicleDetails.userEmail}</p>
              
            </>
          ) : (
            <p>Vehicle details not available.</p>
          )}
        </div>
      </div>

      {/* <div className="fees-details">
        <h5>Fees Information</h5>
        <p>{documentData.feesInfo.annualFee}</p>
        <p>{documentData.feesInfo.arrears}</p>
        <p>{documentData.feesInfo.fines}</p>
      </div> */}
      {/* ...additional sections as needed */}
      <button onClick={handleSaveLicense}>Save License</button>
    </div>
  );
};

export default RevenueLiscense;
