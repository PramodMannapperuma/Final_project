import 'package:flutter/material.dart';
import 'package:mobile_app/vehicle/accident_detail.dart';
import 'package:mobile_app/vehicle/repair_details.dart';
import 'package:mobile_app/vehicle/report_request.dart';
import '../screens/profile_view.dart';

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
                        image: AssetImage("assets/Images/home.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Circle avatar
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/Images/well.jpg"),
                    radius: 60,
                  ),
                ],
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
            const Divider(
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileDetailRow(
                  title: 'Name',
                  value: 'Shelby',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Registration Number',
                  value: '1234567',
                ),
                ProfileDetailRow(
                  title: 'Manufactured Year',
                  value: '2023',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Model',
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
                title: 'Miles',
                value: '10006',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle tapping on Services
              },
              child: ProfileDetailColumn(
                title: 'Services',
                value: '20',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetails(),),);
              },
              child: ProfileDetailColumn(
                title: 'Owners Details',
                value: 'John Doe',
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RepairDetails(),),);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.settings_outlined), // Add your desired icon here
                  SizedBox(
                    width: 40,
                  ), // Add some spacing between the icon and text
                  Text(
                    "Repair Details",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccidentDetails(),),);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.car_crash_outlined), // Add your desired icon here
                  SizedBox(
                    width: 40,
                  ), // Add some spacing between the icon and text
                  Text(
                    "Accident Details",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RquestReport(),),);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.library_books_sharp), // Add your desired icon here
                  SizedBox(
                    width: 40,
                  ), // Add some spacing between the icon and text
                  Text(
                    "Request a Report",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
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
