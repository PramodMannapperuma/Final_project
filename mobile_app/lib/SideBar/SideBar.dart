import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("John Doe"),
            accountEmail: const Text("JohnDoe69@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/Images/shit.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/Images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Revenue Licence"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("Vehicle Repairs"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text("Accident Details"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text("Profile"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Info"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out", style: TextStyle(color: Colors.red),),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
