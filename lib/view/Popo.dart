import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Widget/back_button_square.dart';

class Popo extends StatefulWidget {
  const Popo({Key? key}) : super(key: key);

  @override
  State<Popo> createState() => _PopoState();
}

class _PopoState extends State<Popo> with TickerProviderStateMixin{
  TabController? tabController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(() {
      activeIndex = tabController!.index;
    });

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
        });
      });
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  late ScrollController _scrollController;
  Color _textColor = Colors.white;
  static const kExpandedHeight = 350.0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   _scrollController = ScrollController()
  //     ..addListener(() {
  //       setState(() {
  //         _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
  //       });
  //     });
  // }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // show and hide SliverAppBar Title
              backgroundColor: Colors.white,
              leading: Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 3.w,bottom: 10.h,top: 10),
                child: back_button_square(),
              ),
              title: _isSliverAppBarExpanded
                  ? Text(
                  "Pizza Hut",
                  style: TextStyle(
                      color: black_504f58,
                      fontFamily: fontOverpassBold,
                      fontSize: 18.sp,
                      letterSpacing: 0.18
                  ),
                  textAlign: TextAlign.left
              )
                  : null,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: kExpandedHeight,
              // show and hide FlexibleSpaceBar title
              flexibleSpace: _isSliverAppBarExpanded
                  ? null
                  : FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(bottom: 105, left: 16),
                collapseMode: CollapseMode.pin,
                title: Text(
                    "Pizza Hut",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontOverpassBold,
                        fontSize: 12.sp,
                        letterSpacing: 0.18
                    ),
                    textAlign: TextAlign.left
                ),
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(img_pizza_hut, width: double.infinity,
                          height: 250.h,
                          fit: BoxFit.fill,),
                        Padding(
                          padding: EdgeInsets.only(top: 48.h,
                              left: 24.w,
                              right: 20.w),
                          child: SvgPicture.asset(icon_red_heart),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // McDonald’s
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //     "Pizza Hut",
                                    //     style:  TextStyle(
                                    //         color:  black_504f58,
                                    //         fontFamily: fontOverpassBold,
                                    //         fontSize: 18.sp,
                                    //         letterSpacing: 0.18
                                    //     ),
                                    //     textAlign: TextAlign.left
                                    // ),
                                    SizedBox(height: 24.h,),
                                    // Sec 16, Dwarka, New Delhi
                                    Text(
                                        "Sec 16, Dwarka, New Delhi - 2.5km",
                                        style: TextStyle(
                                            color: grey_5f6d7b,
                                            fontFamily: fontMavenProRegular,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp
                                        ),
                                        textAlign: TextAlign.left
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // 4.5
                                      Text(
                                          "4.5",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp
                                          ),
                                          textAlign: TextAlign.left
                                      ),
                                      SizedBox(width: 2.w,),
                                      SvgPicture.asset(
                                        icon_small_rating_bar, width: 14.w,
                                        height: 14.h,)
                                    ],
                                  ),
                                  SizedBox(height: 3.h,),
                                  Text(
                                      "(25+)",
                                      style: TextStyle(
                                          color: grey_77879e,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 12.sp
                                      ),
                                      textAlign: TextAlign.left
                                  )
                                ],
                              )

                            ],
                          ),

                          SizedBox(height: 12.h,),

                          Row(
                            children: [
                              Image.asset(
                                icon_takeaway_png, width: 14.w, height: 14.h,),
                              SizedBox(width: 4.w,),
                              // Takeaway
                              Text(
                                  "Takeaway",
                                  style: TextStyle(
                                      color: grey_5f6d7b,
                                      fontFamily: fontMavenProRegular,
                                      fontSize: 12.sp
                                  ),
                                  textAlign: TextAlign.left
                              ),

                              SizedBox(width: 12.w,),

                              Image.asset(
                                icon_dinein_png, width: 14.w, height: 14.h,),
                              SizedBox(width: 4.w,),
                              // Takeaway
                              Text(
                                  "Dine-in",
                                  style: TextStyle(
                                      color: grey_5f6d7b,
                                      fontFamily: fontMavenProRegular,
                                      fontSize: 12.sp
                                  ),
                                  textAlign: TextAlign.left
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h,),

                          // SizedBox(
                          //   height: 20.h,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     primary: false,
                          //     shrinkWrap: true,
                          //     itemCount: cityList.length,
                          //     itemBuilder: (context, i) => Container(
                          //       margin: EdgeInsets.only(right: 8.w),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5.r),
                          //           color: Color(0xfff6f6f6)
                          //       ),
                          //       child: // Chicken
                          //       Padding(
                          //         padding:  EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
                          //         child: Text(
                          //             cityList[i].title,
                          //             style:  TextStyle(
                          //                 color:  grey_77879e,
                          //                 fontFamily: fontMavenProRegular,
                          //                 fontSize: 12.sp
                          //             ),
                          //             textAlign: TextAlign.center
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //
                          // SizedBox(height: 12.h,),

                          Row(
                            children: [
                              // Now Open
                              Text(
                                  "Now Open",
                                  style: TextStyle(
                                      color: green_5cb85c,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 12.sp
                                  ),
                                  textAlign: TextAlign.left
                              ),

                              SizedBox(width: 8.w,),

                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    //  selectHours(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                          "Close 10:00 PM",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 12.sp
                                          ),
                                          textAlign: TextAlign.left
                                      ),
                                      SizedBox(width: 2.w,),
                                      SvgPicture.asset(
                                        icon_down_arrow, width: 5.w,
                                        height: 5.h,)
                                    ],
                                  ),
                                ),
                              ),

                              Image.asset(
                                icon_rupee_slim, width: 9.w, height: 9.h,),
                              // 500 for 2
                              Text(
                                  "500 for 2",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 12.sp
                                  ),
                                  textAlign: TextAlign.left
                              )
                            ],
                          ),


                        ],
                      ),
                    ),

                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: divider_d4dce7,
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.blue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(
                      Icons.dashboard
                  ),
                  Icon(
                      Icons.tv
                  ),
                  Icon(
                      Icons.person
                  ),
                ],
              ),
            ),
            SliverAnimatedList(
              itemBuilder: (_, index, ___){
                return ListTile(
                  title: Text(index.toString()),
                );
              },
              initialItemCount: 100,
            )
          ],
        ),
      ),
    );
  }
}
