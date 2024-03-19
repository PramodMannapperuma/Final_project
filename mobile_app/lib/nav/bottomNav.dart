import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile_app/Home.dart';
import 'package:mobile_app/screens/profile.dart';
import 'package:mobile_app/screens/revenue_liscense.dart';

import '../SideBar/SideBar.dart';


class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final items = const [
    Icon(Icons.bar_chart),
    Icon(Icons.home),
    Icon(Icons.newspaper),
    Icon(Icons.person_2),
  ];

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('MotoManager'),
        backgroundColor: Colors.blue,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 15.0),
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'faq',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Faq',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.help,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Log Out',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (String value) async {
                // Handle menu item selection here
                if (value == 'logout') {
                  try {
                    Navigator.pushNamed(context, '/landing');
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("logout failed maybe network error"),
                            actions: [
                              TextButton(
                                child: const Text("ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  }
                }
                if (value == 'faq') {
                  // Navigator.pushNamed(context, '/faq');
                }
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        color: Colors.blue,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget =  const PdfFilePicker();
        break;
      case 1:
        widget = const MyHomePage();
        break;
      case 2:
        widget = const MyHomePage();
        break;
      case 3:
        widget = const Profile();
        break;
      default:
        widget = const MyHomePage();
        break;
    }
    return widget;
  }
}

enum MenuItem {
  item1,
  item2,
}
