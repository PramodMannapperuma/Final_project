import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late PageController pageController;
  final Color navigationBarColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 2, 33, 49),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 50.0,
                      minRadius: 50.0,
                      backgroundColor: Colors.cyan,
                      backgroundImage: AssetImage("assets/Images/home.jpg"),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Hello John ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "GTR GT500",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/Images/shit.jpg',
                width: 400, // Set the width of the image
                height: 200, // Set the height of the image
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClickableCard(
                      title: 'Card 1',
                      onTap: () {
                      },
                    ),
                    ClickableCard(
                      title: 'Card 2',
                      onTap: () {
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClickableCard(
                      title: 'Card 3',
                      onTap: () {
                      },
                    ),
                    ClickableCard(
                      title: 'Card 4',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ), // Replace HomePage with your actual homepage widget
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClickableCard extends StatelessWidget {
  final String title;
  final Function onTap;

  const ClickableCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        // color: Colors.blue,
        child: SizedBox(
          height: 110,
          width: 170,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}