import 'package:flutter/material.dart';

import 'Accident_Info.dart';

class AccidentDetails extends StatefulWidget {
  const AccidentDetails({super.key});

  @override
  State<AccidentDetails> createState() => _AccidentDetailsState();
}

class _AccidentDetailsState extends State<AccidentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hello ,",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pramod Mannapperuma",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your past vehicle Accidents  , ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text("things in the past",),
              //   ],
              // ),

              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccidentInfo(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road Side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road Side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road Side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road Side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.minor_crash_sharp), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Road Side",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
