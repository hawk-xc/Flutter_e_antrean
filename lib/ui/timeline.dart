// custom_timeline.dart

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart'; // Ensure this package is included

class CustomTimeline extends StatelessWidget {
  const CustomTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> timelineEvents = [
      {'title': 'Register', 'description': 'User registered successfully.'},
      {'title': 'Login', 'description': 'User logged in.'},
      {'title': 'Add Device', 'description': 'User added a new device.'},
      {
        'title': 'Create Ticket',
        'description': 'User created a support ticket.'
      },
      {
        'title': 'Receive Notification',
        'description': 'User received a notification.'
      },
    ];

    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.alternating,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timelineEvents[index]['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(timelineEvents[index]['description']!),
            ],
          ),
        ),
        itemCount: timelineEvents.length,
      ),
    );
  }
}
