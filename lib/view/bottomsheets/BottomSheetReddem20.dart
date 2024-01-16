import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/green_ticket_widget.dart';
import '../order/RedeemOffer.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetReddem20 extends StatefulWidget {
  const BottomSheetReddem20({Key? key}) : super(key: key);

  @override
  State<BottomSheetReddem20> createState() => _BottomSheetReddem20State();
}

class _BottomSheetReddem20State extends State<BottomSheetReddem20> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreenTicketWidget(
              title: '20%', subtitle: 'Valid Anytime Today', type: "Takeaway"),
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
              // Expanded(
              //   flex: 2,
              //   child: CommonRedButton("Order & Pay In App".toUpperCase(), () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => RedeemOffer(),
              //         ));
              //   }, red_dc3642),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
