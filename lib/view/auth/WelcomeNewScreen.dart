import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/red_box_shadow.dart';
import '../../modal/apiModel/response_modal/signUp_SignIn_res_model.dart';
import '../../modal/apis/api_response.dart';
import '../../utils/enum_utils.dart';
import '../../utils/validation_utils.dart';
import '../../viewModel/auth_view_model.dart';
import 'OtpVerificationScreen.dart';
import 'WelcomePageFirst.dart';
import 'WelcomePageFourth.dart';
import 'WelcomePageSecond.dart';
import 'WelcomePageThird.dart';

class WelcomeNewScreen extends StatefulWidget {
  const WelcomeNewScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeNewScreen> createState() => _WelcomeNewScreenState();
}

class _WelcomeNewScreenState extends State<WelcomeNewScreen> {
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.55,
            child: PageView.builder(
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      _pages.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Form(
                            key: _formKey,
                            child: Expanded(
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
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await authViewModel.signUpSignInViewModel(
                                    mobileNumber: _mobileNumController.text,
                                    type: "user_login");
                                if (authViewModel.authApiResponse.status ==
                                    Status.COMPLETE) {
                                  SignUpSignInResModel response =
                                      authViewModel.authApiResponse.data;
                                  if (response.data!.status == false) {
                                    snackBar(
                                        title: '${response.data!.message}');
                                    // Get.snackbar(
                                    //     '', '${response.data!.message}',
                                    //     snackPosition: SnackPosition.BOTTOM,
                                    //     colorText: Colors.white,
                                    //     backgroundColor: blue_3d56f0);
                                  } else {
                                    Get.to(OtpVerificationScreen(
                                      otp: response.data!.otp!,
                                      mobileNo: _mobileNumController.text,
                                    ))?.then((value) =>
                                        _mobileNumController.clear());
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           VerifyEmailOtpScreen(id: 1),
                                  //     ));
                                }
                              }
                            },
                            child: Container(
                              decoration: redboxDecoration,
                              width: 61.w,
                              height: 52.h,
                              child: Center(
                                  child: SvgPicture.asset(icon_right_arrow)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.r)),
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
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
