
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_icons.dart';

class back_button extends StatelessWidget {
  // const back_button(String strWhereFrom, {Key? key}) : super(key: key);

  // String strWhereFrom;
  //
  // back_button(this.strWhereFrom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {

          Navigator.pop(context, false)
            },
        child: SvgPicture.asset(icon_arrow_left));
  }
}
