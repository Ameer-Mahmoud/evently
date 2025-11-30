import 'package:evently_c16/ui/home/tabs/mapTabs/providrs/mapTabpProvider.dart';
import 'package:evently_c16/ui/home/tabs/mapTabs/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/ColorsManager.dart'; // لو لسه مش مستوردها

class Maptab extends StatelessWidget {
  const Maptab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapTapProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getUserLocation();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: ColorsManager.lightBackgroundColor,
        child: const Icon(Icons.gps_fixed),
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: provider.cameraPosition,
                  mapType: MapType.normal,
                  markers: provider.markers,
                  onMapCreated: (controller) {
                    provider.mapController = controller;
                  },
                ),
              ),
            ],
          ),

          // Event Cards Slider
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 124,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return EventCard(event: provider.events[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: provider.events.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
