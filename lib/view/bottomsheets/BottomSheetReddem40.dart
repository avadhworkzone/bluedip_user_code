import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/green_ticket_widget.dart';
import '../DineInRedeemOffer.dart';
import '../order/RedeemOffer.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetReddem40 extends StatefulWidget {
  const BottomSheetReddem40({Key? key}) : super(key: key);

  @override
  State<BottomSheetReddem40> createState() => _BottomSheetReddem40State();
}

class _BottomSheetReddem40State extends State<BottomSheetReddem40> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreenTicketWidget(
              title: '40%',
              subtitle: 'Must order Within 1h 20m 10s',
              type: "Dine-In"),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CommonBorderButton("Close".toUpperCase(), () {
                  Navigator.pop(context, false);
                }, red_dc3642, white_ffffff, red_dc3642),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                flex: 2,
                child: CommonRedButton("Order & Pay In App".toUpperCase(), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DineInRedeemOffer(),
                      ));
                }, red_dc3642),
              ),
            ],
          )
        ],
      ),
    );
  }
}
