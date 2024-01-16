import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/view/profile/profile_menu/OrderHistory.dart';
import 'package:bluedip_user/viewModel/user_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/toolbar_with_title_cancel.dart';
import '../../Widget/common_red_button.dart';

class RatingBarScreen extends StatefulWidget {
  RatingBarScreen(
      {Key? key,
      required this.type,
      required this.restoId,
      required this.restoName,
      this.isNavigateHistory})
      : super(key: key);
  String restoId;
  String type;
  String restoName;
  bool? isNavigateHistory;

  @override
  State<RatingBarScreen> createState() => _RatingBarScreenState();
}

class _RatingBarScreenState extends State<RatingBarScreen> {
  UserDetailViewModel userDetailViewModel = Get.find();
  TextEditingController commentController = TextEditingController();
  double food = 0;
  double resto = 0;
  double atmosphere = 0;
  double voucher = 0;

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
        backgroundColor: bg_fafbfb,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleCancel(title: widget.restoName),
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
                      Container(
                        width: double.infinity,
                        decoration: cardboxDecoration,
                        padding: EdgeInsets.all(14.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // How was your food?
                            Text("How was your food?",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProBold,
                                    fontSize: 16.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 14.h,
                            ),
                            RatingBar(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: const Color(0xffd4dce7),
                              glowColor: const Color(0xffd4dce7),
                              itemCount: 5,
                              itemSize: 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // full: const Icon(Icons.star, color:yellow_FFC800),
                                  half: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // half: const Icon(Icons.star_half, color:yellow_FFC800,),
                                  empty: SvgPicture.asset(icon_star_border,
                                      width: 20, height: 20)),
                              onRatingUpdate: (rating) {
                                food = rating;
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: cardboxDecoration,
                        padding: EdgeInsets.all(14.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // How was your food?
                            Text("Rate the Restaurant",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProBold,
                                    fontSize: 16.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 14.h,
                            ),
                            RatingBar(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: const Color(0xffd4dce7),
                              glowColor: const Color(0xffd4dce7),
                              itemCount: 5,
                              itemSize: 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // full: const Icon(Icons.star, color:yellow_FFC800),
                                  half: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // half: const Icon(Icons.star_half, color:yellow_FFC800,),
                                  empty: SvgPicture.asset(icon_star_border,
                                      width: 20, height: 20)),
                              onRatingUpdate: (rating) {
                                resto = rating;
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: cardboxDecoration,
                        padding: EdgeInsets.all(14.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // How was your food?
                            widget.type == "delivery"
                                ? Text("how was your picked up experience?",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProBold,
                                        fontSize: 16.sp),
                                    textAlign: TextAlign.left)
                                : Text("How was the atmosphere?",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProBold,
                                        fontSize: 16.sp),
                                    textAlign: TextAlign.left),
                            SizedBox(
                              height: 14.h,
                            ),
                            RatingBar(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: const Color(0xffd4dce7),
                              glowColor: const Color(0xffd4dce7),
                              itemCount: 5,
                              itemSize: 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // full: const Icon(Icons.star, color:yellow_FFC800),
                                  half: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // half: const Icon(Icons.star_half, color:yellow_FFC800,),
                                  empty: SvgPicture.asset(icon_star_border,
                                      width: 20, height: 20)),
                              onRatingUpdate: (rating) {
                                atmosphere = rating;
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: cardboxDecoration,
                        padding: EdgeInsets.all(14.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // How was your food?
                            Text("How was the Experience using the \nvoucher?",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProBold,
                                    fontSize: 16.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 14.h,
                            ),
                            RatingBar(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: const Color(0xffd4dce7),
                              glowColor: const Color(0xffd4dce7),
                              itemCount: 5,
                              itemSize: 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // full: const Icon(Icons.star, color:yellow_FFC800),
                                  half: SvgPicture.asset(icon_small_rating_bar,
                                      width: 20, height: 20),
                                  // half: const Icon(Icons.star_half, color:yellow_FFC800,),
                                  empty: SvgPicture.asset(icon_star_border,
                                      width: 20, height: 20)),
                              onRatingUpdate: (rating) {
                                voucher = rating;
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: cardboxDecoration,
                        padding: EdgeInsets.all(14.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*commit*/
                            Text("Add review",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProBold,
                                    fontSize: 16.sp),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 14.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.r),
                                  border:
                                      Border.all(width: 1, color: grey_d9dde3)),
                              child: TextField(
                                  maxLines: 5,
                                  controller: commentController,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: fontMavenProMedium,
                                      color: black_504f58), //or null
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Write here...",
                                    hintStyle: TextStyle(
                                        fontFamily: fontMavenProMedium,
                                        color: grey_77879e,
                                        fontSize: 14.sp),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      GetBuilder<UserDetailViewModel>(
                        builder: (controller) {
                          if (controller.addRatingApiResponse.status ==
                              Status.LOADING) {
                            return CircularIndicator();
                          }
                          return CommonRedButton(strSubmit.toUpperCase(),
                              () async {
                            final total = food + resto + atmosphere + voucher;
                            double ratAvg = total / 4;
                            await userDetailViewModel.addRatingViewModel(
                                restoId: widget.restoId,
                                comment: commentController.text,
                                rating: ratAvg.toString(),
                                type: widget.type);
                            if (userDetailViewModel
                                    .addRatingApiResponse.status ==
                                Status.ERROR) {
                              const ServerError();
                            }
                            if (userDetailViewModel
                                    .addRatingApiResponse.status ==
                                Status.COMPLETE) {
                              CommonResModel res =
                                  userDetailViewModel.addRatingApiResponse.data;
                              if (res.status == true) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r)),
                                          insetPadding: EdgeInsets.all(25),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                top: 20.h,
                                                bottom: 20,
                                                left: 24.w,
                                                right: 24.w),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                // Image.asset(icon_grey_rating_bar,width: 120.w,height: 120.h,),

                                                Lottie.network(
                                                  'https://assets10.lottiefiles.com/packages/lf20_083h7wcs.json',
                                                  width: 120.w,
                                                  height: 120.h,
                                                ),

                                                Text("Awesome!",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontOverpassBold,
                                                        fontSize: 18.sp),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(
                                                  height: 6.h,
                                                ),

                                                // Here is a 25% off voucher for your first order with Bluedip!
                                                Text(
                                                    "We’ll continue to improve our platform for \nyour better experience.",
                                                    style: TextStyle(
                                                        color: grey_5f6d7b,
                                                        fontFamily:
                                                            fontMavenProRegular,
                                                        fontSize: 14.sp),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(
                                                  height: 20.h,
                                                ),

                                                SizedBox(
                                                  width: 100.w,
                                                  child: CommonRedButton(
                                                      "OK".toUpperCase(), () {
                                                    widget.isNavigateHistory ==
                                                            true
                                                        ? Get.off(
                                                            const OrderHistory())
                                                        : Get.offAll(
                                                            BottomNavigationScreen());
                                                  }, red_dc3642),
                                                ),
                                              ],
                                            ),
                                          ));
                                    });
                              } else {
                                snackBar(title: res.message);
                              }
                            }
                          }, red_dc3642);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
