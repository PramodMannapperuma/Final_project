import 'package:flutter/material.dart';
import 'package:mobile/repair/repair_Info.dart';

class RepairDetails extends StatefulWidget {
  const RepairDetails({super.key});
  

  @override
  State<RepairDetails> createState() => _RepairDetailsState();
}

class _RepairDetailsState extends State<RepairDetails> {
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
                  Text("Hello ,", style: TextStyle(fontSize: 40),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Pramod Mannapperuma",style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Your past vehicle repaires  , ",style: TextStyle(fontSize: 20),),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RepairInfo(),),);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Tyre Change",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Oil Change",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Power Box",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Oil Change",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Service",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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
                    Icon(
                        Icons.settings_outlined), // Add your desired icon here
                    SizedBox(
                      width: 40,
                    ), // Add some spacing between the icon and text
                    Text(
                      "Oil Change",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 40,),
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