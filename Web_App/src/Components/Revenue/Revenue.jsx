import "./Revenue.css";
const RevenueLiscense = () => {
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
          <p>{documentData.ownerInfo.name}</p>
          <p>{documentData.ownerInfo.address}</p>
        </div>

        <div className="vehicle-details">
          <h5>Vehicle Information</h5>
          <p>{documentData.vehicleInfo.type}</p>
          <p>{documentData.vehicleInfo.model}</p>
          <p>{documentData.vehicleInfo.weight}</p>
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
