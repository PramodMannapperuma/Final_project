import 'package:flutter/material.dart';

class FacebookStoryImageDisplay extends StatefulWidget {
  @override
  State<FacebookStoryImageDisplay> createState() =>
      _FacebookStoryImageDisplayState();
}

class _FacebookStoryImageDisplayState extends State<FacebookStoryImageDisplay> {
  final List<String> images = [
    'assets/Images/well.jpg',
    'assets/Images/shit.jpg',
    'assets/Images/well.jpg',
    // Add more image paths as needed
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    print('Current Page: $_currentPage'); // Debug print statement

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              print('Page changed: $index'); // Debug print statement
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle tap on the image
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            controller: PageController(
              initialPage: _currentPage,
            ),
          ),
          Positioned(
            top: 190,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle back button press
                    if (_currentPage > 0) {
                      print('Back pressed'); // Debug print statement
                      setState(() {
                        _currentPage--;
                      });
                    }
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    // Handle forward button press
                    if (_currentPage < images.length - 1) {
                      print('Forward pressed'); // Debug print statement
                      setState(() {
                        _currentPage++;
                      });
                    }
                  },
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
