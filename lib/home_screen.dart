import 'package:firebase_notifications/notifications_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationsService _notificationsService = NotificationsService();

  @override
  void initState() {
    _notificationsService.initNotifications(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
