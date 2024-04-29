import { useState } from "react";
import { Button, Input, Container, Typography, Box } from "@mui/material";
import Nav from "../Navigation/Nav";
import { getStorage, ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { collection, addDoc } from "firebase/firestore";
import { firestore } from "../../firebase";

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
    const storage = getStorage();
    const id = generateId(); // Generate a new ID for each upload

    // Upload insurance files to a new folder with the generated ID
    const insuranceId = await uploadFiles(
      insuranceFiles,
      "documents",
      id,
      storage
    );

    // Upload ecoTest files to the same folder
    const ecoTestId = await uploadFiles(ecoTestFiles, "documents", id, storage);

    // Upload certificate files to the same folder
    const certificateId = await uploadFiles(
      certificateFiles,
      "documents",
      id,
      storage
    );

    // Save the IDs to Firestore
    await saveIdsToFirestore(insuranceId, ecoTestId, certificateId);

    // Clear the file uploaders
    setInsuranceFiles([]);
    setEcoTestFiles([]);
    setCertificateFiles([]);
  };

  const uploadFiles = async (files, folderName, id) => {
    const storage = getStorage();
    const urls = [];

    for (const file of files) {
      const storageRef = ref(storage, `${folderName}/${id}/${file.name}`);
      await uploadBytes(storageRef, file);
      const downloadURL = await getDownloadURL(storageRef);
      urls.push(downloadURL);
    }

    return urls;
  };

  const generateId = () => {
    return Math.random().toString(36).substring(7);
  };

  const saveIdsToFirestore = async (insuranceId, ecoTestId, certificateId) => {
    try {
      await addDoc(collection(firestore, "fileIds"), {
        insuranceId,
        ecoTestId,
        certificateId,
      });
      console.log("File IDs uploaded successfully!");
    } catch (error) {
      console.error("Error uploading file IDs:", error);
    }
  };

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
        <Box sx={{ textAlign: "center", marginTop: "20px", marginLeft: 6 }}>
          <Button variant="contained" onClick={handleUpload}>
            Upload
          </Button>
        </Box>
      </Container>
    </div>
  );
};

export default Landing;
