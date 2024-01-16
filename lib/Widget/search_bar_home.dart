import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';

class SearchBarHome extends StatefulWidget {

  // WhiteSearchBar({Key? key,required this.hintText,,required this.onChanged}) : super(key: key);

  SearchBarHome({required this.hintText,required this.onChanged,required this.onSubmitted});

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  State<SearchBarHome> createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBarHome> {


  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: EdgeInsets.only(right: 16.w, left: 16.w),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
            color: Color(0xfffcfcfd),
            border: Border.all(
          width: 1,
        color: grey_d9dde3
      )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            icon_search_home,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: TextField(
              onChanged: (value){
                widget.onChanged(value);
              },
              onSubmitted: (value){
                widget.onSubmitted(value);
              },
              autofocus: false,
              style: TextStyle(
                  color: black_504f58,
                  fontFamily: fontMavenProMedium,
                  fontSize: 14.sp),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: grey_77879e,
                    fontFamily: fontMavenProMedium,
                    fontSize: 14.sp),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}
