import 'dart:convert';

import 'package:firebase_notifications/notifications_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            print('Notification snd');
            var data = {
              'to':
                  'ewNpXfzsSN65xNZuZTMYdQ:APA91bHvIyY7GqjHn1ZaRup32xH_dEAhM3vj-jVKESSmH7ErLq1g381MzN9Wr5o0C8ayuS-e8UJrJmIShqfSIoZh9KXNoqm3UT0RffIEwJaP-6BbZCga_ErvqYDG17eeFfzDJ9z4SaOT',
              'priority': 'high',
              'notification': {
                'title': 'Hello',
                'body': 'Ali Hamza there 👏',
              },
              'data': {'msg': "What's going on 🙋"}
            };
            try {
              http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization':
                      'key=AAAABWrxC3M:APA91bFPXUiNkh6qSUTOcARowTR5chr4xjuL8vfSikDTOIFizzZbu7ktFJinsPLAzyuCLKgaiT9J5N5qY_I7eBqQltTOaYPvQAbYEdRgiJ3hi9jXZKsH7L5w74aU-YXJSiIFmRY5x_9m',
                },
              );
            } catch (e) {
              print(e);
            }
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}
