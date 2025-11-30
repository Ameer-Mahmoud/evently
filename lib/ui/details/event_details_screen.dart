import 'package:evently_c16/core/models/event.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/source/remote/fireStoremanager.dart';
import 'package:evently_c16/ui/details/provider/event_details_provider.dart';
import 'package:evently_c16/ui/details/widgets/date_and_location_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/resources/AppConstants.dart';
import '../../core/resources/RoutesManager.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
   final Provider = context.read<EventDetailsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details",style: TextStyle(

        ),),
        actions: [
          Visibility(
              visible: FirebaseAuth.instance.currentUser!.uid == event.userId,
              child: IconButton(onPressed: (){
                Navigator.pushNamed(
                  context,
                  RoutesManager.create,
                  arguments: event,
                );
              }, icon:const Icon(Icons.edit))),
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.uid == event.userId,
            child: IconButton(onPressed: () async {
              await FireStoreManager.deleteEvent(event.id??"");
              if (context.mounted) {
                Navigator.pop(context);
              }
            }, icon:const Icon(Icons.delete_rounded,color:
              Colors.red,)),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(eventImage[event.type]!)),
          const SizedBox(height: 16,),
          Text(event.title??"",style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: ColorsManager.primaryColor
          ),),
          const SizedBox(height: 16,),
           DateAndLocationCard(icon: Icons.date_range_outlined,
              title: Provider.formatEventDate(event.dateTime!),
          subTitle: Provider.formatEventTime(event.dateTime!)),
          const SizedBox(height: 16,),
          DateAndLocationCard(icon: Icons.gps_fixed_rounded,
            title: "${event.city},${event.country}",
            trailingIcon: true,
          ),
          const SizedBox(height: 16,),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorsManager.primaryColor, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(event.latitude ?? 0, event.longitude ?? 0),
                    zoom: 17,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(
                        event.latitude ?? 0,
                        event.longitude ?? 0,
                      ),
                      infoWindow: InfoWindow(
                        title: event.title,
                        snippet: '${event.city}, ${event.country}',
                      ),
                    ),
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Text(event.desc ?? '', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),

        ],
      ),
    );
  }
}
