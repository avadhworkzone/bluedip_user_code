import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/chat/ChatBox.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Widget/toolbar_with_more.dart';
import 'SelectContact.dart';

class OtherUserPostDetail extends StatefulWidget {
  const OtherUserPostDetail({Key? key}) : super(key: key);

  @override
  State<OtherUserPostDetail> createState() => _OtherUserPostDetailState();
}

class _OtherUserPostDetailState extends State<OtherUserPostDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleMore("", icon_menu),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 37.w,
                            height: 37.h,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                img_girl1,
                                width: 37.w,
                                height: 37.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // John Doe
                                Text("Jenny Doe",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProBold,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text("New Delhi, 31.11.2022",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 12.sp),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Image.asset(
                                img_pizza_food_buddy,
                                width: double.infinity,
                                height: 234.h,
                                fit: BoxFit.fill,
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectContact(),
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: SvgPicture.asset(icon_share_post),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Let’s eat hungers
                          Text("Let’s eat hungers",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProBold,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 4.h,
                          ),
                          // Username Lorem ipsum dolo ametconsectetur adipiscing elit, sed do eiusmod temUsername Lorem ipsum do
                          Text(
                              "Username Lorem ipsum dolo ametconsectetur adipiscing elit, sed do eiusmod temUsername Lorem ipsum dolor sit ametconsectadipiscing elit, sed do eiusmod tempor..Username Lorem ipsum dolor sit ametconsectetur ",
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp,
                                  height: 1.4),
                              textAlign: TextAlign.left)
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: divider_d4dce7,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Preferred Gender
                                Text("Preferred Gender",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 12.sp),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      icon_female,
                                      width: 22.w,
                                      height: 22.h,
                                    ),
                                    SizedBox(
                                      width: 6.h,
                                    ),
                                    Text("Female",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 15.sp),
                                        textAlign: TextAlign.left),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Preferred Gender
                                Text("Preferred Food",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 12.sp),
                                    textAlign: TextAlign.left),

                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      icon_veg_second,
                                      width: 22.w,
                                      height: 22.h,
                                    ),
                                    SizedBox(
                                      width: 6.h,
                                    ),
                                    Text("Veg",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 15.sp),
                                        textAlign: TextAlign.left),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatBox(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xff276fe9),
                          Color(0xff568aef),
                        ],
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        icon_notifcation_food_buddy,
                        color: white_ffffff,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      // Chat
                      Text("Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: fontMavenProMedium,
                              fontSize: 15.sp),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
