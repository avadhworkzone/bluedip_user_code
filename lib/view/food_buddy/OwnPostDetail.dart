import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_detail_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/food_buddy/CreatePost.dart';
import 'package:bluedip_user/view/food_buddy/FoodBuddyScreen.dart';
import 'package:bluedip_user/viewModel/bottom_view_model.dart';
import 'package:bluedip_user/viewModel/food_buddy_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Widget/back_button.dart';
import '../../Widget/toolbar_with_more.dart';
import '../chat/ChatBox.dart';
import 'SelectContact.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen({Key? key, required this.postId}) : super(key: key);
  int postId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  FoodBuddyViewModel foodBuddyViewModel = Get.find();
  ViewPostDetailResModel? res;
  BottomViewModel bottomViewModel = Get.find();

  getPostDetail() async {
    await foodBuddyViewModel.viewPostDetailViewModel(postId: widget.postId);
  }

  @override
  void initState() {
    getPostDetail();
    // TODO: implement initState
    super.initState();
  }

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
        body: GetBuilder<FoodBuddyViewModel>(
          builder: (controller) {
            if (controller.viewPostDetailApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.viewPostDetailApiResponse.status == Status.ERROR) {
              return const SizedBox();
            }
            if (controller.viewPostDetailApiResponse.status ==
                Status.COMPLETE) {
              res = controller.viewPostDetailApiResponse.data;
            }
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, top: 15.h),
                      child: res!.data!.isChat == true
                          ? ToolbarWithTitleMore("", icon_menu)
                          : GestureDetector(
                              onTap: () {
                                Get.offAll(FoodBuddyScreen());
                              },
                              child: SvgPicture.asset(icon_arrow_left)),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 20.h),
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
                                        child: res!.data!.userImg == ""
                                            ? Image.asset(
                                                bluedip_app_icon,
                                                width: 37.w,
                                                height: 37.h,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(res!.data!.userImg!)
                                        // Image.asset(
                                        //   img_men,
                                        //   width: 37.w,
                                        //   height: 37.h,
                                        //   fit: BoxFit.fill,
                                        // ),
                                        ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // John Doe
                                        Text("${res!.data!.fullName}",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProBold,
                                                fontSize: 14.sp),
                                            textAlign: TextAlign.left),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                            "${res!.data!.location!.cityName}, ${res!.data!.date}",
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
                                      child: res!.data!.postImg == ""
                                          ? Image.asset(
                                              bluedip_app_icon,
                                              width: double.infinity,
                                              height: 234.h,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              res!.data!.postImg!,
                                              width: double.infinity,
                                              height: 234.h,
                                              fit: BoxFit.fill,
                                            )),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>  SelectContact(),
                                  //         ));
                                  //   },
                                  //   child: Padding(
                                  //     padding:  EdgeInsets.all(12.r),
                                  //     child: SvgPicture.asset(icon_share_post),
                                  //   ),
                                  // )
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
                                  Text("${res!.data!.postTitle ?? ""}",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProBold,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  // Username Lorem ipsum dolo ametconsectetur adipiscing elit, sed do eiusmod temUsername Lorem ipsum do
                                  Text("${res!.data!.description ?? ""}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              res!.data!.preferredGender ==
                                                      "FEMALE"
                                                  ? icon_female
                                                  : res!.data!.preferredGender ==
                                                          'MALE'
                                                      ? icon_male
                                                      : icon_any,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.h,
                                            ),
                                            Text(
                                                "${res!.data!.preferredGender ?? ""}",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              res!.data!.preferredFood == "VEG"
                                                  ? icon_veg_second
                                                  : res!.data!.preferredFood ==
                                                          'NON_VEG'
                                                      ? icon_non_veg_second
                                                      : icon_anyfood,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.h,
                                            ),
                                            Text(
                                                "${res!.data!.preferredFood ?? ""}",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
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
                    res!.data!.isChat == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatBox(),
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 30.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 12.h),
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
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 30.h),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await foodBuddyViewModel
                                          .deletePostViewModel(
                                              postId:
                                                  res!.data!.postId!.toInt());
                                      if (foodBuddyViewModel
                                              .deletePostApiResponse.status ==
                                          Status.ERROR) {
                                        const ServerError();
                                      }
                                      if (foodBuddyViewModel
                                              .deletePostApiResponse.status ==
                                          Status.COMPLETE) {
                                        CommonResModel res = foodBuddyViewModel
                                            .deletePostApiResponse.data;
                                        if (res.status == true) {
                                          bottomViewModel.currentIndex = 2;
                                          Get.offAll(() =>
                                              const BottomNavigationScreen());
                                        } else {
                                          snackBar(title: res.message);
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          border: Border.all(
                                              width: 1, color: grey_d9dde3)),
                                      padding: EdgeInsets.all(10.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            icon_delete_black,
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          // Delete
                                          Text("Delete",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => CreatePost(
                                            postId: res!.data!.postId!.toInt(),
                                            isPreviewEdit: false,
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          border: Border.all(
                                              width: 1, color: grey_d9dde3)),
                                      padding: EdgeInsets.all(10.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            icon_edit_pen,
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          // Delete
                                          Text("Edit",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                ),
                GetBuilder<FoodBuddyViewModel>(
                  builder: (controller) {
                    if (controller.deletePostApiResponse.status ==
                        Status.LOADING) {
                      return const CircularIndicator();
                    }
                    return const SizedBox();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
