import 'package:evently_c16/ui/home/tabs/mapTabs/providrs/mapTabpProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/models/event.dart';
import '../../../../../core/resources/AppConstants.dart';
import '../../../../../core/resources/ColorsManager.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MapTapProvider>().navigateToEventLocationOnMap(
            LatLng(event.latitude??=0 , event.longitude??=0),
            event);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .8,
        ),
        decoration: BoxDecoration(
          color: ColorsManager.lightBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.primaryColor, width: 1),
        ),
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.asset(eventImage[event.type]!),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${event.title}\n${event.desc}',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        "assets/images/map.svg",
                        colorFilter: const ColorFilter.mode(
                          ColorsManager.blackColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${event.city}, ${event.country}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}