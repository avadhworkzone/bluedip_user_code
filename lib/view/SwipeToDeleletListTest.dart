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

import '../Model/HoursModel.dart';
import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button.dart';
import '../Widget/search_bar.dart';
import '../Widget/toolbar_with_search.dart';
import '../Widget/toolbar_with_title.dart';
import 'bottomsheets/BottomSheetBestDeal.dart';
import 'RedeemOfferDetailPage.dart';
import '../Widget/common_red_button.dart';
import '../Widget/common_verify_red_button.dart';

class SwipeToDeleletListTest extends StatefulWidget {
  const SwipeToDeleletListTest({Key? key}) : super(key: key);

  @override
  State<SwipeToDeleletListTest> createState() => _SwipeToDeleletListState();
}

class _SwipeToDeleletListState extends State<SwipeToDeleletListTest> {
  String selectedDay = "";
  List<String> selectedListCategory = [];
  int mySelectConsultation = -1;
  List<CityListModel> onRating = [
    CityListModel("Jenny doe"),
    CityListModel("Roy"),
    CityListModel("Erika"),
    CityListModel("Julli"),
  ];

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
            ToolbarWithTitleShadow("Chat"),
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
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: onRating.length,
                        itemBuilder: (context, i) => Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {
                              setState(() {
                                onRating.removeAt(i);
                              });
                            }),

                            // All actions are defined in the children parameter.
                            children: const [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            // onLongPress: (){
                            //   setState(() {
                            //     if (selectedListCategory.contains(onRating[i].title)) {
                            //       selectedListCategory.remove(
                            //           onRating[i]
                            //               .title);
                            //     }
                            //     else {
                            //       selectedListCategory.add(
                            //           onRating[i]
                            //               .title);
                            //     }
                            //   });
                            // },
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            Text(onRating[i].title,
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
                                                            color: Colors.white,
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
                                      // SizedBox(width: 14.w,),
                                      // selectedListCategory.contains(onRating[i].title)?  SvgPicture.asset(icon_checkbox_circle):SizedBox()
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
                        ),
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

void doNothing(BuildContext context) {}
