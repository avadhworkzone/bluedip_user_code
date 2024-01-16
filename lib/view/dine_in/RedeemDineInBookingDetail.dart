import 'dart:async';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/Widget/common_border_button.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_booking_order_detail_res.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/dine_in/Dine_in_menu.dart';
import 'package:bluedip_user/view/order/RedeemOffer.dart';
import 'package:bluedip_user/view/order/RedeemOrderMenuList.dart';
import 'package:bluedip_user/viewModel/bottom_view_model.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/box_shadow_ticket.dart';
import '../../Widget/box_shadow_ticket_second.dart';
import '../RedeemDineInBookingDetailInActive.dart';
import '../../Widget/common_red_button.dart';

bool isDealInActive = false;
OrderViewModel orderViewModel = Get.find();
BottomViewModel bottomViewModel = Get.find();
String? openingDuration;

class RedeemDineInBookingDetail extends StatefulWidget {
  RedeemDineInBookingDetail({Key? key, this.orderId}) : super(key: key);
  String? orderId;

  @override
  State<RedeemDineInBookingDetail> createState() =>
      _RedeemDineInBookingDetailState();
}

class _RedeemDineInBookingDetailState extends State<RedeemDineInBookingDetail> {
  int mypostion = 0;

  bool isOpen = false;
  OrderViewModel orderViewModel = Get.find();
  GetBookingOrderDetailResModel? response;
  Map<String, dynamic>? currentData;
  String? formattedDateTime;
  String? closeDate;
  String? openDate;
  int? fromTime;
  int? toTime;
  int? current;
  Timer? _timer;
  DateTime _initialDate = DateTime.now(); // Date received from the API
  bool _isCountdownComplete = false;

  getBookingOrderDetailApiCall() async {
    await orderViewModel
        .getBookingOrderViewModel(orderId: widget.orderId!)

        ///widget.orderId!
        .then((value) {
      if (orderViewModel.getBookingOrderDetailApiResponse.status ==
          Status.COMPLETE) {
        response = orderViewModel.getBookingOrderDetailApiResponse.data;
        _initialDate = DateTime.parse(response!.data!.dateCreated!);
        if (response == null ||
            response!.data == null ||
            response!.data!.restaurantData!.hours == null) {
        } else {
          fetchDate();
        }
        startCountdown(res: response!.data!);
        if (response!.data!.attendStatus == "GUEST_DID_NOT_COME") {
          print('---guest did not come---');
          guestDidNotCome(
              context: context,
              bookingId: response!.data!.bookingId.toString());
        }
      }
    });
  }

  String getOpeningDuration(DateTime currentTime, DateTime fromTime1) {
    final difference = fromTime1.difference(currentTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);

    return '${hours}hr ${minutes}min';
  }

  void startCountdown({required Data res}) {
    DateTime targetDate = _initialDate.add(Duration(minutes: 1));
    Duration remainingTime = targetDate.difference(DateTime.now());
    _timer = Timer(remainingTime, () async {
      setState(() {
        _isCountdownComplete = true;
      });

      // await dealInactive(context: context, res: res);
    });
  }

  fetchDate() {
    int currentDayIndex;
    if (response != null ||
        response!.data != null ||
        response!.data!.restaurantData!.hours != null ||
        response!.data!.restaurantData!.hours!.isNotEmpty) {
      String day = DateFormat.EEEE().format(DateTime.now()).toLowerCase();
      Map<String, dynamic> hoursJson =
          response!.data!.restaurantData!.hours!.first.toJson();

      /// key
      List<dynamic> key = hoursJson.keys.toList();

      currentDayIndex = key.indexWhere((element) => element == day);

      ///value
      List<dynamic> value = hoursJson.values.toList();

      currentData = value[currentDayIndex];
      print('currentData...${currentData}');

      /// for end time get
      closeDate = currentData!['to'];
      openDate = currentData!['from'];
      if (closeDate != "" || openDate != "") {
        DateTime now = DateTime.now();
        DateFormat format = DateFormat('h:mm a');
        String currentTime = format.format(now);

        int convertTimeToMinutes(String timeString) {
          DateFormat format = DateFormat('hh:mm a');
          DateTime dateTime = format.parse(timeString);

          int hours = dateTime.hour;
          int minutes = dateTime.minute;

          return (hours * 60) + minutes;
        }

        String from = currentData!['from'];
        String to = currentData!['to'];

        ///currentData!['to'];
        String timeString3 = currentTime;

        fromTime = convertTimeToMinutes(from);
        toTime = convertTimeToMinutes(to);
        current = convertTimeToMinutes(timeString3);
        final currentTime1 = DateTime.now();
        // final fromTime1 =
        //     DateTime(2023, 7, 19, 10, 30); // Replace with your from time
        DateTime convertToDateTime(String timeString) {
          final format = DateFormat.jm(); // "jm" represents the AM/PM format
          final dateTime = format.parse(timeString);
          return DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            dateTime.hour,
            dateTime.minute,
          );
        }

        openingDuration =
            getOpeningDuration(currentTime1, convertToDateTime(from));

        // openingDuration = getOpeningDuration(from);
        openDialogWhenRestoClose();
      }
    }
  }

  openDialogWhenRestoClose() {
    if (current! > fromTime! && current! < toTime!) {
      print('resto is open');
    } else {
      selectHoldOn(context);
    }
  }

  @override
  void initState() {
    getBookingOrderDetailApiCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Color(0xfffae6e9), // navigation bar color
    //   statusBarColor: Color(0xfffae6e9), // status bar color
    //   statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //   systemNavigationBarIconBrightness:
    //       Brightness.light, //navigation bar icons' color
    // ));
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,

        ///Color(0xfffae6e9), // navigation bar color
        statusBarColor: Color(0xfffae6e9), // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfffae6e9),
          body: GetBuilder<OrderViewModel>(
            builder: (controller) {
              if (controller.getBookingOrderDetailApiResponse.status ==
                  Status.LOADING) {
                return const CircularIndicator();
              }
              if (controller.getBookingOrderDetailApiResponse.status ==
                  Status.ERROR) {
                return const ServerError();
              }
              if (controller.getBookingOrderDetailApiResponse.status ==
                  Status.COMPLETE) {
                response = controller.getBookingOrderDetailApiResponse.data;
                final String dateString = response!.data!.dateCreated!;
                List<String> dateComponents = dateString.split(' ');
                List<String> datePart = dateComponents[0].split('-');
                List<String> timePart = dateComponents[1].split(':');
                int year = int.parse(datePart[0]);
                int month = int.parse(datePart[1]);
                int day = int.parse(datePart[2]);
                int hour = int.parse(timePart[0]);
                int minute = int.parse(timePart[1]);
                int second = int.parse(timePart[2]);
                DateTime createdDate =
                    DateTime.utc(year, month, day, hour, minute, second);
                // DateTime.utc(int.parse(response!.data!.dateCreated!));
                DateTime localTime = createdDate.toLocal();

                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(localTime);
                String formattedTime = DateFormat('h:mm a').format(localTime);

                formattedDateTime = '$formattedDate at $formattedTime';
              }
              return response == null
                  ? const NoDataFound()
                  : Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 16.h),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.offAll(() =>
                                              const BottomNavigationScreen());
                                          // Navigator.pop(context, false);
                                        },
                                        child: SvgPicture.asset(icon_cancel)),
                                  ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     Image.asset(bluedip_app_icon_second,width: 60.w,height: 60.h),
                                  //     // Bluedip
                                  //     Text(
                                  //         "Bluedip",
                                  //         style:  TextStyle(
                                  //             color:  red_dc3642,
                                  //             fontFamily: fontOverpassBold,
                                  //             fontSize: 20.sp
                                  //         ),
                                  //         textAlign: TextAlign.center
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           const RedeemDineInBookingDetailInActive(),
                                          //     ));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: boxDecorationTicket,
                                              padding: EdgeInsets.only(
                                                  left: 18.w,
                                                  right: 18.w,
                                                  top: 18.h,
                                                  bottom: 20.h),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.r),
                                                    child: response == null ||
                                                            response!.data ==
                                                                null ||
                                                            response!
                                                                    .data!
                                                                    .restaurantData!
                                                                    .restaurantImg ==
                                                                null ||
                                                            response!
                                                                    .data!
                                                                    .restaurantData!
                                                                    .restaurantImg ==
                                                                ""
                                                        ? Image.asset(
                                                            "assets/images/bluedip_app_icon_second.png",
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover)
                                                        : Image.network(
                                                            "${response!.data!.restaurantData!.restaurantImg!}",
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover),

                                                    // Image.asset(
                                                    //   img_pizza_food_buddy,
                                                    //   width: 98.h,
                                                    //   height: 98.h,
                                                    //   fit: BoxFit.cover,
                                                    // )
                                                  ),
                                                  SizedBox(
                                                    width: 14.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          response!
                                                                  .data!
                                                                  .restaurantData!
                                                                  .restaurantName ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProBold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 18.sp),
                                                          textAlign:
                                                              TextAlign.center),
                                                      // 20% OFF
                                                      Text(
                                                          "${response!.data!.offerData!.offerPercentage} OFF",
                                                          style: TextStyle(
                                                              color:
                                                                  green_5cb85c,
                                                              fontFamily:
                                                                  fontOverpassBold,
                                                              fontSize: 28.sp),
                                                          textAlign:
                                                              TextAlign.center),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      response!
                                                                  .data!
                                                                  .restaurantData!
                                                                  .hours ==
                                                              null
                                                          ? const SizedBox()
                                                          : Text(
                                                              "Hours: ${currentData!['from']}-${currentData!['to']}",
                                                              style: TextStyle(
                                                                  color:
                                                                      grey_5f6d7b,
                                                                  fontFamily:
                                                                      fontMavenProRegular,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 25.h,
                                                    width: 15.w,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          16.r),
                                                                  bottomRight:
                                                                      Radius.circular(16
                                                                          .r)),
                                                          color: const Color(
                                                              0xfffae6e9)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.r),
                                                      child: LayoutBuilder(
                                                          builder: (context,
                                                              constraints) {
                                                        return Flex(
                                                            direction:
                                                                Axis.horizontal,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children:
                                                                List.generate(
                                                                    (constraints.constrainWidth() /
                                                                            10)
                                                                        .floor(),
                                                                    (index) =>
                                                                        const SizedBox(
                                                                          height:
                                                                              1,
                                                                          width:
                                                                              5,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration:
                                                                                BoxDecoration(color: divider_d4dce7),
                                                                          ),
                                                                        )));
                                                      }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                    width: 15.w,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          16.r),
                                                                  bottomLeft: Radius
                                                                      .circular(16
                                                                          .r)),
                                                          color: const Color(
                                                              0xfffae6e9)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Booking Details
                                            Container(
                                              decoration:
                                                  boxDecorationTicketSecond,
                                              padding: EdgeInsets.only(
                                                  left: 18.w,
                                                  right: 14.w,
                                                  top: 20.h,
                                                  bottom: 16..h),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                        "Booking Details",
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontOverpassBold,
                                                            fontSize: 18.sp),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Coupon Type",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text(
                                                          "${response!.data!.orderType}",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Booking Time",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text(
                                                          "${response!.data!.time}, Today",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Party of",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text(
                                                          "${response!.data!.noOfGuest} People",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Name",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text(
                                                          "${response!.data!.userFullName}",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Phone",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text(
                                                          "${response!.data!.mobileNumber}",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Redeem Time",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      // Dine in
                                                      Text("$formattedDateTime",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  response!.data!.specialRequest ==
                                                              null ||
                                                          response!.data!
                                                                  .specialRequest ==
                                                              ""
                                                      ? SizedBox()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Special Request",
                                                                style: TextStyle(
                                                                    color:
                                                                        grey_77879e,
                                                                    fontFamily:
                                                                        fontMavenProRegular,
                                                                    fontSize:
                                                                        14.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                            // Dine in
                                                            Text(
                                                                "${response!.data!.specialRequest}",
                                                                style: TextStyle(
                                                                    color:
                                                                        black_504f58,
                                                                    fontFamily:
                                                                        fontMavenProMedium,
                                                                    fontSize:
                                                                        15.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right)
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      Row(
                                        children: [
                                          // Edit Info
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                // print(
                                                //     '........response-----${jsonEncode(response)}');
                                                Get.to(RedeemOffer(
                                                  dineInOrderId:
                                                      response!.data!.bookingId,
                                                  isEditFlow: true,
                                                ));
                                                // selectHoldOn(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(12.r),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Colors.white),
                                                child: Text("Edit Info",
                                                    style: TextStyle(
                                                        color: blue_007add,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectMoreOption(
                                                    context: context,
                                                    orderId: response!
                                                        .data!.bookingId
                                                        .toString());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(12.r),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Colors.white),
                                                child: Text("More Options",
                                                    style: TextStyle(
                                                        color: blue_007add,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: 24.h,
                                      ),

                                      // Experiencing an issue?
                                      Center(
                                        child: Text("Experiencing an issue?",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.center),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),

                                      Text(
                                          "Offers is valid on all full-priced menu item, including drinks. May not be valid in conjunction with other offers ₹${response!.data!.offerData!.minAmount} minimum spend",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp,
                                              height: 1.5),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<OrderViewModel>(
                          builder: (controller) {
                            if (orderViewModel
                                    .cancelBookingApiResponse.status ==
                                Status.LOADING) {
                              return const CircularIndicator();
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

void selectHoldOn(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        // int hours = openingDuration!.inHours;
        // int minutes = openingDuration!.inMinutes.remainder(60);
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("Hey, hold on!",
                          style: TextStyle(
                              color: red_dc3642,
                              fontFamily: fontOverpassBold,
                              fontSize: 18.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 10.h,
                      ),
                      // The venue is not open yet. This voucher will be active in
                      Text(
                          "The venue is not open yet. \nThis voucher will be active in",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProRegular,
                              fontSize: 15.sp,
                              height: 1.5),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 6.h,
                      ),

                      // 1hr 20min
                      Text(openingDuration!,
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProBold,
                              fontSize: 16.sp),
                          textAlign: TextAlign.center),

                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 20.h),
                          child: SizedBox(
                            width: 150.w,
                            child: CommonRedButton("ok".toUpperCase(), () {
                              Navigator.pop(context, false);
                              Get.offAll(const BottomNavigationScreen());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const ChangeMobileNumberOtp(),
                              //     ));
                            }, red_dc3642),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}

void selectMoreOption(
    {required BuildContext context, required String orderId}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            selectCancel(context: context, orderId: orderId);

                            // if(Navigator.of(context).pop()){
                            //
                            //   selectMoreOption(context);
                            // }else{
                            //   selectCancel(context);
                            // }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SvgPicture.asset(icon_cancel_square),
                                  SizedBox(
                                    width: 11.w,
                                  ),
                                  // Cancel Booking
                                  Text("Cancel Booking",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SvgPicture.asset(icon_call_restaurant),
                                  SizedBox(
                                    width: 11.w,
                                  ),
                                  // Cancel Booking
                                  Text("Call Restaurant",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const DineInMenuItems());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              children: [
                                SvgPicture.asset(icon_view_menu),
                                SizedBox(
                                  width: 11.w,
                                ),
                                // Cancel Booking
                                Text("View Menu",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            bottomViewModel.currentIndex = 1;
                            Get.off(const BottomNavigationScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              children: [
                                SvgPicture.asset(icon_locate_restaurant),
                                SizedBox(
                                  width: 11.w,
                                ),
                                // Cancel Booking
                                Text("Locate Restaurant",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}

void selectCancel({required BuildContext context, required String orderId}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            margin: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                    bottomRight: Radius.circular(13.r),
                    bottomLeft: Radius.circular(13.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              // Daily Opportunities
                              Center(
                                child: Text(
                                    "Are you sure you want to \nCancel Booking?",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontOverpassBold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.sp,
                                        height: 1.5),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              // Are you sure you would like to delete your Bluedip account?
                              Center(
                                child: Text(
                                    "You will loses great deal on dine in!",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProRegular,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              /*bottom two buttons here*/
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: CommonRedButton(
                                          strNo.toUpperCase(), () {
                                        Navigator.of(context).pop();
                                      }, red_dc3642)),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CommonBorderButton(
                                          "Cancel Booking".toUpperCase(),
                                          () async {
                                        await orderViewModel
                                            .cancelBookingViewModel(
                                                orderId: orderId);
                                        if (orderViewModel
                                                .cancelBookingApiResponse
                                                .status ==
                                            Status.ERROR) {
                                          snackBar(title: 'error');
                                        }
                                        if (orderViewModel
                                                .cancelBookingApiResponse
                                                .status ==
                                            Status.COMPLETE) {
                                          CommonResModel res = orderViewModel
                                              .cancelBookingApiResponse.data;
                                          if (res.status == true) {
                                            Navigator.of(context).pop();
                                            Get.offAll(
                                                const BottomNavigationScreen());
                                          } else {
                                            snackBar(
                                                title: 'Something Went Wrong');
                                          }
                                        }
                                      }, red_dc3642, Colors.transparent,
                                          red_dc3642)),
                                ],
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      });
}

void guestDidNotCome(
    {required BuildContext context, required String bookingId}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            margin: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                    bottomRight: Radius.circular(13.r),
                    bottomLeft: Radius.circular(13.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: 24.h, bottom: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Daily Opportunities
                        Center(
                          child: Text("Didn’t Go ?",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontOverpassBold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.sp,
                                  height: 1.5),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        // Are you sure you would like to delete your Bluedip account?
                        Center(
                          child: Text(
                              "Haven’s Food has marked you as a no show for your deal redeemed on the 13/2/2023. Is this correct?",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontStyle: FontStyle.normal,
                                  height: 1.5,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        /*bottom two buttons here*/
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: GetBuilder<OrderViewModel>(
                                  builder: (controller) {
                                    if (controller.guestAttendStatusApiResponse
                                            .status ==
                                        Status.LOADING) {
                                      return const CircularIndicator();
                                    }
                                    return CommonRedButton(
                                        "I did attend".toUpperCase(), () async {
                                      await orderViewModel
                                          .guestAttendStatusViewModel(
                                              status: "GUEST_DID_COME",
                                              orderId: bookingId)
                                          .then((value) {
                                        if (controller
                                                .guestAttendStatusApiResponse
                                                .status ==
                                            Status.ERROR) {
                                          const ServerError();
                                        }
                                        if (controller
                                                .guestAttendStatusApiResponse
                                                .status ==
                                            Status.COMPLETE) {
                                          CommonResModel res = controller
                                              .guestAttendStatusApiResponse
                                              .data;
                                          if (res.status == true) {
                                            Navigator.of(context).pop();
                                            Get.offAll(
                                                const BottomNavigationScreen());
                                          } else {
                                            snackBar(title: res.message);
                                          }
                                        }
                                      });
                                    }, red_dc3642);
                                  },
                                )),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                                flex: 1,
                                child: GetBuilder<OrderViewModel>(
                                  builder: (controller) {
                                    if (controller.guestAttendStatusApiResponse
                                            .status ==
                                        Status.LOADING) {
                                      return const CircularIndicator();
                                    }
                                    return CommonBorderButton(
                                        "I didn’t attend".toUpperCase(),
                                        () async {
                                      await orderViewModel
                                          .guestAttendStatusViewModel(
                                              status: "GUEST_DID_NOT_COME",
                                              orderId: bookingId)
                                          .then((value) {
                                        if (controller
                                                .guestAttendStatusApiResponse
                                                .status ==
                                            Status.ERROR) {
                                          const ServerError();
                                        }
                                        if (controller
                                                .guestAttendStatusApiResponse
                                                .status ==
                                            Status.COMPLETE) {
                                          CommonResModel res = controller
                                              .guestAttendStatusApiResponse
                                              .data;
                                          if (res.status == true) {
                                            Navigator.of(context).pop();
                                            Get.offAll(
                                                const BottomNavigationScreen());
                                          } else {
                                            snackBar(title: res.message);
                                          }
                                        }
                                      });
                                    }, red_dc3642, Colors.transparent,
                                        red_dc3642);
                                  },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        // This is just for our records and won’t affect your use of the app
                        Text(
                            "This is just for our records and won’t affect your use of the app",
                            style: TextStyle(
                                color: grey_5f6d7b,
                                fontFamily: fontMavenProRegular,
                                fontSize: 12.sp),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  )),
            ));
      });
}

dealInactive({required BuildContext context, required Data res}) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text("Takeaway Deal Inactive",
                              style: TextStyle(
                                  color: red_dc3642,
                                  fontFamily: fontOverpassBold,
                                  fontSize: 18.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 10.h,
                          ),
                          // The venue is not open yet. This voucher will be active in
                          Text(
                              "This voucher is now inactive. To receive the \n%off you must have arrived at the venue \nwhile this voucher is active.",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 15.sp,
                                  height: 1.5),
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 6.h,
                          ),

                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              child: SizedBox(
                                width: 150.w,
                                child: CommonRedButton("ok".toUpperCase(),
                                    () async {
                                  Get.back();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RedeemDineInBookingDetailInActive(
                                                response: res),
                                      ));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => const ChangeMobileNumberOtp(),
                                  //     ));
                                }, red_dc3642),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          },
        );
      });
}
