// import 'package:bluedip_user/Styles/my_icons.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// import '../Styles/my_colors.dart';
// import '../Styles/my_font.dart';
// import '../Widget/toolbar_with_search.dart';
// import 'RedeemAdsOns.dart';
//
// class RedeemExpandOrderrtest extends StatefulWidget {
//   const RedeemExpandOrderrtest({Key? key}) : super(key: key);
//
//   @override
//   State<RedeemExpandOrderrtest> createState() => _RedeemExpandOrderState();
// }
//
// class _RedeemExpandOrderState extends State<RedeemExpandOrderrtest> {
//   final List<League> data = <League>[
//     League(
//       'Starters',
//       <Club>[
//         Club(icon_veg_second, "Bloddy Mary", 0),
//         Club(icon_non_veg_second, "Chicken Tikka", 0),
//       ],false
//     ),
//     League(
//       'Burrito Stars',
//       <Club>[
//         Club(icon_veg_second, "Bloddy Mary", 0),
//         Club(icon_non_veg_second, "Chicken Tikka", 0),
//       ],false
//     ),
//     League(
//       'Main Course',
//       <Club>[
//         Club(icon_veg_second, "Bloddy Mary", 0),
//         Club(icon_non_veg_second, "Chicken Tikka", 0),
//       ],false
//     ),
//     League(
//       'Fast Food',
//       <Club>[
//         Club(icon_veg_second, "Bloddy Mary", 0),
//         Club(icon_non_veg_second, "Chicken Tikka", 0),
//       ],false
//     ),
//     League(
//         'Starters',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Burrito Stars',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Main Course',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Fast Food',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Starters',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Burrito Stars',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Main Course',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//     League(
//         'Fast Food',
//         <Club>[
//           Club(icon_veg_second, "Bloddy Mary", 0),
//           Club(icon_non_veg_second, "Chicken Tikka", 0),
//         ],false
//     ),
//   ];
//
//   bool isNextRedLayout = false;
//   bool isCounter = false;
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
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: white_ffffff,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ToolbarWithTitleSearch("Pizza Hut",icon_search),
//             const Divider(
//               height: 1,
//               thickness: 1,
//               color: divider_d4dce7,
//             ),
//
//             Expanded(
//               flex: 1,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.only(bottom: 20.h),
//                       itemBuilder: (BuildContext context, int index) =>
//
//                           data[index].listClubs.isNotEmpty
//                               ? Column(
//                                   children: [
//                                     Theme(
//                                       data: Theme.of(context).copyWith(
//                                           dividerColor: Colors.transparent),
//                                       child: ExpansionTile(
//                                         iconColor: grey_77879e,
//                                         collapsedIconColor: grey_77879e,
//                                         onExpansionChanged: (value) {
//                                           setState(() {
//                                             data[index].isExpandArrow = value;
//                                           });
//                                         },
//                                         trailing: AnimatedRotation(  /// you can use different widget for animation
//                                             turns: data[index].isExpandArrow ? .5 : 0,
//                                             duration: const Duration(milliseconds: 1),
//                                             child: SvgPicture.asset(icon_down_arrow_expand)// your svgImage here
//                                         ),
//
//                                         key:
//                                             PageStorageKey<League>(data[index]),
//                                         tilePadding: EdgeInsets.symmetric(
//                                             horizontal: 16.w),
//                                         title: Text(data[index].TvTitle,
//                                             style: TextStyle(fontSize: 16.sp, fontFamily: fontOverpassBold, color:black_504f58)),
//                                         children :data[index]
//                                             .listClubs.asMap().entries.map(
//                                               (pos) {
//
//                                             return Builder(
//                                               builder: (BuildContext context) {
//                                                 return  Column(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//
//                                                     GestureDetector(
//                                                       onTap: () {},
//                                                       child: Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                             horizontal:
//                                                             16.w),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                               crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                               mainAxisSize:
//                                                               MainAxisSize
//                                                                   .max,
//                                                               children: [
//                                                                 SvgPicture
//                                                                     .asset(data[index]
//                                                                     .listClubs[pos.key].icon,),
//                                                                 SizedBox(
//                                                                   width: 10.w,
//                                                                 ),
//                                                                 Expanded(
//                                                                   flex: 1,
//                                                                   child: Column(
//                                                                     mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .start,
//                                                                     crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                     children: [
//                                                                       Text(data[index].listClubs[pos.key].tvLable, style: TextStyle(fontSize: 14.sp, fontFamily: fontMavenProMedium, color:black_504f58)),
//                                                                       SizedBox(
//                                                                         height:
//                                                                         6.h,
//                                                                       ),
//                                                                       Row(
//                                                                         children: [
//                                                                           Text(
//                                                                               "\u{20B9}300",
//                                                                               style: TextStyle(
//                                                                                 color: grey_77879e,
//                                                                                     fontFamily: fontMavenProMedium,
//                                                                                     fontSize: 12.sp,
//                                                                                     decoration: TextDecoration.lineThrough,
//
//                                                                               ),
//                                                                           ),
//                                                                           SizedBox(
//                                                                             width:
//                                                                             8.w,
//                                                                           ),
//                                                                           Row(
//                                                                             children: [
//                                                                               Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,color: green_5cb85c,),
//                                                                               Text(
//                                                                                   "250",
//                                                                                   style:  TextStyle(
//                                                                                       color: green_5cb85c,
//                                                                                       fontFamily: fontMavenProProSemiBold,
//                                                                                       fontSize: 15.sp
//                                                                                   ),
//                                                                                   textAlign: TextAlign.right
//                                                                               )
//                                                                             ],
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height:
//                                                                         8.h,
//                                                                       ),
//                                                                       Text(
//                                                                           "Crunchy corn chips topped ",
//                                                                           style:  TextStyle(
//                                                                               color:  grey_5f6d7b,
//                                                                               fontFamily: fontMavenProRegular,
//                                                                               fontSize: 12.sp
//                                                                           ),
//                                                                           textAlign: TextAlign.left
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height:
//                                                                         16.h,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//
//                                                                 SizedBox(
//                                                                   width: 100.w,
//                                                                   child: Stack(
//                                                                     alignment:
//                                                                     Alignment
//                                                                         .topRight,
//                                                                     children: [
//                                                                       InkWell(
//                                                                           onTap:
//                                                                               () {
//                                                                             setState(() {
//                                                                               data[index]
//                                                                                   .listClubs[pos.key].count = data[index]
//                                                                                   .listClubs[pos.key].count + 1;
//                                                                             });
//                                                                           },
//                                                                           child:
//                                                                           Visibility(
//                                                                             visible:
//                                                                             data[index]
//                                                                                 .listClubs[pos.key].count <= 0,
//                                                                             child:
//                                                                             Container(
//                                                                               width: 100,
//                                                                               height: 36,
//                                                                               decoration: BoxDecoration(
//                                                                                   borderRadius: BorderRadius.circular(5.r),
//                                                                                   border: Border.all(
//                                                                                       width: 1,
//                                                                                       color: red_dc3642
//                                                                                   )
//                                                                               ),
//                                                                               child: // Frame 34532
// // ADD
//                                                                               Center(
//                                                                                 child: Text(
//                                                                                     "ADD",
//                                                                                     style:  TextStyle(
//                                                                                         color: red_dc3642,
//                                                                                         fontWeight: FontWeight.w600,
//                                                                                         fontFamily: fontMavenProProSemiBold,
//                                                                                         fontStyle:  FontStyle.normal,
//                                                                                         fontSize: 15.sp
//                                                                                     ),
//                                                                                     textAlign: TextAlign.center
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           )),
//                                                                       Visibility(
//                                                                         visible:
//                                                                         data[index]
//                                                                             .listClubs[pos.key].count >
//                                                                             0,
//                                                                         child:
//                                                                         Container(
//                                                                           width: 100,
//                                                                           height: 36,
//                                                                           decoration: BoxDecoration(
//                                                                               borderRadius: BorderRadius.circular(5.r),
//                                                                               color: Color(0x11dc3642),
//                                                                               border: Border.all(
//                                                                                   width: 1,
//                                                                                   color: red_dc3642
//                                                                               )
//                                                                           ),
//                                                                           // margin: EdgeInsets.only(left: 8,right: 8,top: 0),
//                                                                           child:
//                                                                           Row(
//                                                                             mainAxisAlignment:
//                                                                             MainAxisAlignment.start,
//                                                                             mainAxisSize:
//                                                                             MainAxisSize.max,
//                                                                             children: [
//                                                                               SizedBox(
//                                                                                 width: 8.w,
//                                                                               ),
//                                                                               InkWell(
//                                                                                 onTap: () {
//                                                                                   setState(() {
//                                                                                     data[index]
//                                                                                         .listClubs[pos.key].count--;
//                                                                                     if (data[index]
//                                                                                         .listClubs[pos.key].count < 1) {}
//                                                                                   });
//                                                                                 },
//                                                                                 child: SvgPicture.asset(icon_minus_red),
//                                                                               ),
//                                                                               Expanded(
//                                                                                 flex: 1,
//                                                                                 child: Center(
//                                                                                   child: Text(
//                                                                                     data[index]
//                                                                                         .listClubs[pos.key].count.toString(),
//                                                                                     style:  TextStyle(
//                                                                                         color: black_504f58,
//                                                                                         fontFamily: fontMavenProProSemiBold,
//                                                                                         fontSize: 15.sp),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               InkWell(
//                                                                                 onTap: () {
//                                                                                   setState(() {
//                                                                                     data[index]
//                                                                                         .listClubs[pos.key].count++;
//                                                                                   });
//                                                                                 },
//                                                                                 child: SvgPicture.asset(icon_add_red),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 width: 8.w,
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//
//                                                                 //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
//                                                               ],
//                                                             ),
//                                                             Column(
//                                                               children: [
//                                                                 data[index].listClubs.length - 1 !=
//                                                                     pos.key?
//                                                                 Column(
//                                                                   children: [
//                                                                     Padding(
//                                                                       padding: EdgeInsets
//                                                                           .only(
//                                                                           left:
//                                                                           34.w),
//                                                                       child:
//                                                                       const DottedLine(
//                                                                         direction: Axis
//                                                                             .horizontal,
//                                                                         lineLength:
//                                                                         double
//                                                                             .infinity,
//                                                                         lineThickness:
//                                                                         1.0,
//                                                                         dashLength:
//                                                                         2.0,
//                                                                         dashColor:
//                                                                         divider_d9dde3,
//                                                                         dashRadius:
//                                                                         0.0,
//                                                                         dashGapLength:
//                                                                         2.0,
//                                                                         dashGapColor:
//                                                                         Colors
//                                                                             .transparent,
//                                                                         dashGapRadius:
//                                                                         0.0,
//                                                                       ),
//                                                                     ),
//
//                                                                   ],
//                                                                 ):SizedBox(),
//                                                                 data[index].listClubs.length - 1 !=
//                                                                     pos.key?SizedBox(height: 16,):SizedBox(height: 4)
//
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//
//
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                         ).toList(),
//
//                                       ),
//                                     ),
//                                     const Divider(
//                                       height: 1,
//                                       thickness: 1,
//                                       color: divider_d9dde3,
//                                     ),
//                                   ],
//                                 )
//                               : Column(
//                                   children: [
//                                     ListTile(
//                                       title: Text(data[index].TvTitle,
//                                           style: TextStyle(
//                                               fontSize: 14.sp,
//                                               // fontFamily: fontOverpassBold,
//                                               color: black_504f58)),
//                                     ),
//                                     // Divider(
//                                     //   height: 1,
//                                     //   thickness: 1,
//                                     //   color: grey_969da8,
//                                     // ),
//                                   ],
//                                 ), itemCount: data.length,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Stack(
//               children: [
//                 // Showing 30% off deal applied
//                 GestureDetector(
//                   onTap: (){
//                     setState(() {
//                       isNextRedLayout = true;
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(17.r),
//                     color: green_5cb85c,
//                     width: double.infinity,
//                     child: Text(
//                         "Showing 30% off deal applied",
//                         style:  TextStyle(
//                             color:  Colors.white,
//                             fontFamily: fontMavenProRegular,
//                             fontSize: 14.sp
//                         ),
//                         textAlign: TextAlign.center
//                     ),
//                   ),
//                 ),
//
//                 Visibility(
//                   visible: isNextRedLayout,
//                   child: Container(
//                     padding: EdgeInsets.only(right: 16.w,top: 11.h,bottom: 11.h),
//                     color: red_dc3642,
//                     width: double.infinity,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // ₹15.53
//                               Text(
//                                   "2",
//                                   style:  TextStyle(
//                                       color:  Colors.white,
//                                       fontFamily: fontMavenProProSemiBold,
//                                       fontSize: 15.sp
//                                   ),
//                                   textAlign: TextAlign.center
//                               ),
//                               SizedBox(height: 2.h,),
//                               Text(
//                                   "Items",
//                                   style:  TextStyle(
//                                       color:  Colors.white,
//                                       fontFamily: fontMavenProMedium,
//                                       fontSize: 14.sp
//                                   ),
//                                   textAlign: TextAlign.center
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 35.h,
//                           width: 1,
//                           color: white_ffffff,
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // ₹15.53
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(icon_rupee_slim,color: Colors.white,width: 12.w,height: 12.h,),
//                                   Text(
//                                       "15.53",
//                                       style:  TextStyle(
//                                           color:  Colors.white,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp
//                                       ),
//                                       textAlign: TextAlign.center
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 2.h,),
//                               Text(
//                                   "Total",
//                                   style:  TextStyle(
//                                       color:  Colors.white,
//                                       fontFamily: fontMavenProMedium,
//                                       fontSize: 14.sp
//                                   ),
//                                   textAlign: TextAlign.center
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 35.h,
//                           width: 1,
//                           color: white_ffffff,
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  Image.asset(icon_rupee_slim,color: Colors.white,width: 12.w,height: 12.h,),
//                                  Text(
//                                      "4.53",
//                                      style:  TextStyle(
//                                          color:  Colors.white,
//                                          fontFamily: fontMavenProProSemiBold,
//                                          fontSize: 15.sp
//                                      ),
//                                      textAlign: TextAlign.center
//                                  ),
//                                ],
//                              ),
//
//                               SizedBox(height: 2.h,),
//                               Text(
//                                   "Savings",
//                                   style:  TextStyle(
//                                       color:  Colors.white,
//                                       fontFamily: fontMavenProMedium,
//                                       fontSize: 14.sp
//                                   ),
//                                   textAlign: TextAlign.center
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 20.h,),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const RedeemAdsOns(),
//                                 ));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(14.r),
//                                 color: Colors.white
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 35.w,vertical: 15.h),
//                             child: // button
//                             Text(
//                                 "Next".toUpperCase(),
//                                 style:  TextStyle(
//                                     color:  red_dc3642,
//                                     fontFamily: fontMavenProMedium,
//                                     fontSize: 15.sp
//                                 ),
//                                 textAlign: TextAlign.center
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class League {
//   String TvTitle;
//   bool isExpandArrow=false;
//   List<Club> listClubs;
//
//   League(this.TvTitle, this.listClubs,this.isExpandArrow);
// }
//
// class Club {
//   int count;
//   String icon;
//   String tvLable;
//
//   Club(this.icon, this.tvLable, this.count);
// }
