import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/providers/userProvider.dart';
import 'package:evently_c16/ui/create/screen/creat_event_screen.dart';
import 'package:evently_c16/ui/home/tabs/heartTab/heartTab.dart';
import 'package:evently_c16/ui/home/tabs/homeTabs/homeTab.dart';
import 'package:evently_c16/ui/home/tabs/mapTabs/mapTab.dart';
import 'package:evently_c16/ui/home/tabs/mapTabs/providrs/mapTabpProvider.dart';
import 'package:evently_c16/ui/home/tabs/userTab/userTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    const Hometab(),
    ChangeNotifierProvider(
        create: (context)=> MapTapProvider(),
        child: const Maptab()),
    const HeartTab(),
    const Usertab()
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context,listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex){
          setState(() {
            selectedIndex = newIndex;
          });

        },
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : ColorsManager.primaryColor,


        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            activeIcon: SvgPicture.asset("assets/images/home_selected.svg"),
            label: "Home",

          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/map.svg"),
            activeIcon: SvgPicture.asset("assets/images/map_selected.svg"),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/heart.svg"),
            activeIcon: SvgPicture.asset("assets/images/heart_selected.svg"),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/user.svg"),
            activeIcon: SvgPicture.asset("assets/images/user_selected.svg"),
            label: "Profile",
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, RoutesManager.create);

      },

      child: const Icon(Icons.add,size: 40,color: Colors.white,),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : ColorsManager.primaryColor,

      ),


    );
  }
}
