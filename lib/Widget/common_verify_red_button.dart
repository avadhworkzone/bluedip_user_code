import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Styles/my_font.dart';

class CommonVerifyRedButton extends StatelessWidget {
  final String btnTitle;
  final Color color;
  final Color txt_color;
  VoidCallback? onCustomButtonPressed;

  CommonVerifyRedButton(
      this.btnTitle, this.onCustomButtonPressed, this.color, this.txt_color);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(left: 14.w, right: 14.w),
      decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0x825468ff),
          //     blurRadius: 15.0,
          //     spreadRadius: 0,
          //     offset: Offset(0,5,),
          //   )
          // ],

          ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onCustomButtonPressed,
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
                // side: BorderSide(color: skygreen_24d39e, width: 0),
              ),
            ),
            child: Text(
              btnTitle,
              style: TextStyle(
                  color: txt_color,
                  fontSize: 15.sp,
                  fontFamily: fontMavenProMedium),
            )),
      ),
    );
  }
}
