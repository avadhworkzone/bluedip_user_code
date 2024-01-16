import 'dart:convert';
import 'dart:developer';

import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_sub_menu_item_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_sub_menu_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/sub_menu_item_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Model/HoursModel.dart';
import '../Styles/my_strings.dart';
import '../Widget/common_red_button.dart';
import '../Widget/toolbar_with_search.dart';

class RedeemAdsOns extends StatefulWidget {
  RedeemAdsOns({Key? key, required this.menuSubCatId}) : super(key: key);
  int menuSubCatId;

  @override
  State<RedeemAdsOns> createState() => _RedeemAdsOnsState();
}

class _RedeemAdsOnsState extends State<RedeemAdsOns> {
  OrderViewModel orderViewModel = Get.find();
  AddSubMenuItemsReqModel reqModel = AddSubMenuItemsReqModel();
  SubMenuItemsResModel? response;
  int mySelectConsultation = -1;
  List subMenu = [];
  Map<String, dynamic> radioSubMenu = {};
  String selectedDay = "";
  SubMenuItem subMenuItem = SubMenuItem();
  SubMenuItem subMenuCheck = SubMenuItem();

  // SubMenuItem subMenuItem = SubMenuItem();

  List<HoursModel> onOfferModel = [
    HoursModel("Virigin", ""),
    HoursModel("The Original", "20"),
  ];

  List<String> selectedList = [];

  List<HoursModel> onExtraSide = [
    HoursModel("Free Range Poached", "50"),
    HoursModel("Free Raneg Fried Egg", "20"),
    HoursModel("White Toast", "70"),
    HoursModel("Multigrain Toast", "40"),
    HoursModel("Sourdough Toast", "45"),
    HoursModel("Gulten Free Toast", "60"),
  ];

  @override
  void initState() {
    super.initState();
    getSubMenuApiCall();
    subMenu.clear();
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       backgroundColor: Colors.transparent,
    //       isDismissible: false,
    //       builder: (builder) {
    //         return Container(
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(12.r),
    //                     topRight: Radius.circular(12.r))),
    //             child: SingleChildScrollView(
    //               padding: EdgeInsets.only(
    //                   bottom: MediaQuery.of(context).viewInsets.bottom),
    //               child: Wrap(
    //                 children: [BottomSheetBestDeal()],
    //               ),
    //             ));
    //       });
    // });
  }

  getSubMenuApiCall() async {
    await orderViewModel
        .getSubMenu(
            menuSubCatId: widget.menuSubCatId.toString(),

            ///widget.menuSubCatId.toString(),
            offerId: PreferenceManagerUtils.getOfferId())
        .then((value) {
      if (orderViewModel.subMenuApiResponse.status == Status.COMPLETE) {
        response = orderViewModel.subMenuApiResponse.data;
        log('init response====<>${jsonEncode(response!.data)}');
        response!.data!.forEach((element) {
          element.checkSubMenuItemData!.forEach((element) {
            if (element.type == "Burrito stars") {
              radioSubMenu.addAll({
                "id": element.id,
                "type": element.type,
                "name": element.name,
                "price": element.price.toString(),
              });
            } else if (element.type == "ADD EXTRA/SIDES") {
              subMenu.add({
                "id": element.id,
                "type": element.type,
                "name": element.name,
                "price": element.price.toString(),
              });
              print('submenus---${jsonEncode(subMenu)}');
            } else {}
          });
        });
      }
    });

    ///PreferenceManagerUtils.getOfferId());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<OrderViewModel>(
          builder: (controller) {
            if (controller.subMenuApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.subMenuApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            if (controller.subMenuApiResponse.status == Status.COMPLETE) {
              response = controller.subMenuApiResponse.data;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: white_ffffff,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1017191a),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5),
                          spreadRadius: 0.0,
                        )
                      ],
                    ),
                    child: ToolbarWithTitleSearch("Ads-ons", icon_search)),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 20.h,
                                  bottom: 20.h),
                              child: response == null || response!.data!.isEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SvgPicture.asset(
                                            response!.data![0].type == "veg"
                                                ? icon_veg
                                                : icon_nonveg),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  response!.data![0].name ??
                                                      "N/A",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      color: black_504f58)),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "\u{20B9}${response!.data![0].price ?? ""}",
                                                      style: TextStyle(
                                                        color: grey_77879e,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 12.sp,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        icon_rupee_slim,
                                                        width: 10.w,
                                                        height: 10.h,
                                                        color: green_5cb85c,
                                                      ),
                                                      Text(
                                                          response!.data![0]
                                                                  .discountPrice ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  green_5cb85c,
                                                              fontFamily:
                                                                  fontMavenProProSemiBold,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.right)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                  response!.data![0]
                                                          .description ??
                                                      "",
                                                  style: TextStyle(
                                                      color: grey_5f6d7b,
                                                      fontFamily:
                                                          fontMavenProRegular,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          ),
                                        ),

                                        //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                      ],
                                    ),
                            ),
                          ],
                        ),
                        // Burrito Stars
                        response == null ||
                                response!.data!.isEmpty ||
                                response!.data![0].allSubMenuItemData!.isEmpty
                            ? const SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 15.h),
                                color: bg_fafbfb,
                                width: double.infinity,
                                child: Text("Burrito Stars".toUpperCase(),
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                              ),

                        response == null ||
                                response!.data!.isEmpty ||
                                response!.data![0].allSubMenuItemData!.isEmpty
                            ? const NoDataFound()
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    top: 20.h,
                                    right: 16.w,
                                    left: 16.w,
                                    bottom: 4.h),
                                itemCount: response!
                                    .data![0].allSubMenuItemData!.length,
                                itemBuilder: (context, i) {
                                  final data =
                                      response!.data![0].allSubMenuItemData![i];
                                  if (response!
                                      .data![0].allSubMenuItemData![i].type!
                                      .contains("Burrito stars")) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            // if (subMenu[0]
                                            //     .containsKey(selectedId)) {
                                            //   print('if ma');
                                            //   subMenuItem.id =
                                            //       data.subMenuItemId;
                                            //   subMenuItem.type = data.type;
                                            //   subMenuItem.name = data.name;
                                            //   subMenuItem.price =
                                            //       data.price.toString();
                                            //   subMenu.remove(subMenuItem);
                                            // } else {

                                            radioSubMenu.clear();
                                            radioSubMenu.addAll({
                                              "id": data.subMenuItemId,
                                              "type": data.type,
                                              "name": data.name,
                                              "price": data.price.toString(),
                                            });

                                            // subMenuItem.id = data.subMenuItemId;
                                            // subMenuItem.type = data.type;
                                            // subMenuItem.name = data.name;
                                            // subMenuItem.price =
                                            //     data.price.toString();
                                            // subMenu.add(subMenuItem);
                                            // selectedItemsId =
                                            //     data.subMenuItemId!;

                                            //   {
                                            //     "id": data.subMenuItemId,
                                            // "type": data.type,
                                            // "name": data.name,
                                            // "price": data.price
                                            // }
                                            // }

                                            // selectedDay = (onOfferModel[i].day);
                                            // selectedDay =
                                            //     (onOfferModel[i].time);
                                          },
                                        );
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              // Free Range Poached
                                              Expanded(
                                                flex: 1,
                                                child: Text(data.name ?? "N/A",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProRegular,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 15.sp),
                                                    textAlign: TextAlign.left),
                                              ),
                                              data.price == null
                                                  ? const SizedBox()
                                                  : Image.asset(
                                                      icon_rupee_slim,
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                              data.price == null
                                                  ? const SizedBox()
                                                  : Text(data.price.toString(),
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SvgPicture.asset(
                                                  radioSubMenu.containsValue(
                                                          data.subMenuItemId)
                                                      ? icon_selected_radio
                                                      : icon_unselected_radio),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                }),

                        response == null ||
                                response!.data!.isEmpty ||
                                response!.data![0].allSubMenuItemData!.isEmpty
                            ? const SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 15.h),
                                color: bg_fafbfb,
                                width: double.infinity,
                                child: Text("add extra/sides".toUpperCase(),
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                              ),

                        response == null ||
                                response!.data!.isEmpty ||
                                response!.data![0].allSubMenuItemData!.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    top: 20.w,
                                    right: 16.w,
                                    left: 16.w,
                                    bottom: 4.h),
                                itemCount: response!
                                    .data![0].allSubMenuItemData!.length,
                                itemBuilder: (context, i) {
                                  final data =
                                      response!.data![0].allSubMenuItemData![i];
                                  bool elementExists = false;
                                  String selectedId = "";
                                  if (response!
                                      .data![0].allSubMenuItemData![i].type!
                                      .contains("ADD EXTRA/SIDES")) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            /// api code list
                                            selectedId = response!
                                                .data![0]
                                                .allSubMenuItemData![i]
                                                .subMenuItemId!;

                                            mySelectConsultation = i;
                                            var datas = subMenu
                                                .where((element) =>
                                                    element['id'] == selectedId)
                                                .toList();
                                            print('datas${datas}');

                                            datas.forEach((element) {
                                              elementExists = subMenu.any(
                                                  (map) =>
                                                      map['id'] ==
                                                      element['id']);
                                            });

                                            //  subMenu.forEach((element) {
                                            // element['id']
                                            //
                                            //  });

                                            if (!elementExists) {
                                              subMenu.add({
                                                "id": data.subMenuItemId,
                                                "type": data.type,
                                                "name": data.name,
                                                "price": data.price.toString(),
                                              });
                                            } else {
                                              subMenu.removeWhere((element) =>
                                                  element['id'] ==
                                                  data.subMenuItemId);
                                            }
                                            print(
                                                'selected menu items list==>>${jsonEncode(subMenu)}');
                                          },
                                        );
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(data.name ?? "N/A",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProRegular,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 15.sp),
                                                    textAlign: TextAlign.left),
                                              ),
                                              data.price == null
                                                  ? const SizedBox()
                                                  : Image.asset(
                                                      icon_rupee_slim,
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                              data.price == null
                                                  ? const SizedBox()
                                                  : Text(data.price.toString(),
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SvgPicture.asset(subMenu.indexWhere(
                                                          (element) =>
                                                              element['id'] ==
                                                              data.subMenuItemId) >
                                                      -1
                                                  ? icon_selected_checkbox
                                                  : icon_unselected_checkbox),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                  child: GetBuilder<OrderViewModel>(
                    builder: (controller) {
                      if (controller.addSubMenuItemsApiResponse.status ==
                          Status.LOADING) {
                        return const CircularIndicator();
                      }
                      return CommonRedButton(strContinue.toUpperCase(),
                          () async {
                        reqModel.action = "add_cart_sub_menu_item";
                        reqModel.menuSubCategoryId =
                            widget.menuSubCatId.toString();
                        if (radioSubMenu.isNotEmpty) {
                          subMenu.add(radioSubMenu);
                        }

                        print('subMenu---${subMenu.runtimeType}');
                        reqModel.subMenuItem = subMenu
                            .map((e) => SubMenuItem.fromJson(e))
                            .toList();
                        await orderViewModel.addSubMenuItems(body: reqModel);
                        if (orderViewModel.addSubMenuItemsApiResponse.status ==
                            Status.ERROR) {
                          const ServerError();
                        }
                        if (orderViewModel.addSubMenuItemsApiResponse.status ==
                            Status.COMPLETE) {
                          AddSubMenuItemsResModel response =
                              orderViewModel.addSubMenuItemsApiResponse.data;
                          if (response.status == true) {
                            Get.back();
                          } else {
                            snackBar(title: response.message);
                          }
                        }

                        // reqModel.subMenuIte
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const RedeemOfferDetailPage(),
                        //     ));
                      }, red_dc3642);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
