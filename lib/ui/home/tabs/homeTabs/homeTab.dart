import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/widgets/allView.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/widgets/birthDayView.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/widgets/bookClupView.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/widgets/sportView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../providers/userProvider.dart';

class Hometab extends StatefulWidget {
  const Hometab({super.key});

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  int selectedTap =0;
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.surface:
               Theme.of(context).colorScheme.primary,
              borderRadius:  BorderRadius.circular(24),

            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome Back ",style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),),
                  provider.user==null?
                      const Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      ),)
                  :Text(provider.user!.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),),
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/map.svg"),
                      const SizedBox(width: 4,),
                      Text("${provider.user?.city ?? "Unknown"}, ${provider.user?.country ?? "Unknown"}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                      ),),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  TabBar(
                    onTap: (value){
                      setState(() {
                        selectedTap = value;
                      });
                    },
                    isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelColor: ColorsManager.primaryColor ,
                      unselectedLabelColor: ColorsManager.lightBackgroundColor,
                      labelStyle:const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ) ,
                      unselectedLabelStyle:const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ) ,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(46),
                        color: Theme.of(context).colorScheme.surface,

                      ),
                      tabs:
                  [
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16
                        ),

                        decoration : BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: ColorsManager.lightBackgroundColor)
                        ),

                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/Compass.svg",
                            colorFilter: ColorFilter.mode(
                                selectedTap == 0? ColorsManager.primaryColor:
                                ColorsManager.lightBackgroundColor,
                                BlendMode.srcIn),),
                            const SizedBox(width: 8,),
                            const Text("All")
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16
                        ),

                        decoration : BoxDecoration(
                            borderRadius: BorderRadius.circular(46),
                            border: Border.all(color: ColorsManager.lightBackgroundColor)
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/bike.svg",
                              colorFilter: ColorFilter.mode(
                                  selectedTap == 1? ColorsManager.primaryColor:
                                  ColorsManager.lightBackgroundColor,
                                  BlendMode.srcIn),),
                            const SizedBox(width: 8,),
                            const Text("Sport")
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16
                        ),

                        decoration : BoxDecoration(
                            borderRadius: BorderRadius.circular(46),
                            border: Border.all(color: ColorsManager.lightBackgroundColor)
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/cake.svg",
                              colorFilter: ColorFilter.mode(
                                  selectedTap == 2? ColorsManager.primaryColor:
                                  ColorsManager.lightBackgroundColor,
                                  BlendMode.srcIn),),
                            const SizedBox(width: 8,),
                            const Text("Birthday")
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16
                        ),

                        decoration : BoxDecoration(
                            borderRadius: BorderRadius.circular(46),
                            border: Border.all(color: ColorsManager.lightBackgroundColor)
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/book-open.svg",
                              colorFilter: ColorFilter.mode(
                                  selectedTap == 3? ColorsManager.primaryColor:
                                  ColorsManager.lightBackgroundColor,
                                  BlendMode.srcIn),),
                            const SizedBox(width: 8,),
                            const Text("Book Club")
                          ],
                        ),
                      ),
                    ),

                  ]
                  ),


                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                  children: [
                Allview(),
                Sportview(),
                Birthdayview(),
                Bookclupview(),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
