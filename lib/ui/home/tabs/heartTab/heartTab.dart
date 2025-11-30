import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/event.dart';
import '../../../../core/source/remote/fireStoremanager.dart';
import '../homeTabs/widgets/eventItem.dart';

class HeartTab extends StatefulWidget {
  const HeartTab({super.key});

  @override
  State<HeartTab> createState() => _HeartTabState();
}

class _HeartTabState extends State<HeartTab> {
  late TextEditingController searchController;
  List<Event> allEvents = [];
  List<Event> filteredEvents = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomField(validation: (value) {
              return null;
            },
                hint: "Search for Event",
                prefix: "assets/images/Search.svg",
                controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredEvents = allEvents
                      .where((event) =>
                      event.title!.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },

            ),
            const SizedBox(height: 16,),
            Expanded(
              child: FutureBuilder <List<Event>>(
                future: FireStoreManager.getUserWishList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  allEvents = snapshot.data ?? [];

                  if (filteredEvents.isEmpty && searchController.text.isEmpty) {
                    filteredEvents = allEvents;
                  }

                  return ListView.separated(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) =>Eventitem(event: filteredEvents[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  );
                },
              )

              )
          ],
        ),
      ),
    );
  }
}
