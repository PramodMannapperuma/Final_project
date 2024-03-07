import { useState } from 'react';
import { Button, Input, Typography } from '@mui/material';

const FileUploader = () => {
  const [selectedFile, setSelectedFile] = useState(null);

  const handleFileChange = (event) => {
    setSelectedFile(event.target.files[0]);
  };

  const handleUpload = () => {
    // Logic for uploading the selected file
    if (selectedFile) {
      console.log('Uploading file:', selectedFile);
      // You can use selectedFile for further processing, such as uploading to a server
    } else {
      console.log('No file selected');
    }
  };

  return (
    <div>
     
      <Input
        type="file"
        onChange={handleFileChange}
        style={{ display: 'none' }}
        id="file-input"
      />
      <label htmlFor="file-input">
        <Button component="span" variant="outlined" sx={{marginLeft:6, paddingLeft:6, paddingRight:6}}>
          Select File
        </Button>
      </label>
      <Button onClick={handleUpload} variant="contained" sx={{marginLeft:1}} disabled={!selectedFile}>
        Upload
      </Button>
      {selectedFile && (
        <Typography variant="body1" gutterBottom>
          Selected File: {selectedFile.name}
        </Typography>
      )}
    </div>
  );
};

export default FileUploader;
