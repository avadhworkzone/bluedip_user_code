import 'dart:io';

import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_res_model.dart';
import 'package:bluedip_user/view/chat/ChatBox.dart';
import 'package:bluedip_user/view/food_buddy/StoryPage.dart';
import 'package:bluedip_user/view/food_buddy/SwipeToDeleletList.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/viewModel/food_buddy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import '../../Model/CityListModel.dart';
import '../../Widget/UnicornOutlineButton.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/home_rating_box_shadow.dart';
import '../../modal/apis/api_response.dart';
import 'AddReels.dart';
import 'CreatePost.dart';
import '../MultiAssetPage.dart';
import 'OtherUserPostDetail.dart';
import 'OwnPostDetail.dart';
import 'SelectContact.dart';
import '../TestPage.dart';

class FoodBuddyScreen extends StatefulWidget {
  const FoodBuddyScreen({Key? key}) : super(key: key);

  @override
  State<FoodBuddyScreen> createState() => _FoodBuddyScreenState();
}

class _FoodBuddyScreenState extends State<FoodBuddyScreen> {
  List<CityListModel> onRating = [
    CityListModel("sabanok..."),
    CityListModel("blue_bouy"),
    CityListModel("waggles"),
    CityListModel("steve.loves"),
    CityListModel("sabanok..."),
    CityListModel("blue_bouy"),
  ];

  List<CityListModel> onPostList = [
    CityListModel("John Doe"),
    CityListModel("John Doe"),
    CityListModel("John Doe"),
  ];

  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];

  List<CityListModel> onDealsModel = [];
  List<CityListModel> selectedList = [];

  @override
  void initState() {
    onDealsModel.clear();
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_burger));
    viewPostApiCall();
    super.initState();
  }

  bool isNew = true;
  int myposition = 1;

  ImagePicker picker = ImagePicker();
  XFile? image;

  String image2 = img_venue_png;

  void selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print(selectedImage?.path);
    setState(() {
      var a = selectedImage?.path;
      image2 = a!;
    });
  }

  void selectImagesCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    print(selectedImage?.path);
    setState(() {
      var a = selectedImage?.path;
      image2 = a!;
    });
  }

  FoodBuddyViewModel foodBuddyViewModel = Get.find();
  ViewPostResModel? viewRes;

  viewPostApiCall() async {
    await foodBuddyViewModel.viewPostViewModel();
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
      backgroundColor: bg_fafbfb,
      body: GetBuilder<FoodBuddyViewModel>(
        builder: (controller) {
          if (controller.viewPostApiResponse.status == Status.LOADING) {
            return const CircularIndicator();
          }
          if (controller.viewPostApiResponse.status == Status.ERROR) {
            return const ServerError();
          }
          if (controller.viewPostApiResponse.status == Status.COMPLETE) {
            viewRes = controller.viewPostApiResponse.data;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 16.h),
                      child: Row(
                        children: [
                          // Payment
                          Expanded(
                            flex: 1,
                            child: Text("Food Buddy",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontOverpassBold,
                                    fontSize: 20.sp),
                                textAlign: TextAlign.left),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SwipeToDeleletList(),
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SvgPicture.asset(icon_notifcation_food_buddy),
                                Container(
                                    width: 9.w,
                                    height: 9.h,
                                    margin: EdgeInsets.only(right: 1.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                      shape: BoxShape.circle,
                                      color: red_dc3642,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreatePost(),
                                    ));
                              },
                              child:
                                  SvgPicture.asset(icon_add_post_food_buddy)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Story Item*/
                      Container(
                        height: 105.h,
                        color: Colors.white,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          separatorBuilder: (BuildContext context, int i) =>
                              SizedBox(
                            width: 12.w,
                          ),
                          itemCount: onRating.length,
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              i == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showGeneralDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            barrierLabel:
                                                MaterialLocalizations.of(
                                                        context)
                                                    .modalBarrierDismissLabel,
                                            barrierColor: Colors.black54,
                                            pageBuilder: (ctx, a1, a2) {
                                              return Container();
                                            },
                                            transitionBuilder:
                                                (ctx, a1, a2, child) {
                                              var curve = Curves.easeInOut
                                                  .transform(a1.value);
                                              return Transform.scale(
                                                scale: curve,
                                                child: Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.r)),
                                                    insetPadding:
                                                        EdgeInsets.all(70),
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    child: Container(
                                                      width: double.infinity,
                                                      // height: 340.h,
                                                      padding: EdgeInsets.only(
                                                          top: 20.h,
                                                          bottom: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Column(
                                                                children: [
                                                                  IconButton(
                                                                    iconSize:
                                                                        50,
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .camera,
                                                                      color:
                                                                          red_dc3642,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      selectImagesCamera();
                                                                    },
                                                                  ),
                                                                  Text('Camera')
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  IconButton(
                                                                    iconSize:
                                                                        50,
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .image,
                                                                      color:
                                                                          blue_007add,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      selectImage();
                                                                    },
                                                                  ),
                                                                  Text(
                                                                      'Gallery'),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            },
                                            transitionDuration: const Duration(
                                                milliseconds: 300),
                                          );
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              SizedBox(
                                                width: 68.w,
                                                height: 68.h,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                    img_men,
                                                    width: 68.w,
                                                    height: 68.h,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SvgPicture.asset(icon_add_circle)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.h,
                                          ),
                                          // Your Story
                                          Text("Your Story",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                      // onTap: () {
                                      //   setState(() {
                                      // MultiAssetsPageSecond();

                                      //   assets = AssetPicker.pickAssets(
                                      //     context,
                                      //     pickerConfig: AssetPickerConfig(
                                      //       maxAssets: 10,
                                      //       selectedAssets: assets,
                                      //       specialItemPosition: SpecialItemPosition.prepend,
                                      //       specialItemBuilder: (
                                      //           BuildContext context,
                                      //           AssetPathEntity? path,
                                      //           int length,
                                      //           ) {
                                      //         if (path?.isAll != true) {
                                      //           return null;
                                      //         }
                                      //         return Semantics(
                                      //           label: 'Header',
                                      //           button: true,
                                      //           onTapHint: "Description",
                                      //           child: GestureDetector(
                                      //             behavior: HitTestBehavior.opaque,
                                      //             onTap: () async {
                                      //               final AssetEntity? result = await _pickFromCamera(context);
                                      //               if (result == null) {
                                      //                 return;
                                      //               }
                                      //               final AssetPicker<AssetEntity, AssetPathEntity> picker =
                                      //               context.findAncestorWidgetOfExactType()!;
                                      //               final DefaultAssetPickerBuilderDelegate builder =
                                      //               picker.builder as DefaultAssetPickerBuilderDelegate;
                                      //               final DefaultAssetPickerProvider p = builder.provider;
                                      //               await p.switchPath(
                                      //                 PathWrapper<AssetPathEntity>(
                                      //                   path:
                                      //                   await p.currentPath!.path.obtainForNewProperties(),
                                      //                 ),
                                      //               );
                                      //               p.selectAsset(result);
                                      //               print("result p "+ picker.toString());
                                      //
                                      //             },
                                      //             child: const Center(
                                      //               child: Icon(Icons.camera_enhance, size: 42.0),
                                      //             ),
                                      //           ),
                                      //         );
                                      //       },
                                      //     ),
                                      //   ) as List<AssetEntity>;
                                      //
                                      //   print("result"+assets.length.toString());
                                      //
                                      // });
                                      //  image = await picker.pickImage(source: ImageSource.gallery);
                                      // },
                                      // child: Column(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      //     SizedBox(
                                      //       height: 3.h,
                                      //     ),
                                      //     Stack(
                                      //       alignment: Alignment.bottomRight,
                                      //       children: [
                                      //         SizedBox(
                                      //           width: 68.w,
                                      //           height: 68.h,
                                      //           child: CircleAvatar(
                                      //             radius: 50,
                                      //             backgroundColor: Colors.transparent,
                                      //             child: Image.asset(
                                      //               img_men,
                                      //               width: 68.w,
                                      //               height: 68.h,
                                      //               fit: BoxFit.fill,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SvgPicture.asset(icon_add_circle)
                                      //       ],
                                      //     ),
                                      //     SizedBox(
                                      //       height: 7.h,
                                      //     ),
                                      //     // Your Story
                                      //     Text("Your Story",
                                      //         style: TextStyle(
                                      //             color: black_504f58,
                                      //             fontFamily: fontMavenProRegular,
                                      //             fontSize: 12.sp),
                                      //         textAlign: TextAlign.center)
                                      //   ],
                                      // ),
                                    )
                                  : Column(
                                      children: [
                                        UnicornOutlineButton(
                                          strokeWidth: 2,
                                          radius: 100,
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xffff8a9e),
                                              Color(0xfff43f5e),
                                            ],
                                          ),
                                          child: SizedBox(
                                            width: 72.w,
                                            height: 72.h,
                                            child: Padding(
                                              padding: EdgeInsets.all(4.r),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.asset(
                                                  img_girl1,
                                                  width: 72.w,
                                                  height: 72.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (i == 2) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddReels(),
                                                  ));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StoryPage(),
                                                  ));
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(onRating[i].title,
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProRegular,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: viewRes!.data!.length,
                            itemBuilder: (context, i) {
                              return
                                  // i == 1
                                  //   ? GestureDetector(
                                  //       onTap: () {
                                  //         Navigator.push(
                                  //             context,
                                  //             MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   OtherUserPostDetail(),
                                  //             ));
                                  //       },
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           // Suggestions for you
                                  //           Text(
                                  //               "Suggestions for you"
                                  //                   .toUpperCase(),
                                  //               style: TextStyle(
                                  //                   color: grey_77879e,
                                  //                   fontFamily:
                                  //                       fontMavenProMedium,
                                  //                   fontSize: 14.sp),
                                  //               textAlign: TextAlign.left),
                                  //           SizedBox(
                                  //             height: 16.h,
                                  //           ),
                                  //           Stack(
                                  //             children: [
                                  //               Container(
                                  //                 margin: EdgeInsets.only(
                                  //                     bottom: 16.h, left: 6.w),
                                  //                 decoration: cardboxDecoration,
                                  //                 child: Column(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment.start,
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment.start,
                                  //                   children: [
                                  //                     Stack(
                                  //                       alignment:
                                  //                           Alignment.bottomRight,
                                  //                       children: [
                                  //                         ClipRRect(
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .only(
                                  //                               topLeft: Radius
                                  //                                   .circular(
                                  //                                       15.r),
                                  //                               topRight: Radius
                                  //                                   .circular(
                                  //                                       10.r),
                                  //                             ),
                                  //                             child: Image.asset(
                                  //                               onDealsModel[i]
                                  //                                   .title,
                                  //                               width: double
                                  //                                   .infinity,
                                  //                               height: 168.h,
                                  //                               fit: BoxFit.fill,
                                  //                             )),
                                  //                         Positioned(
                                  //                             bottom: 110,
                                  //                             child: Padding(
                                  //                               padding:
                                  //                                   const EdgeInsets
                                  //                                           .all(
                                  //                                       12.0),
                                  //                               child:
                                  //                                   GestureDetector(
                                  //                                       onTap:
                                  //                                           () {
                                  //                                         setState(
                                  //                                             () {
                                  //                                           setState(
                                  //                                             () {
                                  //                                               if (selectedList.contains(onDealsModel[i])) {
                                  //                                                 selectedList.remove(onDealsModel[i]);
                                  //                                               } else {
                                  //                                                 selectedList.add(onDealsModel[i]);
                                  //                                               }
                                  //                                             },
                                  //                                           );
                                  //                                         });
                                  //                                       },
                                  //                                       child: SvgPicture.asset(selectedList
                                  //                                               .contains(onDealsModel[i])
                                  //                                           ? icon_red_heart
                                  //                                           : icon_white_heart)),
                                  //                             )),
                                  //                         Align(
                                  //                           alignment: Alignment
                                  //                               .bottomRight,
                                  //                           child:
                                  //                               GestureDetector(
                                  //                             onTap: () {
                                  //                               //  selectRatingBar(context);
                                  //                             },
                                  //                             child: Container(
                                  //                               padding: EdgeInsets
                                  //                                   .symmetric(
                                  //                                       horizontal:
                                  //                                           8.w,
                                  //                                       vertical:
                                  //                                           7.h),
                                  //                               margin: EdgeInsets
                                  //                                   .all(12.r),
                                  //                               decoration:
                                  //                                   homeratingboxDecoration,
                                  //                               child: Row(
                                  //                                 mainAxisSize:
                                  //                                     MainAxisSize
                                  //                                         .min,
                                  //                                 children: [
                                  //                                   // 4.5
                                  //                                   Text("4.5",
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               black_504f58,
                                  //                                           fontFamily:
                                  //                                               fontMavenProMedium,
                                  //                                           fontStyle: FontStyle
                                  //                                               .normal,
                                  //                                           fontSize: 12
                                  //                                               .sp),
                                  //                                       textAlign:
                                  //                                           TextAlign
                                  //                                               .left),
                                  //                                   SizedBox(
                                  //                                     width: 2.w,
                                  //                                   ),
                                  //                                   SvgPicture.asset(
                                  //                                       icon_small_rating_bar),
                                  //                                   SizedBox(
                                  //                                     width: 2.w,
                                  //                                   ),
                                  //                                   Text("(25+)",
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               grey_77879e,
                                  //                                           fontFamily:
                                  //                                               fontMavenProMedium,
                                  //                                           fontStyle: FontStyle
                                  //                                               .normal,
                                  //                                           fontSize: 10
                                  //                                               .sp),
                                  //                                       textAlign:
                                  //                                           TextAlign
                                  //                                               .left)
                                  //                                 ],
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                           EdgeInsets.all(12.r),
                                  //                       child: Column(
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .start,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           // McDonald’s
                                  //                           Row(
                                  //                             mainAxisAlignment:
                                  //                                 MainAxisAlignment
                                  //                                     .spaceBetween,
                                  //                             children: [
                                  //                               Text("McDonald’s",
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           black_504f58,
                                  //                                       fontFamily:
                                  //                                           fontMavenProProSemiBold,
                                  //                                       fontSize: 15
                                  //                                           .sp),
                                  //                                   textAlign:
                                  //                                       TextAlign
                                  //                                           .left),
                                  //                               i == 1
                                  //                                   ? SizedBox()
                                  //                                   : Container(
                                  //                                       decoration: BoxDecoration(
                                  //                                           gradient: const LinearGradient(
                                  //                                             begin:
                                  //                                                 Alignment.centerLeft,
                                  //                                             end:
                                  //                                                 Alignment.centerRight,
                                  //                                             colors: [
                                  //                                               Color(0xffff8a9e),
                                  //                                               Color(0xfff43f5e),
                                  //                                             ],
                                  //                                           ),
                                  //                                           borderRadius: BorderRadius.circular(50)),
                                  //                                       child: // Frame 34548
                                  //                                           Padding(
                                  //                                         padding: EdgeInsets.symmetric(
                                  //                                             horizontal:
                                  //                                                 10.w,
                                  //                                             vertical: 4.h),
                                  //                                         child: Text(
                                  //                                             "New",
                                  //                                             style: TextStyle(
                                  //                                                 color: Colors.white,
                                  //                                                 fontFamily: fontMavenProMedium,
                                  //                                                 fontSize: 12.sp),
                                  //                                             textAlign: TextAlign.left),
                                  //                                       ),
                                  //                                     )
                                  //                             ],
                                  //                           ),
                                  //                           SizedBox(
                                  //                             height: 8.h,
                                  //                           ),
                                  //                           // Sec 16, Dwarka, New Delhi
                                  //                           Row(
                                  //                             mainAxisAlignment:
                                  //                                 MainAxisAlignment
                                  //                                     .start,
                                  //                             crossAxisAlignment:
                                  //                                 CrossAxisAlignment
                                  //                                     .center,
                                  //                             children: [
                                  //                               Text(
                                  //                                   "Sec 16, Dwarka, New Delhi ",
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           grey_5f6d7b,
                                  //                                       fontFamily:
                                  //                                           fontMavenProRegular,
                                  //                                       fontStyle:
                                  //                                           FontStyle
                                  //                                               .normal,
                                  //                                       fontSize: 12
                                  //                                           .sp),
                                  //                                   textAlign:
                                  //                                       TextAlign
                                  //                                           .left),
                                  //                               Container(
                                  //                                 width: 3.w,
                                  //                                 height: 3.w,
                                  //                                 decoration: const BoxDecoration(
                                  //                                     shape: BoxShape
                                  //                                         .circle,
                                  //                                     color:
                                  //                                         grey_5f6d7b),
                                  //                               ),
                                  //                               SizedBox(
                                  //                                 width: 4.w,
                                  //                               ),
                                  //                               Text("2.5km",
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           grey_5f6d7b,
                                  //                                       fontFamily:
                                  //                                           fontMavenProRegular,
                                  //                                       fontStyle:
                                  //                                           FontStyle
                                  //                                               .normal,
                                  //                                       fontSize: 12
                                  //                                           .sp),
                                  //                                   textAlign:
                                  //                                       TextAlign
                                  //                                           .left),
                                  //                             ],
                                  //                           ),
                                  //
                                  //                           SizedBox(
                                  //                             height: 12.h,
                                  //                           ),
                                  //
                                  //                           Row(
                                  //                             children: [
                                  //                               Image.asset(
                                  //                                 icon_takeaway_png,
                                  //                                 width: 14.w,
                                  //                                 height: 14.h,
                                  //                               ),
                                  //                               SizedBox(
                                  //                                 width: 4.w,
                                  //                               ),
                                  //                               // Takeaway
                                  //                               Text("Takeaway",
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           grey_5f6d7b,
                                  //                                       fontFamily:
                                  //                                           fontMavenProRegular,
                                  //                                       fontSize: 12
                                  //                                           .sp),
                                  //                                   textAlign:
                                  //                                       TextAlign
                                  //                                           .left),
                                  //
                                  //                               SizedBox(
                                  //                                 width: 12.w,
                                  //                               ),
                                  //
                                  //                               Image.asset(
                                  //                                 icon_dinein_png,
                                  //                                 width: 14.w,
                                  //                                 height: 14.h,
                                  //                               ),
                                  //                               SizedBox(
                                  //                                 width: 4.w,
                                  //                               ),
                                  //                               // Takeaway
                                  //                               Text("Dine-in",
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           grey_5f6d7b,
                                  //                                       fontFamily:
                                  //                                           fontMavenProRegular,
                                  //                                       fontSize: 12
                                  //                                           .sp),
                                  //                                   textAlign:
                                  //                                       TextAlign
                                  //                                           .left),
                                  //                             ],
                                  //                           ),
                                  //
                                  //                           SizedBox(
                                  //                             height: 8.h,
                                  //                           ),
                                  //
                                  //                           SizedBox(
                                  //                             height: 22.h,
                                  //                             child: ListView
                                  //                                 .builder(
                                  //                               scrollDirection:
                                  //                                   Axis.horizontal,
                                  //                               primary: false,
                                  //                               shrinkWrap: true,
                                  //                               itemCount:
                                  //                                   cityList
                                  //                                       .length,
                                  //                               itemBuilder:
                                  //                                   (context,
                                  //                                           i) =>
                                  //                                       Container(
                                  //                                 margin: EdgeInsets
                                  //                                     .only(
                                  //                                         right: 8
                                  //                                             .w),
                                  //                                 decoration: BoxDecoration(
                                  //                                     borderRadius:
                                  //                                         BorderRadius.circular(5
                                  //                                             .r),
                                  //                                     color: Color(
                                  //                                         0xfff6f6f6)),
                                  //                                 child: // Chicken
                                  //                                     Padding(
                                  //                                   padding: EdgeInsets.symmetric(
                                  //                                       horizontal:
                                  //                                           6.w,
                                  //                                       vertical:
                                  //                                           4.h),
                                  //                                   child: Text(
                                  //                                       cityList[
                                  //                                               i]
                                  //                                           .title,
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               grey_77879e,
                                  //                                           fontFamily:
                                  //                                               fontMavenProRegular,
                                  //                                           fontSize: 12
                                  //                                               .sp),
                                  //                                       textAlign:
                                  //                                           TextAlign
                                  //                                               .center),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           )
                                  //                         ],
                                  //                       ),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               i == 1
                                  //                   ? Column(
                                  //                       mainAxisAlignment:
                                  //                           MainAxisAlignment
                                  //                               .start,
                                  //                       crossAxisAlignment:
                                  //                           CrossAxisAlignment
                                  //                               .start,
                                  //                       children: [
                                  //                         SizedBox(
                                  //                           height: 7.h,
                                  //                         ),
                                  //                         Stack(
                                  //                           alignment:
                                  //                               Alignment.center,
                                  //                           children: [
                                  //                             Align(
                                  //                                 alignment:
                                  //                                     Alignment
                                  //                                         .topLeft,
                                  //                                 child:
                                  //                                     Image.asset(
                                  //                                   icon_blue_strip,
                                  //                                   width: 210.w,
                                  //                                   fit: BoxFit
                                  //                                       .fill,
                                  //                                 )),
                                  //                             Row(
                                  //                               mainAxisAlignment:
                                  //                                   MainAxisAlignment
                                  //                                       .start,
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .center,
                                  //                               mainAxisSize:
                                  //                                   MainAxisSize
                                  //                                       .max,
                                  //                               children: [
                                  //                                 SizedBox(
                                  //                                   width: 13.w,
                                  //                                 ),
                                  //                                 SvgPicture.asset(
                                  //                                     icon_flash_offer),
                                  //                                 SizedBox(
                                  //                                   width: 4.w,
                                  //                                 ),
                                  //                                 Column(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .center,
                                  //                                   crossAxisAlignment:
                                  //                                       CrossAxisAlignment
                                  //                                           .start,
                                  //                                   children: [
                                  //                                     // 60% OFF- Takeaway
                                  //                                     Text(
                                  //                                         "60% OFF- Takeaway",
                                  //                                         style: TextStyle(
                                  //                                             color: Colors
                                  //                                                 .white,
                                  //                                             fontFamily:
                                  //                                                 fontMavenProMedium,
                                  //                                             fontStyle: FontStyle
                                  //                                                 .normal,
                                  //                                             fontSize: 12
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left),
                                  //
                                  //                                     // Pick UP Between 5:30 - 7:00pm
                                  //                                     Text(
                                  //                                         "Pick Up Between 9:30 - 7:00pm",
                                  //                                         style: TextStyle(
                                  //                                             color: Color(
                                  //                                                 0xc9ffffff),
                                  //                                             fontFamily:
                                  //                                                 fontMavenProRegular,
                                  //                                             fontSize: 10
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left)
                                  //                                   ],
                                  //                                 )
                                  //                               ],
                                  //                             )
                                  //                           ],
                                  //                         ),
                                  //                         SizedBox(
                                  //                           height: 5.h,
                                  //                         ),
                                  //                         Stack(
                                  //                           alignment:
                                  //                               Alignment.center,
                                  //                           children: [
                                  //                             Align(
                                  //                                 alignment:
                                  //                                     Alignment
                                  //                                         .topLeft,
                                  //                                 child:
                                  //                                     Image.asset(
                                  //                                   icon_blue_strip,
                                  //                                   width: 210.w,
                                  //                                   fit: BoxFit
                                  //                                       .fill,
                                  //                                 )),
                                  //                             Row(
                                  //                               mainAxisAlignment:
                                  //                                   MainAxisAlignment
                                  //                                       .start,
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .center,
                                  //                               mainAxisSize:
                                  //                                   MainAxisSize
                                  //                                       .max,
                                  //                               children: [
                                  //                                 SizedBox(
                                  //                                   width: 13.w,
                                  //                                 ),
                                  //                                 SvgPicture.asset(
                                  //                                     icon_flash_offer),
                                  //                                 SizedBox(
                                  //                                   width: 4.w,
                                  //                                 ),
                                  //                                 Column(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .center,
                                  //                                   crossAxisAlignment:
                                  //                                       CrossAxisAlignment
                                  //                                           .start,
                                  //                                   children: [
                                  //                                     // 60% OFF- Takeaway
                                  //                                     Text(
                                  //                                         "40% OFF- Dine In",
                                  //                                         style: TextStyle(
                                  //                                             color: Colors
                                  //                                                 .white,
                                  //                                             fontFamily:
                                  //                                                 fontMavenProMedium,
                                  //                                             fontStyle: FontStyle
                                  //                                                 .normal,
                                  //                                             fontSize: 12
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left),
                                  //
                                  //                                     // Pick UP Between 5:30 - 7:00pm
                                  //                                     Text(
                                  //                                         "Arrive Between 12:30 - 7:00pm",
                                  //                                         style: TextStyle(
                                  //                                             color: Color(
                                  //                                                 0xc9ffffff),
                                  //                                             fontFamily:
                                  //                                                 fontMavenProRegular,
                                  //                                             fontSize: 10
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left)
                                  //                                   ],
                                  //                                 )
                                  //                               ],
                                  //                             )
                                  //                           ],
                                  //                         ),
                                  //                         SizedBox(
                                  //                           height: 5.h,
                                  //                         ),
                                  //                         Stack(
                                  //                           alignment:
                                  //                               Alignment.center,
                                  //                           children: [
                                  //                             Align(
                                  //                                 alignment:
                                  //                                     Alignment
                                  //                                         .topLeft,
                                  //                                 child:
                                  //                                     Image.asset(
                                  //                                   icon_blue_strip,
                                  //                                   width: 210.w,
                                  //                                   fit: BoxFit
                                  //                                       .fill,
                                  //                                 )),
                                  //                             Row(
                                  //                               mainAxisAlignment:
                                  //                                   MainAxisAlignment
                                  //                                       .start,
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .center,
                                  //                               mainAxisSize:
                                  //                                   MainAxisSize
                                  //                                       .max,
                                  //                               children: [
                                  //                                 SizedBox(
                                  //                                   width: 13.w,
                                  //                                 ),
                                  //                                 SvgPicture.asset(
                                  //                                     icon_offer_white),
                                  //                                 SizedBox(
                                  //                                   width: 4.w,
                                  //                                 ),
                                  //                                 Column(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .center,
                                  //                                   crossAxisAlignment:
                                  //                                       CrossAxisAlignment
                                  //                                           .start,
                                  //                                   children: [
                                  //                                     // 60% OFF- Takeaway
                                  //                                     Text(
                                  //                                         "25% OFF- Takeaway",
                                  //                                         style: TextStyle(
                                  //                                             color: Colors
                                  //                                                 .white,
                                  //                                             fontFamily:
                                  //                                                 fontMavenProMedium,
                                  //                                             fontStyle: FontStyle
                                  //                                                 .normal,
                                  //                                             fontSize: 12
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left),
                                  //
                                  //                                     // Pick UP Between 5:30 - 7:00pm
                                  //                                     Text(
                                  //                                         "Anytime Today",
                                  //                                         style: TextStyle(
                                  //                                             color: Color(
                                  //                                                 0xc9ffffff),
                                  //                                             fontFamily:
                                  //                                                 fontMavenProRegular,
                                  //                                             fontSize: 10
                                  //                                                 .sp),
                                  //                                         textAlign:
                                  //                                             TextAlign.left)
                                  //                                   ],
                                  //                                 )
                                  //                               ],
                                  //                             )
                                  //                           ],
                                  //                         ),
                                  //                       ],
                                  //                     )
                                  //                   : SizedBox()
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     )
                                  //   :
                                  GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostDetailScreen(
                                            postId: viewRes!.data![i].postId!),
                                      ));
                                },
                                child: Container(
                                  decoration: cardboxDecoration,
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 37.w,
                                              height: 37.h,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child:
                                                    viewRes!.data![i].userImg ==
                                                            ""
                                                        ? Image.asset(
                                                            bluedip_app_icon,
                                                            width: 37.w,
                                                            height: 37.h,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(viewRes!
                                                            .data![i].userImg!),
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
                                                      viewRes!.data![i]
                                                              .postTitle ??
                                                          "",
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProBold,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                      "${viewRes!.data![i].cityName}, ${viewRes!.data![i].date}",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 12.sp),
                                                      textAlign: TextAlign.left)
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatBox(),
                                                    ));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 7.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xff276fe9),
                                                        Color(0xff568aef),
                                                      ],
                                                    )),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      icon_notifcation_food_buddy,
                                                      color: white_ffffff,
                                                      width: 16.w,
                                                      height: 16.h,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    // Chat
                                                    Text("Chat",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          viewRes!.data![i].postImg == ""
                                              ? Image.asset(
                                                  bluedip_app_icon,
                                                  width: double.infinity,
                                                  height: 168.h,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  viewRes!.data![i].postImg!,
                                                  width: double.infinity,
                                                  height: 168.h,
                                                  fit: BoxFit.fill),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectContact(),
                                                  ));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(12.r),
                                              child: SvgPicture.asset(
                                                  icon_share_post),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w,
                                            right: 12.w,
                                            top: 12.h,
                                            bottom: 16.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Let’s eat hungers
                                            Text(
                                                viewRes!.data![i].postTitle ??
                                                    "",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProBold,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            // Username Lorem ipsum dolor sit ametconsectetur adipiscing elit, sed do eiusmod tempor...more
                                            ReadMoreText(
                                              viewRes!.data![i].description ??
                                                  "",
                                              trimLines: 2,
                                              colorClickableText: black_504f58,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'more',
                                              trimExpandedText: 'less',
                                              lessStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  color: blue_007add),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  color: grey_5f6d7b,
                                                  height: 1.5),
                                              moreStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  color: blue_007add),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));
  }

  // @override
  // int get maxAssetsCount => 10;
  //
  // @override
  // // TODO: implement pickMethods
  // List<PickMethod> get pickMethods => throw UnimplementedError();
  //
  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();

  // Widget check(){
  //   return PickMethod(
  //       method: (BuildContext context, List<AssetEntity> assets) {
  //         const AssetPickerTextDelegate textDelegate = AssetPickerTextDelegate();
  //         return AssetPicker.pickAssets(
  //           context,
  //           pickerConfig: AssetPickerConfig(
  //             maxAssets: maxAssetsCount,
  //             selectedAssets: assets,
  //             specialItemPosition: SpecialItemPosition.prepend,
  //             specialItemBuilder: (
  //                 BuildContext context,
  //                 AssetPathEntity? path,
  //                 int length,
  //                 ) {
  //               if (path?.isAll != true) {
  //                 return null;
  //               }
  //               return Semantics(
  //                 label: textDelegate.sActionUseCameraHint,
  //                 button: true,
  //                 onTapHint: textDelegate.sActionUseCameraHint,
  //                 child: GestureDetector(
  //                   behavior: HitTestBehavior.opaque,
  //                   onTap: () async {
  //                     final AssetEntity? result = await _pickFromCamera(context);
  //                     if (result == null) {
  //                       return;
  //                     }
  //                     final AssetPicker<AssetEntity, AssetPathEntity> picker =
  //                     context.findAncestorWidgetOfExactType()!;
  //                     final DefaultAssetPickerBuilderDelegate builder =
  //                     picker.builder as DefaultAssetPickerBuilderDelegate;
  //                     final DefaultAssetPickerProvider p = builder.provider;
  //                     await p.switchPath(
  //                       PathWrapper<AssetPathEntity>(
  //                         path:
  //                         await p.currentPath!.path.obtainForNewProperties(),
  //                       ),
  //                     );
  //                     p.selectAsset(result);
  //                   },
  //                   child: const Center(
  //                     child: Icon(Icons.camera_enhance, size: 42.0),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         );
  //       },
  //       onLongPress: (){
  //         List<AssetEntity> assets = [];
  //         AssetPicker.pickAssets(
  //           context,
  //           pickerConfig: AssetPickerConfig(
  //             maxAssets: maxAssetsCount,
  //             selectedAssets: assets,
  //             specialItemPosition: SpecialItemPosition.prepend,
  //             specialItemBuilder: (
  //                 BuildContext context,
  //                 AssetPathEntity? path,
  //                 int length,
  //                 ) {
  //               if (path?.isAll != true) {
  //                 return null;
  //               }
  //               return Semantics(
  //                 label: 'Header',
  //                 button: true,
  //                 onTapHint: "Description",
  //                 child: GestureDetector(
  //                   behavior: HitTestBehavior.opaque,
  //                   onTap: () async {
  //                     final AssetEntity? result = await _pickFromCamera(context);
  //                     if (result == null) {
  //                       return;
  //                     }
  //                     final AssetPicker<AssetEntity, AssetPathEntity> picker =
  //                     context.findAncestorWidgetOfExactType()!;
  //                     final DefaultAssetPickerBuilderDelegate builder =
  //                     picker.builder as DefaultAssetPickerBuilderDelegate;
  //                     final DefaultAssetPickerProvider p = builder.provider;
  //                     await p.switchPath(
  //                       PathWrapper<AssetPathEntity>(
  //                         path:
  //                         await p.currentPath!.path.obtainForNewProperties(),
  //                       ),
  //                     );
  //                     p.selectAsset(result);
  //                   },
  //                   child: const Center(
  //                     child: Icon(Icons.camera_enhance, size: 42.0),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         );
  //       }
  //   )
  // }
}
