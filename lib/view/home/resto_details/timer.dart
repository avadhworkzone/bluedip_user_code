import 'dart:async';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_detail_res_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../../../modal/apiModel/response_modal/get_booking_order_detail_res.dart';

Timer? countTimer;

class TimerClass extends StatefulWidget {
  TimerClass(
      {Key? key, this.response, this.bookingDetailRes, this.isBookingDetail})
      : super(key: key);
  OfferDetailsResModel? response;
  GetBookingOrderDetailResModel? bookingDetailRes;
  bool? isBookingDetail;

  @override
  State<TimerClass> createState() => _TimerClassState();
}

class _TimerClassState extends State<TimerClass> {
  String textData = '';
  String currentTime = DateFormat("HH:mm:ss").format(DateTime.now());

  /// start time

  startTimer() {
    if (widget.response!.data!.timePeriod!.start != "" ||
        widget.response!.data!.timePeriod!.end != "") {
      DateTime startTime = DateFormat("HH:mm a")
          .parse(widget.response!.data!.timePeriod!.start!);

      ///res.data!.timePeriod!.start!
      String formattedSTime = DateFormat('HH:mm:ss').format(startTime);

      /// end time
      var format = DateFormat("HH:mm:ss");
      var one = format.parse(currentTime);
      DateTime parsedTime =
          DateFormat('hh:mm a').parse(widget.response!.data!.timePeriod!.end!);
      String formattedETime = DateFormat('HH:mm:ss').format(parsedTime);
      var endTime = format.parse(formattedETime);
      var start = format.parse(formattedSTime);

      int convertTimeToMinutes(String timeString) {
        DateFormat format = DateFormat('hh:mm:ss');
        DateTime dateTime = format.parse(timeString);

        int hours = dateTime.hour;
        int minutes = dateTime.minute;

        return (hours * 60) + minutes;
      }

      var fromTime = convertTimeToMinutes(formattedSTime);
      var toTime = convertTimeToMinutes(formattedETime);
      var current = convertTimeToMinutes(currentTime);
      var timeDifference = endTime.difference(start).inHours;

      if (current > fromTime && current < toTime) {
        if (timeDifference <= 2) {
          print('2 hour ni condition ma jay che');
          countTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
            var timeDif = format
                .parse(DateFormat('HH:mm:ss').format(DateFormat('hh:mm a')
                    .parse(widget.response!.data!.timePeriod!.end!)))
                .difference(format
                    .parse(DateFormat("HH:mm:ss").format(DateTime.now())));
            print('timedifference==${timeDif}');

            final mm = (timeDif.inMinutes % 60).toString().padLeft(2, '0');
            final HH = (timeDif.inHours).toString().padLeft(2, '0');
            final ss = (timeDif.inSeconds % 60).toString().padLeft(2, '0');
            setState(() {
              textData = "${HH}h ${mm}m ${ss}s";
            });
            //   print('textData====>$textData');
            //   print('------timeDifference----${timeDifference}');
          });
          print('textData====>$textData');
        } else {
          setState(() {
            textData =
                "Offer valid between ${widget.response!.data!.timePeriod!.start} - ${widget.response!.data!.timePeriod!.end}";
          });
        }
      } else {
        print('else ni condition ma jay che');
        setState(() {
          textData =
              "Offer valid between ${widget.response!.data!.timePeriod!.start} - ${widget.response!.data!.timePeriod!.end}";
        });
      }
    }
  }

  bookingDetailTimer() {
    if (widget.bookingDetailRes!.data!.offerData!.timePeriod!.start != "" ||
        widget.bookingDetailRes!.data!.offerData!.timePeriod!.end != "") {
      DateTime startTime = DateFormat("HH:mm a")
          .parse(widget.bookingDetailRes!.data!.offerData!.timePeriod!.start!);

      ///res.data!.timePeriod!.start!
      String formattedSTime = DateFormat('HH:mm:ss').format(startTime);

      /// end time
      var format = DateFormat("HH:mm:ss");
      var one = format.parse(currentTime);
      DateTime parsedTime = DateFormat('hh:mm a')
          .parse(widget.bookingDetailRes!.data!.offerData!.timePeriod!.end!);
      String formattedETime = DateFormat('HH:mm:ss').format(parsedTime);
      var endTime = format.parse(formattedETime);
      var start = format.parse(formattedSTime);

      int convertTimeToMinutes(String timeString) {
        DateFormat format = DateFormat('hh:mm:ss');
        DateTime dateTime = format.parse(timeString);

        int hours = dateTime.hour;
        int minutes = dateTime.minute;

        return (hours * 60) + minutes;
      }

      var fromTime = convertTimeToMinutes(formattedSTime);
      var toTime = convertTimeToMinutes(formattedETime);
      var current = convertTimeToMinutes(currentTime);
      var timeDifference = endTime.difference(start).inHours;

      if (current > fromTime && current < toTime) {
        if (timeDifference <= 2) {
          print('2 hour ni condition ma jay che');
          countTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
            var timeDif = format
                .parse(DateFormat('HH:mm:ss').format(DateFormat('hh:mm a')
                    .parse(widget
                        .bookingDetailRes!.data!.offerData!.timePeriod!.end!)))
                .difference(format
                    .parse(DateFormat("HH:mm:ss").format(DateTime.now())));
            print('timedifference==${timeDif}');

            final mm = (timeDif.inMinutes % 60).toString().padLeft(2, '0');
            final HH = (timeDif.inHours).toString().padLeft(2, '0');
            final ss = (timeDif.inSeconds % 60).toString().padLeft(2, '0');
            setState(() {
              textData = "${HH}h ${mm}m ${ss}s";
            });
            //   print('textData====>$textData');
            //   print('------timeDifference----${timeDifference}');
          });
          print('textData====>$textData');
        } else {
          setState(() {
            textData =
                "Offer valid between ${widget.bookingDetailRes!.data!.offerData!.timePeriod!.start} - ${widget.bookingDetailRes!.data!.offerData!.timePeriod!.end}";
          });
        }
      } else {
        print('else ni condition ma jay che');
        setState(() {
          textData = "";
        });
      }
    }
  }

  @override
  void dispose() {
    countTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    widget.isBookingDetail == true ? bookingDetailTimer() : startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(textData,
        style: TextStyle(
            color: blue_007add,
            fontFamily: fontMavenProMedium,
            fontSize: 14.sp),
        textAlign: TextAlign.left);
  }
}
