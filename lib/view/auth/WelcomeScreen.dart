// import 'package:bluedip_user/Styles/my_font.dart';
// import 'package:bluedip_user/Styles/my_icons.dart';
// import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
// import 'package:bluedip_user/modal/apiModel/response_modal/signUp_SignIn_res_model.dart';
// import 'package:bluedip_user/modal/apis/api_response.dart';
// import 'package:bluedip_user/viewModel/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../Styles/my_colors.dart';
// import '../../Styles/my_strings.dart';
// import '../../Widget/Textfield.dart';
// import '../../Widget/red_box_shadow.dart';
// import '../../utils/enum_utils.dart';
// import '../../utils/validation_utils.dart';
// import 'OtpVerificationScreen.dart';
// import 'WelcomePageFirst.dart';
// import 'WelcomePageFourth.dart';
// import 'WelcomePageSecond.dart';
// import 'WelcomePageThird.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final _formKey = GlobalKey<FormState>();
//   AuthViewModel authViewModel = Get.find();
//   // the index of the current page
//   int _activePage = 0;
//
//   // this list holds all the pages
//   // all of them are constructed in the very end of this file for readability
//   final List<Widget> _pages = [
//     const WelcomePageFirst(),
//     const WelcomePageSecond(),
//     const WelcomePageThird(),
//     const WelcomePageFourth(),
//   ];
//   bool _selectedFirst = true;
//   final _mobileNumController = TextEditingController();
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
//           child: Scaffold(
//               backgroundColor: white_ffffff,
//               body: CustomScrollView(
//                 physics: ScrollPhysics(),
//                 slivers: [
//                   SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: Stack(
//                       children: [
//                         Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height / 1.55,
//                               child: PageView.builder(
//                                 controller: _pageController,
//                                 onPageChanged: (int page) {
//                                   setState(() {
//                                     _activePage = page;
//                                   });
//                                 },
//                                 itemCount: _pages.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return _pages[index % _pages.length];
//                                 },
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List<Widget>.generate(
//                                   _pages.length,
//                                   (index) => Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 4),
//                                         child: InkWell(
//                                           onTap: () {
//                                             _pageController.animateToPage(index,
//                                                 duration: const Duration(
//                                                     milliseconds: 300),
//                                                 curve: Curves.easeIn);
//                                           },
//                                           child: CircleAvatar(
//                                             radius: 4,
//                                             backgroundColor:
//                                                 _activePage == index
//                                                     ? black_504f58
//                                                     : Color(0x33504f58),
//                                           ),
//                                         ),
//                                       )),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 65.h,
//                                 ),
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 24.w),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       // Login or Signup
//                                       Text(strLoginSignup.toUpperCase(),
//                                           style: TextStyle(
//                                               color: grey_77879e,
//                                               fontFamily: fontMavenProMedium,
//                                               fontSize: 14.sp),
//                                           textAlign: TextAlign.left),
//                                       SizedBox(
//                                         height: 18.h,
//                                       ),
//                                       // Title
//                                       Text(strMobile,
//                                           style: TextStyle(
//                                               color: black_504f58,
//                                               fontFamily: fontMavenProRegular,
//                                               fontSize: 14.sp),
//                                           textAlign: TextAlign.left),
//                                       SizedBox(
//                                         height: 6.h,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Form(
//                                             key: _formKey,
//                                             child: Expanded(
//                                               flex: 1,
//                                               child: loginTextformField(
//                                                 "",
//                                                 keyboardType:
//                                                     TextInputType.phone,
//                                                 validationType:
//                                                     ValidationType.PNumber,
//                                                 textInputAction:
//                                                     TextInputAction.done,
//                                                 controller:
//                                                     _mobileNumController,
//                                                 obscureText: true,
//                                                 isValidate: true,
//                                                 inputLength: 10,
//                                                 regularExpression:
//                                                     RegularExpression
//                                                         .digitsPattern,
//                                                 onChanged: (value) {
//                                                   if (value.length == 10) {
//                                                     FocusScope.of(context)
//                                                         .unfocus();
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 12.w,
//                                           ),
//                                           GestureDetector(
//                                             onTap: () async {
//                                               if (_formKey.currentState!
//                                                   .validate()) {
//                                                 FocusScope.of(context)
//                                                     .unfocus();
//                                                 print(
//                                                     '_selectedFirst${_selectedFirst}');
//                                                 if (_selectedFirst) {
//                                                   TermsConditionAlretDialog();
//                                                 } else {
//                                                   await authViewModel
//                                                       .signUpSignInViewModel(
//                                                           mobileNumber:
//                                                               _mobileNumController
//                                                                   .text,
//                                                           type: "user_login");
//                                                   if (authViewModel
//                                                           .authApiResponse
//                                                           .status ==
//                                                       Status.COMPLETE) {
//                                                     SignUpSignInResModel
//                                                         response = authViewModel
//                                                             .authApiResponse
//                                                             .data;
//                                                     if (response.data!.status ==
//                                                         false) {
//                                                       Get.snackbar('',
//                                                           '${response.data!.message}',
//                                                           snackPosition:
//                                                               SnackPosition
//                                                                   .BOTTOM,
//                                                           colorText:
//                                                               Colors.white,
//                                                           backgroundColor:
//                                                               blue_3d56f0);
//                                                     } else {
//                                                       Get.to(
//                                                           OtpVerificationScreen(
//                                                         otp:
//                                                             response.data!.otp!,
//                                                         mobileNo:
//                                                             _mobileNumController
//                                                                 .text,
//                                                       ))?.then((value) =>
//                                                           _mobileNumController
//                                                               .clear());
//                                                     }
//
//                                                     // Navigator.push(
//                                                     //     context,
//                                                     //     MaterialPageRoute(
//                                                     //       builder: (context) =>
//                                                     //           VerifyEmailOtpScreen(id: 1),
//                                                     //     ));
//                                                   }
//                                                 }
//                                               }
//                                             },
//                                             child: Container(
//                                               decoration: redboxDecoration,
//                                               width: 61.w,
//                                               height: 52.h,
//                                               child: Center(
//                                                   child: SvgPicture.asset(
//                                                       icon_right_arrow)),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 16.h,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             _selectedFirst = !_selectedFirst;
//                                             print("click thay che");
//                                           });
//                                         },
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: 20.h,
//                                               width: 20.w,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(6.r)),
//                                                   border: Border.all(
//                                                       color: _selectedFirst
//                                                           ? grey_d9dde3
//                                                           : red_dc3642,
//                                                       width: 1),
//                                                   color: _selectedFirst
//                                                       ? const Color(0xffffffff)
//                                                       : red_dc3642),
//                                               child: _selectedFirst
//                                                   ? Icon(
//                                                       Icons.check,
//                                                       size: 18.sp,
//                                                       color: Colors.white,
//                                                     )
//                                                   : Icon(
//                                                       Icons.check,
//                                                       size: 18.sp,
//                                                       color: Colors.white,
//                                                     ),
//                                             ),
//                                             SizedBox(
//                                               width: 6.w,
//                                             ),
//                                             // Same as Business address
//                                             RichText(
//                                                 textAlign: TextAlign.start,
//                                                 text: TextSpan(children: [
//                                                   TextSpan(
//                                                       style: TextStyle(
//                                                           color: grey_77879e,
//                                                           fontFamily:
//                                                               fontMavenProRegular,
//                                                           fontStyle:
//                                                               FontStyle.normal,
//                                                           fontSize: 14.sp),
//                                                       text: str_i_agree_with),
//                                                   TextSpan(
//                                                       style: TextStyle(
//                                                           color: red_dc3642,
//                                                           fontFamily:
//                                                               fontMavenProRegular,
//                                                           fontStyle:
//                                                               FontStyle.normal,
//                                                           fontSize: 14.sp,
//                                                           height: 1.5),
//                                                       text:
//                                                           str_terms_conditions),
//                                                 ]))
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.h,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         GetBuilder<AuthViewModel>(
//                           builder: (authViewModel) {
//                             if (authViewModel.authApiResponse.status ==
//                                 Status.LOADING) {
//                               return CircularIndicator();
//                             }
//                             return SizedBox();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ))),
//     );
//   }
//
//   TermsConditionAlretDialog() {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text(''),
//           contentPadding: EdgeInsets.zero,
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   child: Text(
//                     'by continue,\nagree with our terms and condition',
//                     style: TextStyle(
//                         fontFamily: fontMavenProRegular,
//                         fontStyle: FontStyle.normal,
//                         fontSize: 18.sp),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'Ok',
//                 style: TextStyle(
//                     fontFamily: fontMavenProRegular,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 18.sp),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

/// new
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/signUp_SignIn_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/red_box_shadow.dart';
import '../../utils/enum_utils.dart';
import '../../utils/validation_utils.dart';
import 'OtpVerificationScreen.dart';
import 'WelcomePageFirst.dart';
import 'WelcomePageFourth.dart';
import 'WelcomePageSecond.dart';
import 'WelcomePageThird.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final _formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = Get.find();
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: white_ffffff, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return Scaffold(
        backgroundColor: white_ffffff,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.55,
                        child: PageView.builder(
                          allowImplicitScrolling: true,
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _activePage = page;
                            });
                          },
                          itemCount: _pages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _pages[index % _pages.length];
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                            _pages.length,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () {
                                      _pageController.animateToPage(index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                                    child: CircleAvatar(
                                      radius: 4,
                                      backgroundColor: _activePage == index
                                          ? black_504f58
                                          : Color(0x33504f58),
                                    ),
                                  ),
                                )),
                      ),
                      SizedBox(
                        height: 65.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Login or Signup
                            Text(strLoginSignup.toUpperCase(),
                                style: TextStyle(
                                    color: grey_77879e,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 18.h,
                            ),
                            // Title
                            Text(strMobile,
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: loginTextformField(
                                    "",
                                    keyboardType: TextInputType.phone,
                                    validationType: ValidationType.PNumber,
                                    textInputAction: TextInputAction.done,
                                    controller: _mobileNumController,
                                    obscureText: true,
                                    isValidate: true,
                                    inputLength: 10,
                                    regularExpression:
                                        RegularExpression.digitsPattern,
                                    onChanged: (value) {
                                      if (value.length == 10) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      print('_selectedFirst${_selectedFirst}');
                                      if (_selectedFirst) {
                                        snackBar(
                                            title: 'Please Agree with T&C');
                                        // Get.snackbar(
                                        //     '', 'Please Agree with T&C',
                                        //     snackPosition: SnackPosition.BOTTOM,
                                        //     colorText: Colors.white,
                                        //     backgroundColor: red_dc3642);
                                      } else {
                                        await authViewModel
                                            .signUpSignInViewModel(
                                                mobileNumber:
                                                    _mobileNumController.text,
                                                type: "user_login");
                                        if (authViewModel
                                                .authApiResponse.status ==
                                            Status.COMPLETE) {
                                          SignUpSignInResModel response =
                                              authViewModel
                                                  .authApiResponse.data;
                                          if (response.data!.status == true) {
                                            Get.to(OtpVerificationScreen(
                                              otp: response.data!.otp!,
                                              mobileNo:
                                                  _mobileNumController.text,
                                            ))?.then((value) =>
                                                _mobileNumController.clear());
                                          } else {
                                            snackBar(title: '${response.data!.message}');

                                          }

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           VerifyEmailOtpScreen(id: 1),
                                          //     ));
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: redboxDecoration,
                                    width: 61.w,
                                    height: 52.h,
                                    child: Center(
                                        child:
                                            SvgPicture.asset(icon_right_arrow)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedFirst = !_selectedFirst;
                                  print("click thay che");
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.r)),
                                        border: Border.all(
                                            color: _selectedFirst
                                                ? grey_d9dde3
                                                : red_dc3642,
                                            width: 1),
                                        color: _selectedFirst
                                            ? const Color(0xffffffff)
                                            : red_dc3642),
                                    child: _selectedFirst
                                        ? Icon(
                                            Icons.check,
                                            size: 18.sp,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.check,
                                            size: 18.sp,
                                            color: Colors.white,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  // Same as Business address
                                  RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: grey_77879e,
                                                fontFamily: fontMavenProRegular,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.sp),
                                            text: str_i_agree_with),
                                        TextSpan(
                                            style: TextStyle(
                                                color: red_dc3642,
                                                fontFamily: fontMavenProRegular,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.sp,
                                                height: 1.5),
                                            text: str_terms_conditions),
                                      ]))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // )
                    ],
                  ),
                ),
                GetBuilder<AuthViewModel>(
                  builder: (authViewModel) {
                    if (authViewModel.authApiResponse.status ==
                        Status.LOADING) {
                      return const CircularIndicator();
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  TermsConditionAlretDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'by continue,\nagree with our terms and condition',
                    style: TextStyle(
                        fontFamily: fontMavenProRegular,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    fontFamily: fontMavenProRegular,
                    fontStyle: FontStyle.normal,
                    fontSize: 18.sp),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
