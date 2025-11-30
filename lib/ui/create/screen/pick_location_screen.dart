

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/ColorsManager.dart';
import '../providers/create_event_provider.dart';

class PickLocationScreen extends StatelessWidget {
  final CreateEventProvider provider;
  const PickLocationScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: provider,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: provider.cameraPosition,
                mapType: MapType.normal,
                markers: provider.markers,
                onMapCreated: (controller) {
                  provider.mapController = controller;
                },
                onTap: (location) {
                  provider.changeEventLocation(location);
                  provider.convertLatLngForEvent();
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              color: ColorsManager.primaryColor,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const Text(
                'Tap on Location To Select',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.lightBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}