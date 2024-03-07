import { useState } from "react";
import { Button, Input, Container, Typography, Box } from "@mui/material";
import Nav from "../Navigation/Nav";
// import firebase from "firebase/app";
// import "firebase/storage";

// const firebaseConfig = {
//   // Your firebase config
// };

// firebase.initializeApp(firebaseConfig);
// const storage = firebase.storage();

const Landing = () => {
  const [insuranceFiles, setInsuranceFiles] = useState([]);
  const [ecoTestFiles, setEcoTestFiles] = useState([]);
  const [certificateFiles, setCertificateFiles] = useState([]);

  const handleInsuranceFiles = (files) => {
    setInsuranceFiles(files);
  };

  const handleEcoTestFiles = (files) => {
    setEcoTestFiles(files);
  };

  const handleCertificateFiles = (files) => {
    setCertificateFiles(files);
  };

  const handleUpload = async () => {
    console.log("Uploading certificate files:", certificateFiles);
    console.log("Uploading ecoTest files:", ecoTestFiles);
    console.log("Uploading insurance files:", insuranceFiles);
    // try {
    //   await uploadFiles(insuranceFiles, 'insurance');
    //   await uploadFiles(ecoTestFiles, 'ecoTest');
    //   await uploadFiles(certificateFiles, 'certificate');
    //   alert('Files uploaded successfully!');
    // } catch (error) {
    //   console.error('Error uploading files: ', error);
    //   alert('Error uploading files');
    // }
  };

  // const uploadFiles = async (files, folder) => {
  //   const promises = [];
  //   files.forEach((file) => {
  //     const storageRef = storage.ref(`${folder}/${file.name}`);
  //     const uploadTask = storageRef.put(file);
  //     promises.push(uploadTask);
  //   });
  //   return Promise.all(promises);
  // };

  return (
    <div>
      <Nav />
      <Typography variant="h4" sx={{ marginTop: "70px", fontWeight: "bold" }}>
        Apply Your Revenue License for Your Vehicle
      </Typography>
      <Typography variant="h6" sx={{ marginTop: "20px" }} gutterBottom>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem
        reprehenderit esse repudiandae non temporibus itaque,
      </Typography>
      <Container
        sx={{ display: "flex", flexDirection: "column", alignItems: "center" }}
      >
        <Typography variant="h6" gutterBottom>
          Upload Your Insurance File
        </Typography>
        <div>
          <Input
            type="file"
            onChange={(e) => handleInsuranceFiles(Array.from(e.target.files))}
            style={{ display: "none" }}
            id="insurance-file-input"
            multiple
          />
          <label htmlFor="insurance-file-input">
            <Button
              component="span"
              variant="outlined"
              sx={{ marginLeft: 6, paddingLeft: 6, paddingRight: 6 }}
            >
              Select Files
            </Button>
          </label>
        </div>
        {insuranceFiles.length > 0 && (
          <Typography variant="body1" gutterBottom>
            Selected Files:
            {insuranceFiles.map((file, index) => (
              <span key={index}>
                {file.name}
                {index !== insuranceFiles.length - 1 ? ", " : ""}
              </span>
            ))}
          </Typography>
        )}
        <Typography variant="h6" gutterBottom>
          Upload Your Eco-Test
        </Typography>
        <div>
          <Input
            type="file"
            onChange={(e) => handleEcoTestFiles(Array.from(e.target.files))}
            style={{ display: "none" }}
            id="ecoTest-file-input"
            multiple
          />
          <label htmlFor="ecoTest-file-input">
            <Button
              component="span"
              variant="outlined"
              sx={{ marginLeft: 6, paddingLeft: 6, paddingRight: 6 }}
            >
              Select Files
            </Button>
          </label>
        </div>
        {ecoTestFiles.length > 0 && (
          <Typography variant="body1" gutterBottom>
            Selected Files:
            {ecoTestFiles.map((file, index) => (
              <span key={index}>
                {file.name}
                {index !== ecoTestFiles.length - 1 ? ", " : ""}
              </span>
            ))}
          </Typography>
        )}
        <Typography sx={{ textAlign: "left" }} variant="h6" gutterBottom>
          Upload Certificate Of Compliance (Only For Heavy Vehicles)
        </Typography>
        <div>
          <Input
            type="file"
            onChange={(e) => handleCertificateFiles(Array.from(e.target.files))}
            style={{ display: "none" }}
            id="certificate-file-input"
            multiple
          />
          <label htmlFor="certificate-file-input">
            <Button
              component="span"
              variant="outlined"
              sx={{ marginLeft: 6, paddingLeft: 6, paddingRight: 6 }}
            >
              Select Files
            </Button>
          </label>
        </div>
        {certificateFiles.length > 0 && (
          <Typography variant="body1" gutterBottom>
            Selected Files:
            {certificateFiles.map((file, index) => (
              <span key={index}>
                {file.name}
                {index !== certificateFiles.length - 1 ? ", " : ""}
              </span>
            ))}
          </Typography>
        )}
        <Box sx={{ textAlign: "center", marginTop: "20px", marginLeft:6 }}>
          <Button variant="contained" onClick={handleUpload}>
            Upload
          </Button>
        </Box>
      </Container>
    </div>
  );
};

export default Landing;
