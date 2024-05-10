import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile/auth/login.dart';
import 'package:mobile/firebase_options.dart';

import 'notification_handle.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final NotificationService notificationService = NotificationService();
  notificationService.initialize();

  // Listen to the repairs collection for changes
  FirebaseFirestore.instance.collection("repairs").snapshots().listen((event) {
    if (event.docs.isNotEmpty) {
      final doc = event.docs.first;
      final id = doc.id.hashCode; // Use document ID as the notification ID
      // Send repair data added notification
      notificationService.showNotification(
        id,
        "Repair Data Added",
        "New repair data has been added.",
      );
    }
  });
  // Listen to the accidents collection for changes
  FirebaseFirestore.instance
      .collection("accidents")
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      final doc = event.docs.first;
      final id = doc.id.hashCode; // Use document ID as the notification ID
      // Send accident data added notification
      notificationService.showNotification(
        id,
        "Accident Data Added",
        "New accident data has been added.",
      );
    }
  });
  // Listen to the notifications collection for changes
  FirebaseFirestore.instance
      .collection("licenses")
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      final doc = event.docs.first;
      final id = doc.id.hashCode; // Use document ID as the notification ID
      // Send new notification notification
      notificationService.showNotification(
        id,
        "Check this out",
        "Your new license arrived",
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginForm(),
    );
  }
}
