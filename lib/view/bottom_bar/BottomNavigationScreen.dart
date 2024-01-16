/*
 *  Copyright 2020 mailto:chaobinwu89@gmail.com
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/view/auth/OtpVerificationScreen.dart';
import 'package:bluedip_user/view/select_location/demo_map.dart';
import 'package:bluedip_user/viewModel/bottom_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../map/BluedipMap.dart';
import '../profile/profile_menu/FavouriteScreen.dart';
import '../food_buddy/FoodBuddyScreen.dart';
import '../home/Homepage.dart';
import '../profile/Profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State createState() => _State();
}

class _State extends State<BottomNavigationScreen> {
  BottomViewModel bottomViewModel = Get.find();
  // int _currentIndex = 0;
  final tabs = [
    Homepage(),
    MapSample(),
    // const BluedipMap(),
    //  const Homepage(),
    const FoodBuddyScreen(),
    //   const FavouriteScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          body: tabs[bottomViewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: red_dc3642,
            unselectedItemColor: grey_77879e,
            selectedLabelStyle: TextStyle(
                fontFamily: fontMavenProProSemiBold,
                fontSize: 14.sp,
                color: red_dc3642,
                overflow: TextOverflow.visible),
            unselectedLabelStyle: TextStyle(
                fontFamily: fontMavenProRegular,
                fontSize: 14.sp,
                color: grey_77879e,
                overflow: TextOverflow.visible),
            currentIndex: bottomViewModel.currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_home,
                    width: 22,
                    height: 22,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_home,
                    width: 22,
                    height: 22,
                    color: red_dc3642,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_map,
                    width: 22,
                    height: 22,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_map,
                    width: 22,
                    height: 22,
                    color: red_dc3642,
                  ),
                ),
                label: "Map",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_food_buddy,
                    width: 22,
                    height: 22,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    icon_food_buddy,
                    width: 22,
                    height: 22,
                    color: red_dc3642,
                  ),
                ),
                label: "Food Buddy",
              ),
              // BottomNavigationBarItem(
              //   icon: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: SvgPicture.asset(icon_fav,width: 22,height: 22,),
              //   ),
              //   activeIcon: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: SvgPicture.asset(icon_fav,width: 22,height: 22,color:red_dc3642,),
              //   ),
              //   label: "Fav",
              // ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    icon_men,
                    width: 22,
                    height: 22,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    icon_men,
                    width: 22,
                    height: 22,
                  ),
                ),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              setState(() {
                bottomViewModel.currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
