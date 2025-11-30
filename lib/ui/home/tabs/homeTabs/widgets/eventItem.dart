import 'package:evently_c16/core/models/event.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialogutils.dart';
import 'package:evently_c16/core/source/remote/fireStoremanager.dart';
import 'package:evently_c16/providers/userProvider.dart';
import 'package:evently_c16/ui/details/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../create/screen/creat_event_screen.dart';

class Eventitem extends StatefulWidget {
   final Event event;
  const Eventitem({super.key, required this.event,});

  @override
  State<Eventitem> createState() => _EventitemState();
}

class _EventitemState extends State<Eventitem> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    UserProvider provider = Provider.of<UserProvider>(context);
    bool isFavorite = provider.user?.wishlist?.contains(widget.event.id!)?? false;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutesManager.eventDetailScreen,arguments: widget.event);
      },
      child: Container(

        height: 0.26*height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage(eventImage[widget.event.type]!),
            fit: BoxFit.cover,
        ),
          borderRadius: BorderRadius.circular(16),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Text(widget.event.dateTime!.toDate().day.toString(),
                    style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorsManager.primaryColor
                  ),),
                  Text(DateFormat.MMM().format(widget.event.dateTime!.toDate()),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorsManager.primaryColor)),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 8) ,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.surface
                    : Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(widget.event.title!,style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),),
                  ),

                  IconButton(onPressed: ()async {
                    if(isFavorite){
                      DialogUtils.showLoadingDialog(context);
                        await FireStoreManager.deleteEventWishList(widget.event);
                      provider.user?.wishlist?.remove(widget.event.id!);
                      await FireStoreManager.updateUserWishlist(provider.user?.wishlist??[]);
                      Navigator.pop(context);
                      DialogUtils.showToast(context, "Event deleted from your wishlist");


                    }else{

                      DialogUtils.showLoadingDialog(context);
                      await FireStoreManager.addEventWishList(widget.event);
                      provider.user?.wishlist?.add(widget.event.id!);
                      await FireStoreManager.updateUserWishlist(provider.user?.wishlist??[]);
                      Navigator.pop(context);
                      DialogUtils.showToast(context, "Event Added to your wishlist");

                    }
                    setState(() {

                    });
                  },
                      icon: SvgPicture.asset(
                        isFavorite?
                        "assets/images/heart_selected.svg"
                            :"assets/images/heart.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                      ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
