import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/viewModel/auth_view_model.dart';
import 'package:bluedip_user/viewModel/location_view_model.dart';
import 'package:bluedip_user/viewModel/upload_image_view_model.dart';
import 'package:bluedip_user/viewModel/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'view/splash/SplashScreen.dart';
import 'viewModel/bottom_view_model.dart';
import 'viewModel/food_buddy_view_model.dart';
import 'viewModel/get_restaurent_list_view_model.dart';
import 'viewModel/order_view_model.dart';
import 'viewModel/resto_detail_view_model.dart';
import 'viewModel/user_detail_view_model.dart';

Future<void> main() async {
  runApp(MyApp());
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            },
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: red_dc3642,
                // selectionColor: darkPrimarySwatchColor,
                // selectionHandleColor: darkPrimarySwatchColor,
              ),
              primarySwatch: Colors.blue,
            ),
            // home: SelecLocationList(),
            home: const SplashScreen(),
            // home: MapSample(),
          );
        });
  }

  AuthViewModel authViewModel = Get.put(AuthViewModel());
  GetCityViewModel getCityViewModel = Get.put(GetCityViewModel());
  GetRestaurantListViewModel getRestaurantListViewModel =
      Get.put(GetRestaurantListViewModel());
  WishListViewModel wishListViewModel = Get.put(WishListViewModel());
  UploadImageViewModel uploadImageViewModel = Get.put(UploadImageViewModel());
  RestoDetailViewModel restoDetailViewModel = Get.put(RestoDetailViewModel());
  UserDetailViewModel userDetailViewModel = Get.put(UserDetailViewModel());
  OrderViewModel orderViewModel = Get.put(OrderViewModel());
  BottomViewModel bottomViewModel = Get.put(BottomViewModel());
  FoodBuddyViewModel foodBuddyViewModel = Get.put(FoodBuddyViewModel());
}
