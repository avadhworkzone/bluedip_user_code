import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_menu_item.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/RedeemAdsOns.dart';
import 'package:bluedip_user/view/RedeemOfferDetailPage.dart';
import 'package:bluedip_user/view/order/RedeemOffer.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Widget/toolbar_with_search.dart';
import '../../utils/shared_preference_utils.dart';

class DineInMenuItems extends StatefulWidget {
  const DineInMenuItems({Key? key}) : super(key: key);

  @override
  State<DineInMenuItems> createState() => _DineInMenuItemsState();
}

class _DineInMenuItemsState extends State<DineInMenuItems> {
  OrderViewModel orderViewModel = Get.find();
  GetOrderMenuItemsResModel? response;
  double? subTotal;
  // final List<League> data = <League>[
  //   League(
  //     'Starters',
  //     <Club>[
  //       Club(icon_veg, "Bloddy Mary", 0),
  //       Club(icon_nonveg, "Chicken Tikka", 0),
  //     ],
  //   ),
  //   League(
  //     'Burrito Stars',
  //     <Club>[
  //       Club(icon_veg, "Bloddy Mary", 0),
  //       Club(icon_nonveg, "Chicken Tikka", 0),
  //     ],
  //   ),
  //   League(
  //     'Main Course',
  //     <Club>[
  //       Club(icon_veg, "Bloddy Mary", 0),
  //       Club(icon_nonveg, "Chicken Tikka", 0),
  //     ],
  //   ),
  //   League(
  //     'Fast Food',
  //     <Club>[
  //       Club(icon_veg, "Bloddy Mary", 0),
  //       Club(icon_nonveg, "Chicken Tikka", 0),
  //     ],
  //   ),
  // ];

  bool isNextRedLayout = false;
  double allProductPriceTotal = 0;

  @override
  void initState() {
    orderViewModel.addToCartLocalData.clear();
    getMenuListApiCall();
    // TODO: implement initState
    super.initState();
  }

  // List<Map<String, dynamic>> menu = [];

  getMenuListApiCall() async {
    await orderViewModel.orderMenuItems(
        restoId: PreferenceManagerUtils.getRestoId(),

        ///PreferenceManagerUtils.getRestoId(),

        ///PreferenceManagerUtils.getOfferId()
        offerId: PreferenceManagerUtils.getOfferId());
    //   .then((value) {
    // if (orderViewModel.orderMenuApiResponse.status == Status.COMPLETE) {
    //   response = orderViewModel.orderMenuApiResponse.data;
    // if (response != null ||
    //     response!.data != null ||
    //     response!.data!.isNotEmpty) {
    //   response!.data!.forEach((element) {
    //     if (element.menuSubCategoryData!.isEmpty) {
    //       orderViewModel.menu.addAll([
    //         {"menu": [], "mainItem": element.name}
    //       ]);
    //     } else {
    //       orderViewModel.menu.addAll([
    //         {
    //           "menu": [
    //             for (var i = 0;
    //             i < element.menuSubCategoryData!.length;
    //             i++)
    //               {
    //                 "itemName": element.menuSubCategoryData![i].name,
    //                 "id": element.menuSubCategoryData![i].menuSubCategoryId,
    //                 "qty": element.menuSubCategoryData![i].cartData == null
    //                     ? 0
    //                     : element.menuSubCategoryData![i].cartData!
    //                     .quantity ??
    //                     0,
    //                 "price": element.menuSubCategoryData![i].discountPrice,
    //               }
    //           ],
    //           "mainItem": element.name
    //         }
    //       ]);
    //     }
    //   });
    //   orderViewModel.addToCartLocalData.addAll({
    //     "data": orderViewModel.menu,
    //     "TotalItems": response!.items ?? 0
    //   });
    //   print('data---....${orderViewModel.addToCartLocalData}');
    //   // orderViewModel.addToCartLocalData['data']!.forEach((element) {
    //   //   if (element['menu'] != []) {
    //   //     allProductPriceTotal =
    //   //         element['menu'].reduce((p, e) => p + (e["price"] * e["qty"]));
    //   //   }
    //   // });
    //
    //   // count();
    // }
    // }
    // });

    ///PreferenceManagerUtils.getOfferId());
  }

  // double count() {
  //   double allProductPriceTotal = 0;
  //   print(
  //       'addToCartLocalData list--->>>${orderViewModel.addToCartLocalData['data']![0]['menu']}');
  //   orderViewModel.addToCartLocalData['data']!.forEach((element) {
  //   allProductPriceTotal =
  //       (orderViewModel.addToCartLocalData['data']![0]['menu'] as List)
  //           .reduce((p, e) => p + (e["price"] * e["qty"]));
  //   });
  //   return allProductPriceTotal;
  // }

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
        backgroundColor: white_ffffff,
        body: GetBuilder<OrderViewModel>(
          builder: (controller) {
            if (controller.orderMenuApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.orderMenuApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            if (controller.orderMenuApiResponse.status == Status.COMPLETE) {
              response = controller.orderMenuApiResponse.data;
            }
            return response == null
                ? const Center(child: NoDataFound())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                  // Get.offAll(() => RedeemOffer(
                                  //       offerId: int.parse(
                                  //           PreferenceManagerUtils
                                  //               .getOfferId()),
                                  //     ));
                                },
                                child: Container(
                                    width: 40.w,
                                    height: 40.w,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SvgPicture.asset(icon_arrow_left),
                                    ))),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                response!.restaurantName ?? "",
                                style: TextStyle(
                                    fontFamily: fontOverpassBold,
                                    color: black_504f58,
                                    fontSize: 20.sp),
                              ),
                            ),
                            SvgPicture.asset(
                              icon_search,
                              color: grey_5f6d7b,
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 15.w,
                            )
                          ],
                        ),
                      ),
                      // ToolbarWithTitleSearch(
                      //     response!.restaurantName ?? "", icon_search),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: divider_d4dce7,
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              response == null ||
                                      response!.data == null ||
                                      response!.data!.isEmpty
                                  ? const NoDataFound()
                                  : ListView.builder(
                                      itemCount: response!.data!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0.r),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = response!.data![index];
                                        return Column(
                                          children: [
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: ExpansionTile(
                                                  iconColor: grey_969da8,
                                                  trailing: response!.data![index].menuSubCategoryData ==
                                                              [] ||
                                                          response!
                                                              .data![index]
                                                              .menuSubCategoryData!
                                                              .isEmpty
                                                      ? const SizedBox()
                                                      : const Icon(Icons
                                                          .keyboard_arrow_up_outlined),
                                                  collapsedIconColor:
                                                      grey_969da8,
                                                  // key: PageStorageKey<League>(widget.league),
                                                  tilePadding: EdgeInsets.symmetric(
                                                      horizontal: 16.w),
                                                  title: Text(data.name!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              fontOverpassBold,
                                                          color: black_504f58)),
                                                  children:
                                                      response!.data![index]
                                                                      .menuSubCategoryData ==
                                                                  [] ||
                                                              response!
                                                                  .data![index]
                                                                  .menuSubCategoryData!
                                                                  .isEmpty
                                                          ? []
                                                          : List.generate(
                                                              response!
                                                                  .data![index]
                                                                  .menuSubCategoryData!
                                                                  .length, (i) {
                                                              final club = response!
                                                                  .data![index]
                                                                  .menuSubCategoryData![i];

                                                              return Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Text(length.toString()),
                                                                  // Row(
                                                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //   mainAxisSize: MainAxisSize.max,
                                                                  //   children: [
                                                                  //     Text("onOfferModel[i].tvTitle", style: TextStyle(fontSize: 14.sp, fontFamily: sf_pro_display_semibold, color:black_1d1929)),
                                                                  //     SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                                  //   ],
                                                                  // ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RedeemAdsOns(menuSubCatId: club.menuSubCategoryId!),
                                                                          ));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              16.w),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              SvgPicture.asset(club.type == "veg" ? icon_veg : icon_nonveg),
                                                                              SizedBox(
                                                                                width: 10.w,
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(club.name!, style: TextStyle(fontSize: 14.sp, fontFamily: fontMavenProMedium, color: black_504f58)),
                                                                                    SizedBox(
                                                                                      height: 4.h,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text("\u{20B9}${club.price.toString()}",
                                                                                            style: TextStyle(
                                                                                              color: grey_77879e,
                                                                                              fontFamily: fontMavenProMedium,
                                                                                              fontSize: 12.sp,
                                                                                              decoration: TextDecoration.lineThrough,
                                                                                            ),
                                                                                            textAlign: TextAlign.right),
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
                                                                                            Text("${club.price}", style: TextStyle(color: green_5cb85c, fontFamily: fontMavenProProSemiBold, fontSize: 15.sp), textAlign: TextAlign.right)
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 8.h,
                                                                                    ),
                                                                                    Text(club.description!, style: TextStyle(color: grey_5f6d7b, fontFamily: fontMavenProRegular, fontSize: 12.sp), textAlign: TextAlign.left),
                                                                                    SizedBox(
                                                                                      height: 16.h,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // club.cartData == null ||
                                                                              // orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] <= 0
                                                                              //     ? InkWell(
                                                                              //         onTap: () async {
                                                                              //           orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] += 1;
                                                                              //
                                                                              //           await orderViewModel.addToCart(subCategoryId: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['id'], qty: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty']);
                                                                              //
                                                                              //           setState(() {});
                                                                              //         },
                                                                              //         child: Container(
                                                                              //           width: 100,
                                                                              //           height: 36,
                                                                              //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(width: 1, color: red_dc3642)),
                                                                              //           child: Center(
                                                                              //             child: Text("ADD", style: TextStyle(color: red_dc3642, fontWeight: FontWeight.w600, fontFamily: fontMavenProProSemiBold, fontStyle: FontStyle.normal, fontSize: 15.sp), textAlign: TextAlign.center),
                                                                              //           ),
                                                                              //         ),
                                                                              //       )
                                                                              //     : SizedBox(
                                                                              //         width: 100.w,
                                                                              //         child: Stack(
                                                                              //           alignment: Alignment.topRight,
                                                                              //           children: [
                                                                              //             Container(
                                                                              //               width: 100,
                                                                              //               height: 36,
                                                                              //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: Color(0x11dc3642), border: Border.all(width: 1, color: red_dc3642)),
                                                                              //               // margin: EdgeInsets.only(left: 8,right: 8,top: 0),
                                                                              //               child: Row(
                                                                              //                 mainAxisAlignment: MainAxisAlignment.start,
                                                                              //                 mainAxisSize: MainAxisSize.max,
                                                                              //                 children: [
                                                                              //                   SizedBox(
                                                                              //                     width: 8.w,
                                                                              //                   ),
                                                                              //                   InkWell(
                                                                              //                     onTap: () async {
                                                                              //                       if (orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] == 0) {
                                                                              //                         orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] = 0;
                                                                              //                       } else {
                                                                              //                         orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] -= 1;
                                                                              //
                                                                              //                         // subTotal = orderViewModel.addToCartLocalData['data']![index]['menu'].fold(0, (total, current) => total + current.price);
                                                                              //                         // double allProductPriceTotal = 0;
                                                                              //
                                                                              //                         // allProductPriceTotal = orderViewModel.addToCartLocalData['data']![index]['menu'].fold(0, (p, e) => p + (double.parse(e["price"]) * e["qty"]));
                                                                              //                         // print('--SubTotal--${subTotal}');
                                                                              //                       }
                                                                              //                       await orderViewModel.addToCart(subCategoryId: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['id'], qty: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty']);
                                                                              //                     },
                                                                              //                     child: SvgPicture.asset(icon_minus_red),
                                                                              //                   ),
                                                                              //                   Expanded(
                                                                              //                     flex: 1,
                                                                              //                     child: Center(
                                                                              //                       child: Text(
                                                                              //                         '${orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty']}',
                                                                              //                         style: TextStyle(color: black_504f58, fontFamily: fontMavenProProSemiBold, fontSize: 15.sp),
                                                                              //                       ),
                                                                              //                     ),
                                                                              //                   ),
                                                                              //                   InkWell(
                                                                              //                     onTap: () async {
                                                                              //                       orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty'] += 1;
                                                                              //                       orderViewModel.addToCartLocalData["TotalItems"] = 1;
                                                                              //                       await orderViewModel.addToCart(subCategoryId: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['id'], qty: orderViewModel.addToCartLocalData['data']![index]['menu']![i]['qty']);
                                                                              //                     },
                                                                              //                     child: SvgPicture.asset(icon_add_red),
                                                                              //                   ),
                                                                              //                   SizedBox(
                                                                              //                     width: 8.w,
                                                                              //                   ),
                                                                              //                 ],
                                                                              //               ),
                                                                              //             ),
                                                                              //           ],
                                                                              //         ),
                                                                              //       ),

                                                                              //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                                            ],
                                                                          ),
                                                                          response!.data![index].menuSubCategoryData!.length > 1
                                                                              ? Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(left: 26.w),
                                                                                      child: const DottedLine(
                                                                                        direction: Axis.horizontal,
                                                                                        lineLength: double.infinity,
                                                                                        lineThickness: 1.0,
                                                                                        dashLength: 4.0,
                                                                                        dashColor: divider_d4dce7,
                                                                                        dashRadius: 0.0,
                                                                                        dashGapLength: 4.0,
                                                                                        dashGapColor: Colors.transparent,
                                                                                        dashGapRadius: 0.0,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 16.h,
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : SizedBox()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // ListView.builder(
                                                                  //   scrollDirection: Axis.vertical,
                                                                  //   shrinkWrap: true,
                                                                  //   itemCount: onOfferModel.length,
                                                                  //   itemBuilder: (context, i) =>  Row(
                                                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //     mainAxisSize: MainAxisSize.max,
                                                                  //     children: [
                                                                  //       Text(onOfferModel[i].tvTitle, style: TextStyle(fontSize: 14.sp, fontFamily: sf_pro_display_semibold, color:black_1d1929)),
                                                                  //       SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                                  //     ],
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              );
                                                            })
                                                  // response!.data![index]
                                                  //         .menuSubCategoryData!
                                                  //         .map<Widget>((club) =>)
                                                  //         .toList(),
                                                  ),
                                            ),
                                            const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: divider_d4dce7,
                                            ),
                                          ],
                                        );
                                      },
                                      // MyExpandableWidget(res: response!.data![index]),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      // Stack(
                      //   children: [
                      //     // Showing 30% off deal applied
                      //     orderViewModel.qtyCount() > 0
                      //         ? Container(
                      //             padding: EdgeInsets.only(
                      //                 right: 16.w, top: 11.h, bottom: 11.h),
                      //             color: red_dc3642,
                      //             width: double.infinity,
                      //             child: Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.center,
                      //                     children: [
                      //                       // ₹15.53
                      //                       Text("${orderViewModel.qtyCount()}",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProProSemiBold,
                      //                               fontSize: 15.sp),
                      //                           textAlign: TextAlign.center),
                      //                       SizedBox(
                      //                         height: 2.h,
                      //                       ),
                      //                       Text("Items",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProMedium,
                      //                               fontSize: 14.sp),
                      //                           textAlign: TextAlign.center)
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   height: 35.h,
                      //                   width: 1,
                      //                   color: white_ffffff,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.center,
                      //                     children: [
                      //                       // ₹15.53
                      //                       Text(
                      //                           "₹${orderViewModel.priceCount()}",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProProSemiBold,
                      //                               fontSize: 15.sp),
                      //                           textAlign: TextAlign.center),
                      //                       SizedBox(
                      //                         height: 2.h,
                      //                       ),
                      //                       Text("Total",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProMedium,
                      //                               fontSize: 14.sp),
                      //                           textAlign: TextAlign.center)
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   height: 35.h,
                      //                   width: 1,
                      //                   color: white_ffffff,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.center,
                      //                     children: [
                      //                       // ₹15.53
                      //                       Text("₹${response!.saving}",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProProSemiBold,
                      //                               fontSize: 15.sp),
                      //                           textAlign: TextAlign.center),
                      //                       SizedBox(
                      //                         height: 2.h,
                      //                       ),
                      //                       Text("Savings",
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontFamily:
                      //                                   fontMavenProMedium,
                      //                               fontSize: 14.sp),
                      //                           textAlign: TextAlign.center)
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 20.h,
                      //                 ),
                      //                 GestureDetector(
                      //                   onTap: () {
                      //                     Get.to(RedeemOfferDetailPage(
                      //                       restoName:
                      //                           response!.restaurantName ?? "",
                      //                     ));
                      //                   },
                      //                   child: Container(
                      //                     decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(14.r),
                      //                         color: Colors.white),
                      //                     padding: EdgeInsets.symmetric(
                      //                         horizontal: 35.w, vertical: 15.h),
                      //                     child: // button
                      //                         Text("Next",
                      //                             style: TextStyle(
                      //                                 color: red_dc3642,
                      //                                 fontFamily:
                      //                                     fontMavenProMedium,
                      //                                 fontSize: 15.sp),
                      //                             textAlign: TextAlign.center),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           )
                      //         : Container(
                      //             padding: EdgeInsets.all(14.r),
                      //             color: green_5cb85c,
                      //             width: double.infinity,
                      //             child: Text(
                      //                 "Showing ${response!.offerPercentage ?? 0} off deal applied",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontFamily: fontMavenProRegular,
                      //                     fontSize: 14.sp),
                      //                 textAlign: TextAlign.center),
                      //           )
                      //   ],
                      // )
                    ],
                  );
          },
        ),
      ),
    );
  }

//   showClubs(Club club) {
//     print("veru" + length.toString());
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(length.toString()),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //   mainAxisSize: MainAxisSize.max,
//         //   children: [
//         //     Text("onOfferModel[i].tvTitle", style: TextStyle(fontSize: 14.sp, fontFamily: sf_pro_display_semibold, color:black_1d1929)),
//         //     SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
//         //   ],
//         // ),
//         GestureDetector(
//           onTap: () {},
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     SvgPicture.asset(club.icon),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(club.tvLable,
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontFamily: fontMavenProMedium,
//                                   color: black_504f58)),
//                           SizedBox(
//                             height: 4.h,
//                           ),
//                           Row(
//                             children: [
//                               Text("\u{20B9}300",
//                                   style: TextStyle(
//                                     color: grey_77879e,
//                                     fontFamily: fontMavenProMedium,
//                                     fontSize: 12.sp,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                   textAlign: TextAlign.right),
//                               SizedBox(
//                                 width: 8.w,
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     icon_rupee_slim,
//                                     width: 10.w,
//                                     height: 10.h,
//                                     color: green_5cb85c,
//                                   ),
//                                   Text("250",
//                                       style: TextStyle(
//                                           color: green_5cb85c,
//                                           fontFamily: fontMavenProProSemiBold,
//                                           fontSize: 15.sp),
//                                       textAlign: TextAlign.right)
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 8.h,
//                           ),
//                           Text("Crunchy corn chips topped ",
//                               style: TextStyle(
//                                   color: grey_5f6d7b,
//                                   fontFamily: fontMavenProRegular,
//                                   fontSize: 12.sp),
//                               textAlign: TextAlign.left),
//                           SizedBox(
//                             height: 16.h,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100.w,
//                       child: Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   club.count = club.count + 1;
//                                 });
//                               },
//                               child: Visibility(
//                                 visible: club.count <= 0,
//                                 child: Container(
//                                   width: 100,
//                                   height: 36,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5.r),
//                                       border: Border.all(
//                                           width: 1, color: red_dc3642)),
//                                   child: // Frame 34532
// // ADD
//                                       Center(
//                                     child: Text("ADD",
//                                         style: TextStyle(
//                                             color: red_dc3642,
//                                             fontWeight: FontWeight.w600,
//                                             fontFamily: fontMavenProProSemiBold,
//                                             fontStyle: FontStyle.normal,
//                                             fontSize: 15.sp),
//                                         textAlign: TextAlign.center),
//                                   ),
//                                 ),
//                               )),
//                           Visibility(
//                             visible: club.count > 0,
//                             child: Container(
//                               width: 100,
//                               height: 36,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5.r),
//                                   color: Color(0x11dc3642),
//                                   border:
//                                       Border.all(width: 1, color: red_dc3642)),
//                               // margin: EdgeInsets.only(left: 8,right: 8,top: 0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   SizedBox(
//                                     width: 8.w,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         club.count--;
//                                         if (club.count < 1) {}
//                                       });
//                                     },
//                                     child: SvgPicture.asset(icon_minus_red),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Center(
//                                       child: Text(
//                                         club.count.toString(),
//                                         style: TextStyle(
//                                             color: black_504f58,
//                                             fontFamily: fontMavenProProSemiBold,
//                                             fontSize: 15.sp),
//                                       ),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         club.count++;
//                                       });
//                                     },
//                                     child: SvgPicture.asset(icon_add_red),
//                                   ),
//                                   SizedBox(
//                                     width: 8.w,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 26.w),
//                       child: const DottedLine(
//                         direction: Axis.horizontal,
//                         lineLength: double.infinity,
//                         lineThickness: 1.0,
//                         dashLength: 4.0,
//                         dashColor: divider_d4dce7,
//                         dashRadius: 0.0,
//                         dashGapLength: 4.0,
//                         dashGapColor: Colors.transparent,
//                         dashGapRadius: 0.0,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16.h,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//
//         // ListView.builder(
//         //   scrollDirection: Axis.vertical,
//         //   shrinkWrap: true,
//         //   itemCount: onOfferModel.length,
//         //   itemBuilder: (context, i) =>  Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     mainAxisSize: MainAxisSize.max,
//         //     children: [
//         //       Text(onOfferModel[i].tvTitle, style: TextStyle(fontSize: 14.sp, fontFamily: sf_pro_display_semibold, color:black_1d1929)),
//         //       SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
//         //     ],
//         //   ),
//         // )
//       ],
//     );
//   }
}

// class MyExpandableWidget extends StatefulWidget {
//   var res;
//
//   MyExpandableWidget({Key? key, required this.res}) : super(key: key);
//
//   @override
//   State<MyExpandableWidget> createState() => _MyExpandableWidget();
// }
//
// class _MyExpandableWidget extends State<MyExpandableWidget> {
//   bool isCounter = false;
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.res.) {
//       return Column(
//         children: [
//           ListTile(
//             title: Text(widget.league.TvTitle,
//                 style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: fontOverpassBold,
//                     color: black_504f58)),
//           ),
//         ],
//       );
//     }
//     return Column(
//       children: [
//         Theme(
//           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//           child: ExpansionTile(
//             iconColor: grey_969da8,
//             collapsedIconColor: grey_969da8,
//             key: PageStorageKey<League>(widget.league),
//             tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
//             title: Text(widget.league.TvTitle,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: fontOverpassBold,
//                     color: black_504f58)),
//             children: widget.league.listClubs
//                 .map<Widget>(
//                     (club) => showClubs(club, widget.league.listClubs.length))
//                 .toList(),
//           ),
//         ),
//         Divider(
//           height: 1,
//           thickness: 1,
//           color: divider_d4dce7,
//         ),
//       ],
//     );
//   }
//
//
// }

class League {
  String TvTitle;
  List<Club> listClubs;
  League(this.TvTitle, this.listClubs);
}

class Club {
  int count;
  String icon;
  String tvLable;

  Club(this.icon, this.tvLable, this.count);
}
