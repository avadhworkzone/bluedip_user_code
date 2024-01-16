import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final sampleUsers = [
    UserModel([
      StoryModel(
          "https://images.unsplash.com/photo-1601758228041-f3b2795255f1?ixid=MXwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxN3x8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
      StoryModel(
          "https://images.unsplash.com/photo-1609418426663-8b5c127691f9?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNXx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
      StoryModel(
          "https://images.unsplash.com/photo-1609444074870-2860a9a613e3?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1Nnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
      // StoryModel(
      //     "https://images.unsplash.com/photo-1609504373567-acda19c93dc4?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1MHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
    ], "User1",
        "https://images.unsplash.com/photo-1609262772830-0decc49ec18c?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMDF8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
    UserModel([
      StoryModel(
          "https://images.unsplash.com/photo-1609439547168-c973842210e1?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4Nnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
    ], "User2",
        "https://images.unsplash.com/photo-1601758125946-6ec2ef64daf8?ixid=MXwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMjN8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
    UserModel([
      StoryModel(
          "https://images.unsplash.com/photo-1609421139394-8def18a165df?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMDl8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
      StoryModel(
          "https://images.unsplash.com/photo-1609377375732-7abb74e435d9?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxODJ8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
      StoryModel(
          "https://images.unsplash.com/photo-1560925978-3169a42619b2?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMjF8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
    ], "User3",
        "https://images.unsplash.com/photo-1609127102567-8a9a21dc27d8?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOTh8fHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
  ];

  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        body: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            final user = sampleUsers[pageIndex];
            final story = user.stories[storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: StoryImage(
                    key: ValueKey(story.imageUrl),
                    imageProvider: NetworkImage(
                      story.imageUrl,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        icon: SvgPicture.asset(
                          icon_cancel,
                          color: Colors.white,
                          width: 24.w,
                          height: 24.h,
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                      Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              user.userName,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontFamily: fontMavenProBold),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("New Delhi, 31.11.2022",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 12.sp),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        icon_delete_black,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xe1ffffff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          topRight: Radius.circular(6.r),
                        )),
                    padding: EdgeInsets.all(16.r),
                    child: Text(
                        "Username Lorem ipsum dolo ametconsectetur adipiscing elit, sed do eiusmod temUsername Lorem ipsum dolor sit ametconsectadipiscing elit, sed do eiusmod tempor..Username Lorem ipsum dolor sit ametconsectetur ",
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProRegular,
                            fontSize: 14.sp,
                            height: 1.5),
                        textAlign: TextAlign.left),
                  ),
                ),
              ],
            );
          },
          // gestureItemBuilder: (context, pageIndex, storyIndex) {
          //   return Stack(children: [
          //
          //     if (pageIndex == 0)
          //       Center(
          //         child: ElevatedButton(
          //           child: const Text('show modal bottom sheet'),
          //           onPressed: () async {
          //             indicatorAnimationController.value =
          //                 IndicatorAnimationCommand.pause;
          //             await showModalBottomSheet(
          //               context: context,
          //               builder: (context) => SizedBox(
          //                 height: MediaQuery.of(context).size.height / 2,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(24),
          //                   child: Text(
          //                     'Look! The indicator is now paused\n\n'
          //                     'It will be coutinued after closing the modal bottom sheet.',
          //                     style: Theme.of(context).textTheme.headlineSmall,
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ),
          //               ),
          //             );
          //             indicatorAnimationController.value =
          //                 IndicatorAnimationCommand.resume;
          //           },
          //         ),
          //       ),
          //   ]);
          // },
          indicatorAnimationController: indicatorAnimationController,
          initialStoryIndex: (pageIndex) {
            if (pageIndex == 0) {
              return 1;
            }
            return 0;
          },
          pageLength: sampleUsers.length,
          storyLength: (int pageIndex) {
            return sampleUsers[pageIndex].stories.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}
