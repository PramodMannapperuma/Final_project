import 'package:flutter/material.dart';

class FAQAndPricingScreen extends StatefulWidget {
  @override
  _FAQAndPricingScreenState createState() => _FAQAndPricingScreenState();
}

class _FAQAndPricingScreenState extends State<FAQAndPricingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Services Info"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "FAQs"),
            Tab(text: "Pricing"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFAQs(),
          buildPricing(),
        ],
      ),
    );
  }

  Widget buildFAQs() {
    return ListView(
      children: const [
        ExpansionTile(
          title: Text("What is MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "MotoManager Hub is a comprehensive platform designed to assist vehicle owners with various aspects of vehicle management, including service scheduling, accident documentation, license renewals, and more. Our platform makes it easier to keep track of your vehicle's maintenance needs and documentation in one convenient place."))
          ],
        ),
        ExpansionTile(
          title: Text("What documents are needed for renewal?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "You need your previous license, vehicle registration, and proof of insurance."))
          ],
        ),
        ExpansionTile(
          title: Text("How do I register my vehicle on MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "To register your vehicle, log into your MotoManager Hub account, navigate to the 'Vehicles' section, and click on 'Add New Vehicle'. Fill in the required details such as make, model, year, and registration number. Once submitted, your vehicle will be added to your account for easy management."))
          ],
        ),
        ExpansionTile(
          title: Text("How secure is my personal and vehicle information on MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Security is a top priority at MotoManager Hub. All personal and vehicle information is encrypted and securely stored. We adhere to stringent data protection regulations to ensure your information is safe and only accessible by authorized personnel."))
          ],
        ),
        ExpansionTile(
          title: Text("Can I update my vehicle's information on MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Yes, you can update your vehicle’s information at any time. Go to the 'Vehicles' section, select the vehicle you want to update, and edit any details such as insurance information, vehicle color, or add notes about modifications or additional equipment."))
          ],
        ),
        ExpansionTile(
          title: Text("Is there a fee to use MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "MotoManager Hub offers free subscription option. The free version includes access to service history, detailed reports, and priority customer support."))
          ],
        ),
        ExpansionTile(
          title: Text("How do I contact support if I have issues with MotoManager Hub?"),
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "If you encounter any issues or have questions, you can reach our support team through the 'Help' section in the app. We offer support via email, phone, and live chat to ensure you receive assistance promptly."))
          ],
        ),
        // Add more FAQs similarly
      ],
    );
  }

  Widget buildPricing() {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Vehicle Type')),
          DataColumn(label: Text('Price Range')),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Car')),
              DataCell(Text('\$100 - \$200')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Motorcycle')),
              DataCell(Text('\$50 - \$100')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Truck')),
              DataCell(Text('\$200 - \$300')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('')),
              DataCell(Text('')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('')),
              DataCell(Text('')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('')),
              DataCell(Text('')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('')),
              DataCell(Text('')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Truck')),
              DataCell(Text('\$200 - \$300')),
            ],
          ),// Add more rows for other vehicle types
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
