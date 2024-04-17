import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/vehicle/report_request.dart';
import 'package:mobile/vehicle/vehicle_edit.dart';
import '../screens/profile_view.dart';
import '../accident/accident_detail.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              String vehicleId = 'your-vehicle-id-here'; // Replace this with actual vehicle ID

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleEdit(vehicleId: vehicleId),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Background cover photo
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Images/cv.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Circle avatar
                  Positioned(
                    bottom: 0, // Adjust the bottom position as needed
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/Images/well.jpg"),
                      radius: 60,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Shelby GT500',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Column(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                  style: TextStyle(fontSize: 16, ),),
                  Divider(
                    thickness: 1.0,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileDetailColumn(
                  title: 'Vehicle Identification Number (VIN)',
                  value: 'Shelby',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Make',
                  value: '1234567',
                ),
                ProfileDetailRow(
                  title: 'Model',
                  value: '2023',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Year',
                  value: 'G Class A1',
                ),
                ProfileDetailRow(
                  title: 'Color',
                  value: 'Red',
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                // Handle tapping on Miles
              },
              child: ProfileDetailColumn(
                title: 'Liscense Plate Number',
                value: '10006',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle tapping on Services
              },
              child: ProfileDetailColumn(
                title: 'Engine Type',
                value: '20',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetails(),),);
              },
              child: ProfileDetailColumn(
                title: 'Fuel Type',
                value: 'John Doe',
              ),
            ),
            ProfileDetailColumn(
              title: 'Horse Power',
              value: '10006',
            ),
            ProfileDetailColumn(
              title: 'Transmission',
              value: '10006',
            ),
            SizedBox(height: 10),
          CarouselSlider(
            items: [
              Image.asset('assets/Images/well.jpg'),
              Image.asset('assets/Images/well1.jpg'),
              Image.asset('assets/Images/well2.jpg'),
              Image.asset('assets/Images/well3.webp'),
              // Add more images as needed
            ],
            options: CarouselOptions(
              height: 600,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1.0,
            ),
          ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepairDetails()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.settings_outlined,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Repair Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Divider(
                thickness: 1.0,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccidentDetails()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.car_crash_outlined,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Accident Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Divider(
                thickness: 1.0,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RquestReport()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.library_books_sharp,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Request a Report",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),

            // FacebookStoryImageDisplay() placeholder
            // Container(
            //   color: Colors.blue, // Temporary color for visibility
            //   height: 600, // Adjust height as needed
            //   child: Center(
            //     child: FacebookStoryImageDisplay()
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
