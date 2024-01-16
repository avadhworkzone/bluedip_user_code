import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddReels extends StatefulWidget {
  const AddReels({Key? key}) : super(key: key);

  @override
  State<AddReels> createState() => _AddReelsState();
}

class _AddReelsState extends State<AddReels> {
  List<CityListModel> cityList = [
    CityListModel(img_pizza_hut),
    CityListModel(img_burger),
    CityListModel(img_pizza_hut),
    CityListModel(img_burger),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent, // navigation bar color
        statusBarColor: Colors.black, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: white_ffffff,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              img_pizzas,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                    child: SvgPicture.asset(
                      icon_cancel,
                      color: Colors.white,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      color: Color(0xe1ffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.r),
                        topRight: Radius.circular(6.r),
                      )),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 15.w,
                    ),
                    itemCount: cityList.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    itemBuilder: (context, i) => Center(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.asset(
                                cityList[i].title,
                                width: 91.w,
                                height: 91.h,
                                fit: BoxFit.fill,
                              )),
                          Padding(
                            padding: EdgeInsets.all(4.r),
                            child: SvgPicture.asset(icon_cancel_white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 26.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: grey_77879e),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: TextField(
                            // controller: titleController,
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProMedium,
                                fontSize: 14.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 16.h),
                              hintText: "Write message...",
                              hintStyle: TextStyle(
                                  color: grey_77879e,
                                  fontFamily: fontMavenProMedium,
                                  fontSize: 14.sp),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.newline,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Image.asset(
                        icon_send_status,
                        width: 29.w,
                        height: 29.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
