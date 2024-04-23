import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../screens/profile_view.dart';

class AccidentInfo extends StatefulWidget {
  const AccidentInfo({Key? key}) : super(key: key);

  @override
  State<AccidentInfo> createState() => _AccidentInfoState();
}

class _AccidentInfoState extends State<AccidentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accident Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pramod Mannapperuma",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Roadside Accident,",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Add the ImageSlider widget here
              CarouselSlider(
                items: [
                  Image.asset('assets/Images/acci1.jpg'),
                  Image.asset('assets/Images/acci2.jpg'),
                  Image.asset('assets/Images/acci.jpg'),
                  // Add more images as needed
                ],
                options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              const ProfileDetailColumn(
                  title: 'Date & Time', value: '2023-03-03 | 10.38 A.M.'),
              const ProfileDetailColumn(
                  title: 'Location', value: 'Lotus Tower'),
              const ProfileDetailColumn(
                  title: 'Damages ',
                  value: 'Front Buffer | Windscreen | Bonnet '),
              const ProfileDetailColumn(
                  title: 'Description Of Accident',
                  value:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
            ],
          ),
        ),
      ),
    );
  }
}
