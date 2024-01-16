// import 'dart:async';
//
// import 'package:bluedip_user/Model/CityListModel.dart';
// import 'package:bluedip_user/Styles/my_colors.dart';
// import 'package:bluedip_user/Styles/my_font.dart';
// import 'package:bluedip_user/Styles/my_icons.dart';
// import 'package:bluedip_user/modal/apiModel/request_modal/get_resturent_list_req_model.dart';
// import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
// import 'package:bluedip_user/view/home/Homepage.dart';
// import 'package:bluedip_user/Widget/card_box_shadow.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../Model/HoursModel.dart';
// import '../../Styles/my_strings.dart';
// import '../../Widget/Textfield.dart';
// import '../../Widget/back_button.dart';
// import '../../Widget/search_bar.dart';
// import '../../Widget/toolbar_with_search.dart';
// import '../../Widget/toolbar_with_title.dart';
// import '../../Widget/toolbar_with_title_cancel.dart';
// import '../bottomsheets/BottomSheetBestDeal.dart';
// import '../RedeemOfferDetailPage.dart';
// import '../../Widget/common_red_button.dart';
// import '../../Widget/common_verify_red_button.dart';
//
// class FilterScreen extends StatefulWidget {
//   const FilterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }
//
// class _FilterScreenState extends State<FilterScreen> {
//   List<String> selectedList = [];
//   GetRestaurantListReqModel getRestaurantListReqModel =
//       GetRestaurantListReqModel();
//
//   List<CityListModel> onExtraSide = [
//     CityListModel("Takeaway Only"),
//     CityListModel("Dine-in Only"),
//   ];
//
//   List<CityListModel> selectedListCategory = [];
//
//   List<CityListModel> onCategory = [
//     CityListModel("All"),
//     CityListModel("Breakfast"),
//     CityListModel("Lunch"),
//     CityListModel("Dinner"),
//   ];
//
//   List<CityListModel> selectedListCuisine = [];
//
//   List<CityListModel> onCuisine = [
//     CityListModel("All"),
//     CityListModel("American"),
//     CityListModel("Asian"),
//     CityListModel("Bakery"),
//   ];
//
//   String selectedDay = "";
//   int mySelectConsultation = -1;
//   List<CityListModel> onRating = [
//     CityListModel("All"),
//     CityListModel("4.0+"),
//     CityListModel("3.0+"),
//     CityListModel("2.0+"),
//   ];
//
//   int myposition = 2;
//   bool text = false;
//
//   int _value = 1000;
//   String _status = '2500';
//   int _value_percentage = 30;
//   String _status_percentage = '50';
//
//   List<HoursModel> onOfferModel = [
//     HoursModel("Virigin", ""),
//     HoursModel("The Original", "20"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: white_ffffff, // navigation bar color
//       statusBarColor: white_ffffff, // status bar color
//       statusBarIconBrightness: Brightness.dark, // status bar icons' color
//       systemNavigationBarIconBrightness:
//           Brightness.light, //navigation bar icons' color
//     ));
//     return AnnotatedRegion(
//       value: const SystemUiOverlayStyle(
//         systemNavigationBarColor: Colors.white, // navigation bar color
//         statusBarColor: Colors.white, // status bar color
//         statusBarIconBrightness: Brightness.dark, // status bar icons' color
//         systemNavigationBarIconBrightness: Brightness.light,
//       ),
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ToolbarWithTitleCancel("Filter"),
//               Expanded(
//                 flex: 1,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /*Select Type*/
//                         Container(
//                           width: double.infinity,
//                           decoration: cardboxDecoration,
//                           padding: EdgeInsets.only(
//                               left: 14.w, top: 14.w, bottom: 5.h),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // How was your food?
//                               Text("Select Type",
//                                   style: TextStyle(
//                                       color: black_504f58,
//                                       fontFamily: fontMavenProProSemiBold,
//                                       fontSize: 15.sp),
//                                   textAlign: TextAlign.left),
//                               // SizedBox(height: 14.h,),
//
//                               GridView.builder(
//                                   primary: false,
//                                   shrinkWrap: true,
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2,
//                                           childAspectRatio: 3.h,
//                                           mainAxisSpacing: 0.0,
//                                           crossAxisSpacing: 10.0),
//                                   itemCount: onExtraSide.length,
//                                   itemBuilder: (context, i) => GestureDetector(
//                                         onTap: () {
//                                           setState(
//                                             () {
//                                               if (selectedList.contains(
//                                                   onExtraSide[i].title)) {
//                                                 selectedList.remove(
//                                                     onExtraSide[i].title);
//                                               } else {
//                                                 selectedList
//                                                     .add(onExtraSide[i].title);
//                                               }
//                                             },
//                                           );
//                                           setState(() {
//                                             // final removedBrackets = selectedList.toString().substring(1, selectedList.toString().length - 1);
//                                             // final parts = removedBrackets.split(', ');
//                                             //
//                                             // var joined = parts.map((part) => "$part").join(', ');
//                                             //
//                                             // print(joined);
//                                             // MyConstant.strdays=joined;
//                                           });
//                                         },
//                                         child: Container(
//                                           color: Colors.white,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               SvgPicture.asset(
//                                                 selectedList.contains(
//                                                         onExtraSide[i].title)
//                                                     ? icon_selected_checkbox
//                                                     : icon_unselected_checkbox,
//                                                 width: 20.w,
//                                                 height: 20.h,
//                                               ),
//                                               SizedBox(
//                                                 width: 8.w,
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(top: 18),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(onExtraSide[i].title,
//                                                         style: TextStyle(
//                                                           color: black_504f58,
//                                                           fontFamily:
//                                                               fontMavenProMedium,
//                                                           fontStyle:
//                                                               FontStyle.normal,
//                                                           fontSize: 14.sp,
//                                                           //overflow: TextOverflow.ellipsis
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.left),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                             ],
//                           ),
//                         ),
//                         /*Select Category*/
//                         Container(
//                           width: double.infinity,
//                           decoration: cardboxDecoration,
//                           padding: EdgeInsets.only(
//                               left: 14.w, top: 14.w, bottom: 14.h),
//                           margin: EdgeInsets.symmetric(vertical: 20.h),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // How was your food?
//                                 Text("Select",
//                                     style: TextStyle(
//                                         color: black_504f58,
//                                         fontFamily: fontMavenProProSemiBold,
//                                         fontSize: 15.sp),
//                                     textAlign: TextAlign.left),
//                                 SizedBox(
//                                   height: 14.h,
//                                 ),
//                                 Wrap(
//                                   children: [
//                                     ...List.generate(
//                                       onCategory.length,
//                                       (index) => GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             print("Click checking");
//                                             if (selectedListCategory
//                                                 .contains(onCategory[index])) {
//                                               selectedListCategory
//                                                   .remove(onCategory[index]);
//                                             } else {
//                                               selectedListCategory
//                                                   .add(onCategory[index]);
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           margin: EdgeInsets.only(
//                                               right: 8.w, bottom: 8.h),
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: selectedListCategory
//                                                         .contains(
//                                                             onCategory[index])
//                                                     ? red_dc3642
//                                                     : grey_d9dde3),
//                                             color: selectedListCategory
//                                                     .contains(onCategory[index])
//                                                 ? Color(0x14dc3642)
//                                                 : Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(8.r),
//                                           ),
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 14.w, vertical: 5.h),
//                                           child: Text(
//                                             onCategory[index].title,
//                                             style: TextStyle(
//                                                 color: black_504f58,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontFamily: fontMavenProMedium,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontSize: 14.sp),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ]),
//                         ),
//                         /*Offer Percentage Cost*/
//                         Container(
//                           decoration: cardboxDecoration,
//                           padding: EdgeInsets.all(14.r),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Average Cost for 2
//                                   Text("Offer Percentage",
//                                       style: TextStyle(
//                                           color: black_504f58,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp),
//                                       textAlign: TextAlign.left),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       // Cost:
//                                       Text("Offer:",
//                                           style: TextStyle(
//                                               color: red_dc3642,
//                                               fontFamily: fontMavenProMedium,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right),
//
//                                       // 2500
//                                       Text("$_status_percentage%",
//                                           style: TextStyle(
//                                               color: red_dc3642,
//                                               fontFamily: fontMavenProMedium,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right)
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 16.h,
//                               ),
//                               SliderTheme(
//                                 data: SliderThemeData(
//                                   // here
//                                   trackHeight: 6,
//                                   thumbColor: Blue_5468ff,
//
//                                   //    thumbShape: SliderThumbImage(customImage,context),
//                                   overlayShape:
//                                       RoundSliderOverlayShape(overlayRadius: 1),
//                                   // thumbShape: const CircleThumbShape(thumbRadius: 20),
//                                   trackShape: CustomTrackShape(),
//                                 ),
//                                 child: Slider(
//                                     value: _value_percentage.toDouble(),
//                                     min: 10.0,
//                                     max: 50.0,
//                                     activeColor: red_dc3642,
//                                     inactiveColor: light_red_ffd7d7,
//                                     label: 'Set volume value',
//                                     onChanged: (double newValue) {
//                                       setState(() {
//                                         _value_percentage = newValue.toInt();
//                                         _status_percentage =
//                                             '${_value_percentage.toInt()}';
//                                       });
//                                     },
//                                     semanticFormatterCallback:
//                                         (double newValue) {
//                                       return '${newValue.round()} dollars';
//                                     }),
//                               ),
//                               SizedBox(
//                                 height: 4.h,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // 500
//                                   Text("10%",
//                                       style: TextStyle(
//                                           color: black_504f58,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp),
//                                       textAlign: TextAlign.right),
//
//                                   Text("50%+",
//                                       style: TextStyle(
//                                           color: black_504f58,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp),
//                                       textAlign: TextAlign.right)
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         /*Average Cost*/
//                         Container(
//                           decoration: cardboxDecoration,
//                           padding: EdgeInsets.all(14.r),
//                           margin: EdgeInsets.symmetric(vertical: 20.h),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Average Cost for 2
//                                   Text("Average Cost for 2",
//                                       style: TextStyle(
//                                           color: black_504f58,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp),
//                                       textAlign: TextAlign.left),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       // Cost:
//                                       Text("Cost:",
//                                           style: TextStyle(
//                                               color: red_dc3642,
//                                               fontFamily: fontMavenProMedium,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right),
//
//                                       Image.asset(
//                                         icon_rupee_slim,
//                                         width: 12.w,
//                                         height: 12.w,
//                                         color: red_dc3642,
//                                       ),
//                                       Text("$_status",
//                                           style: TextStyle(
//                                               color: red_dc3642,
//                                               fontFamily: fontMavenProMedium,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right)
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 16.h,
//                               ),
//                               SliderTheme(
//                                 data: SliderThemeData(
//                                   // here
//                                   trackHeight: 6,
//                                   thumbColor: Blue_5468ff,
//
//                                   //    thumbShape: SliderThumbImage(customImage,context),
//                                   overlayShape:
//                                       RoundSliderOverlayShape(overlayRadius: 1),
//                                   // thumbShape: const CircleThumbShape(thumbRadius: 20),
//                                   trackShape: CustomTrackShape(),
//                                 ),
//                                 child: Slider(
//                                     value: _value.toDouble(),
//                                     min: 500.0,
//                                     max: 5000.0,
//                                     activeColor: red_dc3642,
//                                     inactiveColor: light_red_ffd7d7,
//                                     label: 'Set volume value',
//                                     onChanged: (double newValue) {
//                                       setState(() {
//                                         _value = newValue.toInt();
//                                         _status = '${_value.toInt()}';
//                                       });
//                                     },
//                                     semanticFormatterCallback:
//                                         (double newValue) {
//                                       return '${newValue.round()} dollars';
//                                     }),
//                               ),
//                               SizedBox(
//                                 height: 5.h,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         icon_rupee_slim,
//                                         width: 12.w,
//                                         height: 12.w,
//                                         color: black_504f58,
//                                       ),
//                                       Text("500",
//                                           style: TextStyle(
//                                               color: black_504f58,
//                                               fontFamily:
//                                                   fontMavenProProSemiBold,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         icon_rupee_slim,
//                                         width: 12.w,
//                                         height: 12.w,
//                                         color: black_504f58,
//                                       ),
//                                       Text("5000+",
//                                           style: TextStyle(
//                                               color: black_504f58,
//                                               fontFamily:
//                                                   fontMavenProProSemiBold,
//                                               fontSize: 15.sp),
//                                           textAlign: TextAlign.right),
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         /*Select Cuisine*/
//                         Container(
//                           width: double.infinity,
//                           decoration: cardboxDecoration,
//                           padding: EdgeInsets.only(
//                               left: 14.w, top: 14.w, bottom: 14.h),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // How was your food?
//                                 Text("Cuisine",
//                                     style: TextStyle(
//                                         color: black_504f58,
//                                         fontFamily: fontMavenProProSemiBold,
//                                         fontSize: 15.sp),
//                                     textAlign: TextAlign.left),
//
//                                 SizedBox(
//                                   height: 14.h,
//                                 ),
//                                 Wrap(
//                                   children: [
//                                     ...List.generate(
//                                       onCuisine.length,
//                                       (index) => GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             print("Click checking");
//                                             if (selectedListCuisine
//                                                 .contains(onCuisine[index])) {
//                                               selectedListCuisine
//                                                   .remove(onCuisine[index]);
//                                             } else {
//                                               selectedListCuisine
//                                                   .add(onCuisine[index]);
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           margin: EdgeInsets.only(
//                                               right: 8.w, bottom: 8.h),
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: selectedListCuisine
//                                                         .contains(
//                                                             onCuisine[index])
//                                                     ? red_dc3642
//                                                     : grey_d9dde3),
//                                             color: selectedListCuisine
//                                                     .contains(onCuisine[index])
//                                                 ? Color(0x14dc3642)
//                                                 : Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(8.r),
//                                           ),
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 14.w, vertical: 5.h),
//                                           child: Text(onCuisine[index].title,
//                                               style: TextStyle(
//                                                   color: black_504f58,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontFamily:
//                                                       fontMavenProMedium,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 14.sp)),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ]),
//                         ),
//                         /*Select Rating*/
//                         // Container(
//                         //   width: double.infinity,
//                         //   decoration: cardboxDecoration,
//                         //   margin: EdgeInsets.symmetric(vertical: 20.h),
//                         //   padding: EdgeInsets.only(left: 14.w,top: 14.w,bottom: 14.h),
//                         //   child: Column(
//                         //       mainAxisAlignment: MainAxisAlignment.start,
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [
//                         //         // How was your food?
//                         //         Text(
//                         //             "Rating",
//                         //             style:  TextStyle(
//                         //                 color:  black_504f58,
//                         //                 fontFamily: fontMavenProProSemiBold,
//                         //                 fontSize: 15.sp
//                         //             ),
//                         //             textAlign: TextAlign.left
//                         //         ),
//                         //
//                         //         SizedBox(height: 14.h,),
//                         //         SizedBox(
//                         //           height: 30,
//                         //           child: ListView.separated(
//                         //               scrollDirection: Axis.horizontal,
//                         //               primary: false,
//                         //               shrinkWrap: true,
//                         //               separatorBuilder: (BuildContext context, int i) =>
//                         //                   SizedBox(
//                         //                     width: 14.w,
//                         //                   ),
//                         //
//                         //               itemCount: onRating.length,
//                         //               itemBuilder: (context, i) =>
//                         //                     GestureDetector(
//                         //                       onTap: () {
//                         //                       setState(() {
//                         //
//                         //                         mySelectConsultation = i;
//                         //                         selectedDay = ( onRating[i].title);
//                         //                       });
//                         //
//                         //
//                         //                       },
//                         //                       child: Wrap(
//                         //                       children: [Container(
//                         //
//                         //                         decoration: BoxDecoration(
//                         //                             borderRadius: BorderRadius.circular(8.r),
//                         //                             color:mySelectConsultation ==i ?Color(0x14dc3642):Colors.white,
//                         //                             border: Border.all(
//                         //                                 width: 1,
//                         //                                 color:mySelectConsultation ==i ? red_dc3642:grey_d9dde3
//                         //                             )
//                         //                         ),
//                         //                         padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 5.h),
//                         //                         child: // All
//                         //                         Center(
//                         //                           child: Text(
//                         //                               onRating[i].title,
//                         //                               style:  TextStyle(
//                         //                                   color:  black_504f58,
//                         //                                   fontFamily: fontMavenProMedium,
//                         //                                   fontSize: 14.sp
//                         //                               ),
//                         //                               textAlign: TextAlign.center
//                         //                           ),
//                         //                         ),
//                         //                       ),],
//                         //                       ),
//                         //                     )
//                         //             ),
//                         //
//                         //
//                         //
//                         //           ),
//                         //
//                         //
//                         //       ]
//                         //   ),
//                         // ),
//
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         CommonRedButton(strSubmit.toUpperCase(), () {
//                           getRestaurantListReqModel.action =
//                               "get_restaurant_list";
//                           getRestaurantListReqModel.sorting =
//                               mySelectConsultation == 0
//                                   ? "relevance"
//                                   : mySelectConsultation == 1
//                                       ? "rating-h-l"
//                                       : mySelectConsultation == 2
//                                           ? "cost-l-h"
//                                           : "cost-h-l";
//                           getRestaurantListReqModel.status = activeTabIndex == 0
//                               ? "distance"
//                               : activeTabIndex == 1
//                                   ? "best-deals"
//                                   : "new";
//                           getRestaurantListReqModel.lat =
//                               PreferenceManagerUtils.getLatitude();
//                           getRestaurantListReqModel.lang =
//                               PreferenceManagerUtils.getLongitude();
//                           getRestaurantListReqModel.keyword = "";
//
//                           await getRestaurantListViewModel.restaurantList(
//                               body: getRestaurantListReqModel);
//                           FocusScope.of(context).unfocus();
//                           Get.back();
//                         }, red_dc3642),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CustomTrackShape extends RoundedRectSliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final trackHeight = sliderTheme.trackHeight;
//     final trackLeft = offset.dx;
//     final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 1.3;
//     final trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
// }
