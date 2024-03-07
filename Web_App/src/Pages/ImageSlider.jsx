import { useState } from "react";
import { Box, Button, CardMedia } from "@mui/material";
import HomePic from "../assets/home.png";
import Homepic from "../assets/homepic.jpg";
import Homepicc from "../assets/homepicc.jpg";
import Homepiccc from "../assets/homepiccc.jpg";
import KeyboardArrowRightIcon from "@mui/icons-material/KeyboardArrowRight";
import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";

const images = [HomePic, Homepic, Homepicc, Homepiccc];

const ImageSlider = () => {
  const [currentIndex, setCurrentIndex] = useState(0);

  const handlePrevClick = () => {
    setCurrentIndex((prevIndex) =>
      prevIndex === 0 ? images.length - 1 : prevIndex - 1
    );
  };

  const handleNextClick = () => {
    setCurrentIndex((prevIndex) =>
      prevIndex === images.length - 1 ? 0 : prevIndex + 1
    );
  };

  return (
    <Box
      sx={{
        paddingTop: 0,
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Button
        endIcon={<KeyboardArrowLeftIcon />}
        onClick={handlePrevClick}
        disabled={currentIndex === 0}
      ></Button>
      <CardMedia
        component="img"
        width="100%"
        height="auto"
        image={images[currentIndex]}
        alt={`Image ${currentIndex + 1}`}
      />

      <Button
        endIcon={<KeyboardArrowRightIcon />}
        onClick={handleNextClick}
        disabled={currentIndex === images.length - 1}
      ></Button>
    </Box>
  );
};

export default ImageSlider;
