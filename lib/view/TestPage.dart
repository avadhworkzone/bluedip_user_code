import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

import '../Model/CityListModel.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button_square.dart';
import '../Widget/common.dart';
import '../Widget/red_box_shadow.dart';
import 'auth/OtpVerificationScreen.dart';
import 'home/resto_details/RestoDetailOfferTab.dart';
import 'home/resto_details/RestoDetailReviewTab.dart';
import 'dart:math' as math;

import 'auth/WelcomePageFirst.dart';

import 'package:image_picker/image_picker.dart';

import 'auth/WelcomePageFourth.dart';
import 'auth/WelcomePageSecond.dart';
import 'auth/WelcomePageThird.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;

  // this list holds all the pages
  // all of them are constructed in the very end of this file for readability
  final List<Widget> _pages = [
    const WelcomePageFirst(),
    const WelcomePageSecond(),
    const WelcomePageThird(),
    const WelcomePageFourth(),
  ];
  bool _selectedFirst = true;
  final _mobileNumController = TextEditingController();

  late Timer _timer;
  bool isLongPressed = false;

  void _startOperation() {
    _timer = Timer(const Duration(milliseconds: 200), () {
      print('LongPress Event');
      isLongPressed = true;
    });
  }

  String selectedDay = "";
  int mySelectConsultation = -1;

  List<String> selectedListCategory = [];

  List<CityListModel> onCategory = [
    CityListModel("All"),
    CityListModel("Breakfast"),
    CityListModel("Lunch"),
    CityListModel("Dinner"),
  ];

  List<CityListModel> selectedChatList = [];
  List<CityListModel> onRating = [
    CityListModel("All"),
    CityListModel("4.0+"),
    CityListModel("3.0+"),
    CityListModel("2.0+"),
    CityListModel("sdssd"),
    CityListModel("dfdsfdsf"),
    CityListModel("sdffgfdgfdgfdg"),
    CityListModel("fgf"),
  ];

  File? image;
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3.5,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      //Navigator.of(context).pushNamed(HomePageResultsScreen.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: selectedListCategory
                                  .contains(onCategory[index].title)
                              ? Color(0x14dc3642)
                              : Colors.white,
                          border: Border.all(
                              width: 1,
                              color: selectedListCategory
                                      .contains(onCategory[index].title)
                                  ? red_dc3642
                                  : grey_d9dde3)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                      child: // All
                          Text(onCategory[index].title,
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProMedium,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.center),
                    ),
                  );
                },
                itemCount: onCategory.length),
            GestureDetector(
              onTapDown: (_) {
                _startOperation();
              },
              onTapUp: (_) {
                _timer.cancel();
                if (!isLongPressed) {
                  print("Is a onTap event");
                } else {
                  isLongPressed = false;
                }
              },
              child: Text(
                'Hello, World!',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Wrap(
              children: [
                ...List.generate(
                  onRating.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        print("Click checking");
                        if (selectedChatList.contains(onRating[index])) {
                          selectedChatList.remove(onRating[index]);
                        } else {
                          selectedChatList.add(onRating[index]);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: selectedChatList.contains(onRating[index])
                                ? Colors.amber
                                : Colors.pink),
                        color: selectedChatList.contains(onRating[index])
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(onRating[index].title),
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black54,
                    pageBuilder: (ctx, a1, a2) {
                      return Container();
                    },
                    transitionBuilder: (ctx, a1, a2, child) {
                      var curve = Curves.easeInOut.transform(a1.value);
                      return Transform.scale(
                        scale: curve,
                        child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r)),
                            insetPadding: EdgeInsets.all(70),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              width: double.infinity,
                              // height: 340.h,
                              padding: EdgeInsets.only(top: 20.h, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          IconButton(
                                            iconSize: 50,
                                            icon: const Icon(
                                              Icons.camera,
                                              color: red_dc3642,
                                            ),
                                            onPressed: () {
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
                                            iconSize: 50,
                                            icon: const Icon(
                                              Icons.image,
                                              color: blue_007add,
                                            ),
                                            onPressed: () {
                                              selectImage();
                                            },
                                          ),
                                          Text('Gallery'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: red_dc3642,
                  onPrimary: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.r),
                    side: BorderSide(color: red_dc3642, width: 1),
                  ),
                ),
                child: Text(
                  "Click Here",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: fontMavenProMedium),
                )),
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image2),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int i) => SizedBox(
                        width: 14.w,
                      ),
                  itemCount: onRating.length,
                  itemBuilder: (context, i) => GestureDetector(
                        onTap: () {
                          setState(() {
                            mySelectConsultation = i;
                            selectedDay = (onRating[i].title);
                          });
                        },
                        child: Wrap(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: mySelectConsultation == i
                                      ? Color(0x14dc3642)
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: mySelectConsultation == i
                                          ? red_dc3642
                                          : grey_d9dde3)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 5.h),
                              child: // All
                                  Center(
                                child: Text(onRating[i].title,
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
          ],
        ));
  }
}

const _defaultColor = Color(0xFF34568B);

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}
