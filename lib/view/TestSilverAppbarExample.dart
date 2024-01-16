import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Model/CityListModel.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';
import '../Widget/common_border_button.dart';
import '../Widget/search_bar.dart';

import 'bottomsheets/BottomSheetDelete.dart';
import 'chat/ChatBox.dart';
import '../Widget/common_red_button.dart';

class TestSilverAppbarExample extends StatefulWidget {
  const TestSilverAppbarExample({Key? key}) : super(key: key);

  @override
  State<TestSilverAppbarExample> createState() =>
      _TestSilverAppbarExampleState();
}

class _TestSilverAppbarExampleState extends State<TestSilverAppbarExample> {
  String selectedDay = "";
  List<CityListModel> selectedChatList = [];

  List<CityListModel> allChatList = [
    CityListModel("Jenny doe"),
    CityListModel("Roy"),
    CityListModel("Erika"),
    CityListModel("Julli"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        allChatList.removeWhere(
                            (element) => selectedChatList.contains(element));
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBarWidget(
                      hintText: strSearch,
                      onSubmitted: (String) {},
                      onChanged: (String) {},
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: allChatList.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                            background: stackBehindDismiss(),
                            direction: DismissDirection.endToStart,
                            secondaryBackground: secondarystackBehindDismiss(),
                            key: ObjectKey(allChatList[i]),
                            child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  if (selectedChatList
                                      .contains(allChatList[i])) {
                                    selectedChatList.remove(allChatList[i]);
                                  } else {
                                    selectedChatList.add(allChatList[i]);
                                  }
                                });
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatBox(),
                                    ));
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
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
                                                  textAlign: TextAlign.left),

                                              // Hello. how are you?
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Yesterday
                                            Text("Yesterday",
                                                style: TextStyle(
                                                    color: grey_77879e,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.right),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            i == 0
                                                ? Container(
                                                    width: 20.w,
                                                    height: 20.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: blue_007add),
                                                    child: // 1
                                                        Center(
                                                      child: Text("1",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.center),
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
                                      height: 15.h,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: divider_d4dce7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                print("Add to favorite");
                                deleteItem(i);
                                //add "add to favorite" function
                              } else {
                                print('Remove item');
                                deleteItem(i);
                              }
                            },
                            confirmDismiss: (DismissDirection direction) async {
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
                                                topLeft: Radius.circular(13.r),
                                                topRight: Radius.circular(13.r),
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
                                                    BorderRadius.circular(13)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(16.r),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      // Daily Opportunities
                                                      Center(
                                                        child: Text(
                                                            "Delete Bluedip User",
                                                            style: TextStyle(
                                                                color:
                                                                    black_504f58,
                                                                fontFamily:
                                                                    fontOverpassBold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 18.sp,
                                                                height: 1.5),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      // Are you sure you would like to delete your Bluedip account?
                                                      Center(
                                                        child: Text(
                                                            "Are you sure you would like to delete \nyour Bluedip user?",
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
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      SizedBox(
                                                        height: 36.h,
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
                                                                    .pop(false);
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
                                                                deleteItem(i);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
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
                                                        height: 25.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                            }
                            // confirmDismiss: (DismissDirection direction) async {
                            //   return await showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         title: const Text("Confirm"),
                            //         content: direction == DismissDirection.startToEnd
                            //             ? Text(
                            //             "Are you sure you wish add to favorite this item?")
                            //             : Text(
                            //             "Are you sure you wish to delete this item?"),
                            //         actions: <Widget>[
                            //           ElevatedButton(
                            //             onPressed: () => Navigator.of(context).pop(true),
                            //             child: direction == DismissDirection.startToEnd
                            //                 ? Text("FAVORITE")
                            //                 : Text("DELETE"),
                            //           ),
                            //           ElevatedButton(
                            //             onPressed: () => Navigator.of(context).pop(false),
                            //             child: const Text("CANCEL"),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   );
                            // }
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
                  children: [BottomSheetDelete()],
                ),
              ),
            ));
      });
}
