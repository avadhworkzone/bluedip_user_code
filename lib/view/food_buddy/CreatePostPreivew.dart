import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_preview_res_model.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/food_buddy/CreatePost.dart';
import 'package:bluedip_user/viewModel/bottom_view_model.dart';
import 'package:bluedip_user/viewModel/food_buddy_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Model/HoursModel.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_search.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../modal/apis/api_response.dart';
import '../bottomsheets/BottomSheetBestDeal.dart';
import '../RedeemOfferDetailPage.dart';
import 'SelectContact.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';

class CreatePostPreivew extends StatefulWidget {
  CreatePostPreivew({Key? key, required this.postId}) : super(key: key);
  int postId;

  @override
  State<CreatePostPreivew> createState() => _CreatePostPreivewState();
}

class _CreatePostPreivewState extends State<CreatePostPreivew> {
  FoodBuddyViewModel foodBuddyViewModel = Get.find();
  ViewPostPreviewResModel? postPreviewRes;
  BottomViewModel bottomViewModel = Get.find();

  viewPostApiCall() async {
    await foodBuddyViewModel.viewPostPreviewViewModel(postId: widget.postId);
  }

  @override
  void initState() {
    viewPostApiCall();
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
            if (controller.viewPostPreviewApiResponse.status ==
                Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.viewPostPreviewApiResponse.status == Status.ERROR) {
              return const SizedBox();
            }
            if (controller.viewPostPreviewApiResponse.status ==
                Status.COMPLETE) {
              postPreviewRes = controller.viewPostPreviewApiResponse.data;
            }
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, top: 15.h),
                      child: Row(
                        children: [
                          back_button(),
                          SizedBox(
                            width: 24.w,
                          ),
                          // Payment
                          Text("Post Preview",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontOverpassBold,
                                  fontSize: 20.sp),
                              textAlign: TextAlign.left)
                        ],
                      ),
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
                                        child: postPreviewRes!.data!.userImg ==
                                                ""
                                            ? Image.asset(
                                                bluedip_app_icon,
                                                width: 37.w,
                                                height: 37.h,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                postPreviewRes!.data!.userImg!)
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
                                        Text(
                                            "${postPreviewRes!.data!.fullName}",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProBold,
                                                fontSize: 14.sp),
                                            textAlign: TextAlign.left),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                            "${postPreviewRes!.data!.location!.cityName ?? ""}, ${postPreviewRes!.data!.date ?? ""}",
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
                                      child: postPreviewRes!.data!.postImg == ""
                                          ? Image.asset(
                                              bluedip_app_icon,
                                              width: double.infinity,
                                              height: 234.h,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              postPreviewRes!.data!.postImg!,
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
                                  Text(
                                      "${postPreviewRes!.data!.postTitle ?? ""}",
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
                                      "${postPreviewRes!.data!.description ?? ""}",
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
                                              postPreviewRes!.data!
                                                          .preferredGender ==
                                                      "FEMALE"
                                                  ? icon_female
                                                  : postPreviewRes!.data!
                                                              .preferredGender ==
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
                                                "${postPreviewRes!.data!.preferredGender ?? ""}",
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
                                              postPreviewRes!.data!
                                                          .preferredFood ==
                                                      "VEG"
                                                  ? icon_veg_second
                                                  : postPreviewRes!.data!
                                                              .preferredFood ==
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
                                                "${postPreviewRes!.data!.preferredFood ?? ""}",
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 30.h),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  CommonBorderButton("Edit".toUpperCase(), () {
                                Get.to(() => CreatePost(
                                    postId: widget.postId,
                                    isPreviewEdit: true));
                              }, red_dc3642, Colors.transparent, red_dc3642)),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              flex: 2,
                              child: CommonRedButton("Post".toUpperCase(),
                                  () async {
                                await foodBuddyViewModel.uploadPostViewModel(
                                    postId: widget.postId);
                                if (foodBuddyViewModel
                                        .uploadPostApiResponse.status ==
                                    Status.COMPLETE) {
                                  CommonResModel res = foodBuddyViewModel
                                      .uploadPostApiResponse.data;
                                  if (res.status == true) {
                                    bottomViewModel.currentIndex = 2;
                                    Get.offAll(
                                        () => const BottomNavigationScreen());
                                  } else {
                                    snackBar(title: res.message);
                                  }
                                }
                                if (foodBuddyViewModel
                                        .uploadPostApiResponse.status ==
                                    Status.ERROR) {
                                  const ServerError();
                                }
                              }, red_dc3642)),
                        ],
                      ),
                    )
                  ],
                ),
                GetBuilder<FoodBuddyViewModel>(
                  builder: (controller) {
                    if (controller.uploadPostApiResponse.status ==
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
