import 'package:evently_c16/core/source/remote/fireStoremanager.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/widgets/eventItem.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/event.dart';

class Allview extends StatelessWidget {
  const Allview({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
        stream: FireStoreManager.getAllEventsStream(),
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
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        },
    );
  }

}
