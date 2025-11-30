import 'package:flutter/material.dart';

import '../../../../../core/models/event.dart';
import '../../../../../core/source/remote/fireStoremanager.dart';
import 'eventItem.dart';

class Birthdayview extends StatelessWidget {
  const Birthdayview({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<Event>>(
      future: FireStoreManager.getTypeEvents("birthday"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        List <Event> events = snapshot.data??[];
        return ListView.separated(
          itemCount: events.length,
          itemBuilder: (context, index) =>Eventitem(event: events[index]),
          separatorBuilder: (context, index) => SizedBox(height: 16),
        );
      },
    );
  }
}
