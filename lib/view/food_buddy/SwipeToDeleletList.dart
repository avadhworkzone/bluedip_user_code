import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/chat/ChatBox.dart';
import 'package:bluedip_user/Widget/toolbar_with_title_shadow.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Model/CityListModelSecond.dart';
import '../../Model/HoursModel.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_search.dart';
import '../../Widget/toolbar_with_title.dart';
import '../bottomsheets/BottomSheetBestDeal.dart';
import '../bottomsheets/BottomSheetDelete.dart';
import '../RedeemOfferDetailPage.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';

class SwipeToDeleletList extends StatefulWidget {
  const SwipeToDeleletList({Key? key}) : super(key: key);

  @override
  State<SwipeToDeleletList> createState() => _SwipeToDeleletListState();
}

class _SwipeToDeleletListState extends State<SwipeToDeleletList> {
  String selectedDay = "";
  List<CityListModel> selectedChatList = [];

  List<CityListModel> allChatList = [
    CityListModel("Jenny doe"),
    CityListModel("Roy"),
    CityListModel("Erika"),
    CityListModel("Julli"),
  ];

  bool isDayLayout = true;

  bool isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: white_ffffff,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1017191a),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5),
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context, false),
                        child: Container(
                            width: 40.w,
                            height: 40.w,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(icon_arrow_left),
                            ))),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        selectedChatList.isNotEmpty
                            ? selectedChatList.length.toString()
                            : 'Chat',
                        style: TextStyle(
                            fontFamily: fontOverpassBold,
                            color: black_504f58,
                            fontSize: 20.sp),
                      ),
                    ),
                    if (selectedChatList.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            allChatList.removeWhere((element) =>
                                selectedChatList.contains(element));
                            selectedChatList.clear();
                          });
                        },
                        child: SvgPicture.asset(
                          icon_delete_black,
                          color: grey_504f58,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    SizedBox(
                      width: 15.w,
                    )
                  ],
                ),
              ),
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
                        SearchBarWidget(
                          hintText: strSearch,
                          onSubmitted: (String) {},
                          onChanged: (String) {},
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: allChatList.length,
                          itemBuilder: (context, i) {
                            return Dismissible(
                                background: stackBehindDismiss(),
                                direction: DismissDirection.endToStart,
                                secondaryBackground:
                                    secondarystackBehindDismiss(),
                                key: ObjectKey(allChatList[i]),
                                child: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      isLongPressed = true;
                                      selectOnLongPressed(allChatList, i);
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      if (isLongPressed == true) {
                                        selectOnLongPressed(allChatList, i);
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatBox(),
                                            ));
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 51.w,
                                              height: 51.h,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.asset(
                                                  img_girl,
                                                  width: 51.w,
                                                  height: 51.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Jenny doe
                                                  Text(allChatList[i].title,
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProProSemiBold,
                                                          fontSize: 15.sp),
                                                      textAlign:
                                                          TextAlign.left),

                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text("Hello. how are you?",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 14.sp),
                                                      textAlign: TextAlign.left)
                                                ],
                                              ),
                                            ),
                                            selectedChatList
                                                    .contains(allChatList[i])
                                                ? SizedBox()
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      // Yesterday
                                                      Text("Yesterday",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.right),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      i == 0
                                                          ? Container(
                                                              width: 20.w,
                                                              height: 20.h,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      blue_007add),
                                                              child: // 1
                                                                  Center(
                                                                child: Text("1",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            fontMavenProMedium,
                                                                        fontSize: 14
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            selectedChatList
                                                    .contains(allChatList[i])
                                                ? SvgPicture.asset(
                                                    icon_checkbox_circle)
                                                : SizedBox()
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        const Divider(
                                          thickness: 0.5,
                                          height: 0.5,
                                          color: divider_d4dce7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    print("Add to favorite");
                                    deleteItem(i);
                                    //add "add to favorite" function
                                  } else {
                                    print('Remove item');
                                    deleteItem(i);
                                  }
                                },
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (
                                        BuildContext context,
                                      ) {
                                        return Container(
                                            margin: EdgeInsets.all(20.r),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(13.r),
                                                    topRight:
                                                        Radius.circular(13.r),
                                                    bottomRight:
                                                        Radius.circular(13.r),
                                                    bottomLeft:
                                                        Radius.circular(13.r))),
                                            child: SingleChildScrollView(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13)),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(16.r),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          // Daily Opportunities
                                                          Center(
                                                            child: Text(
                                                                "Delete Chat",
                                                                style: TextStyle(
                                                                    color:
                                                                        black_504f58,
                                                                    fontFamily:
                                                                        fontOverpassBold,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        18.sp,
                                                                    height:
                                                                        1.5),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          SizedBox(
                                                            height: 6.h,
                                                          ),
                                                          // Are you sure you would like to delete your Bluedip account?
                                                          Center(
                                                            child: Text(
                                                                "Are you sure you want to delete chat?",
                                                                style: TextStyle(
                                                                    color:
                                                                        black_504f58,
                                                                    fontFamily:
                                                                        fontMavenProMedium,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        14.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          SizedBox(
                                                            height: 30.h,
                                                          ),
                                                          /*bottom two buttons here*/
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: CommonRedButton(
                                                                      strCancel
                                                                          .toUpperCase(),
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  }, red_dc3642)),
                                                              SizedBox(
                                                                width: 16.w,
                                                              ),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: CommonBorderButton(
                                                                      direction ==
                                                                              DismissDirection
                                                                                  .startToEnd
                                                                          ? "Delete"
                                                                          : "Delete"
                                                                              .toUpperCase(),
                                                                      () {
                                                                    deleteItem(
                                                                        i);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                    print("result" +
                                                                        selectedChatList
                                                                            .length
                                                                            .toString());
                                                                  },
                                                                      red_dc3642,
                                                                      Colors
                                                                          .transparent,
                                                                      red_dc3642)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 14.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      });
                                });
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
      ),
    );
  }

  void deleteItem(index) {
    print("onRating initial length" + allChatList.length.toString());
    setState(() {
      allChatList.removeAt(index);
    });
    print("onRating result Length" + allChatList.length.toString());
  }

  void undoDeletion(index, item) {
    setState(() {
      allChatList.insert(index, item);
    });
  }

  Widget secondarystackBehindDismiss() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon_delete_red,
              color: Colors.white,
            ),
            SizedBox(
              width: 20.w,
            )
          ],
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.white),
            Text('Move to favorites', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void selectOnLongPressed(List<CityListModel> allChatList, int i) {
    if (selectedChatList.contains(allChatList[i])) {
      selectedChatList.remove(allChatList[i]);
    } else {
      selectedChatList.add(allChatList[i]);
    }
    if (selectedChatList.isEmpty) {
      setState(() {
        isLongPressed = false;
      });
    }
  }
}

void selectDelete(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            margin: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                    bottomRight: Radius.circular(13.r),
                    bottomLeft: Radius.circular(13.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: const [BottomSheetDelete()],
                ),
              ),
            ));
      });
}
