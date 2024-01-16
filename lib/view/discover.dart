// import 'dart:async';
// import 'dart:ui';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class MapRoom extends StatefulWidget {
//   final String userId;
//
//   MapRoom({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   _MapRoomState createState() => _MapRoomState();
// }
//
// class _MapRoomState extends State<MapRoom> {
//   final _mapKey = GlobalKey<ScaffoldState>();
//   List<Place> clusterUsers = [];
//   List<String> crushMatchTidIds = [];
//   Map<String, dynamic>? filterInfo;
//   DocumentSnapshot? lastDocumentSnapshot;
//   User? currentUser;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(0.seconds, () {
//       init();
//     });
//   }
//
//   init() async {
//     FirebaseService.getUserInfo(widget.userId).then((element) async {
//       currentUser = User.getUser(element.data()!);
//       filterInfo = {
//         'distance': 99999999999999.9,
//         'gender': currentUser!.gender,
//         'interestedIn': currentUser!.interestedIn,
//         'startAge': 18.0,
//         'endAge': 100.0,
//         'startHeight': 0,
//         'endHeight': 245.0
//       };
//       // print("User Id: ${UserController.to.currentUser.id}");
//       print("CURRENT User Id: ${widget.userId}");
//       print(
//           "currentUser!.interestedIn: ${currentUser!.interestedIn} ID=>${currentUser!.id}");
//       await FirebaseService.getUserFilterInfo(widget.userId).then((value) {
//         if (value.exists) {
//           print("EXIST");
//           filterInfo = value.data() as Map<String, dynamic>;
//           filterInfo!['startHeight'] = 0;
//           filterInfo!['distance'] = 99999999999999.9;
//           print('Filter -> ' + filterInfo.toString());
//         }
//         getFilteredUserList();
//       });
//     });
//   }
//
//   void setFilterOptions(Map<String, dynamic> info) {
//     FirebaseService.setUserFilterInfo(widget.userId, info, isDiscover: true);
//     setState(() {
//       isLoading = true;
//     });
//     clusterUsers = [];
//     lastDocumentSnapshot = null;
//     setState(() {
//       filterInfo = info;
//       if (filterInfo!['distance'] == null) {
//         filterInfo!['distance'] = 99999999999999.9;
//       }
//     });
//     getFilteredUserList();
//   }
//
//   void getFilteredUserList() async {
//     crushMatchTidIds =
//         await FirebaseService.getCrushMatchTIDData(widget.userId, true);
//     print('crushMatchTidIds=>${crushMatchTidIds.map((e) => e).toList()}');
//     await FirebaseService.getFilteredDiscoverUserList(
//       gender: UserController.to.currentUser.gender,
//       interestedIn: UserController.to.currentUser.interestedIn,
//       startAge: double.parse(filterInfo!['startAge'].toString()),
//       endAge: double.parse(filterInfo!['endAge'].toString()),
//       docSnap: lastDocumentSnapshot,
//     ).then((QuerySnapshot val) {
//       print('show me users ${val.docs.length}');
//       final con = val.docs.indexWhere(
//           (element) => element.id == "085b73e4-9400-42f2-b16c-221a9c885fc8");
//       print('CON====>$con');
//       if (val.docs.isNotEmpty) {
//         val.docs.forEach((element) {
//           lastDocumentSnapshot = element;
//           User user = User.getUser(element.data() as Map<String, dynamic>);
//           if (!crushMatchTidIds.contains(user.id) &&
//               !UserController.to.blockUserIds.contains(user.id) &&
//               !UserController.to.blockMeUserIds.contains(user.id) &&
//               !user.blockedOtherUsers.contains(currentUser!.id) &&
//               !user.blockedUsers.contains(currentUser!.number) &&
//               !UserController.to.currentUser.blockedOtherUsers
//                   .contains(user.id) &&
//               user.id != widget.userId
//
//               //(user.height == null || (user.height >= filterInfo!['startHeight'] && user.height <= filterInfo!['endHeight'])) &&
//               &&
//               (user.muteChatRequestTime == null ||
//                   (user.muteChatRequestTime <
//                       DateTime.now().millisecondsSinceEpoch)) &&
//               (user.geoPoint != null &&
//                   filterInfo!['distance'] >
//                       (Helper.getDistance(
//                               currentUser!.geoPoint.latitude,
//                               currentUser!.geoPoint.longitude,
//                               user.geoPoint.latitude,
//                               user.geoPoint.longitude) /
//                           5))) {
//             Place item = Place(
//               latLng: LatLng(user.geoPoint.latitude, user.geoPoint.longitude),
//               user: user,
//             );
//             clusterUsers.add(item);
//           }
//           if (clusterUsers.length < 25) {
//             // getFilteredUserList();
//           }
//         });
//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         if (mounted) {
//           setState(() {
//             isLoading = false;
//           });
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print('1692700924549==>${DateTime.fromMillisecondsSinceEpoch(1692700924549)}');
//     return Scaffold(
//       backgroundColor: const Color(0xFF3a0ca3),
//       key: _mapKey,
//       body: isLoading
//           ? Center(
//               child: SpinKitRipple(
//                 color: AppColors.secondaryColor,
//                 size: Get.width * 0.2,
//               ),
//             )
//           : UsersMapView(
//               scaffoldKey: _mapKey,
//               clusterUsers: clusterUsers,
//               currentUser: currentUser!,
//               setFilterOptions: setFilterOptions,
//               filterInfo: filterInfo!,
//             ),
//     );
//   }
// }
//
// class UsersMapView extends StatefulWidget {
//   final List<Place> clusterUsers;
//   final User currentUser;
//   final Function setFilterOptions;
//   final Map<String, dynamic> filterInfo;
//
//   UsersMapView({
//     Key? key,
//     required this.scaffoldKey,
//     required this.clusterUsers,
//     required this.currentUser,
//     required this.setFilterOptions,
//     required this.filterInfo,
//   }) : super(key: key);
//
//   final GlobalKey<ScaffoldState> scaffoldKey;
//
//   @override
//   State<UsersMapView> createState() => UsersMapViewState();
// }
//
// class UsersMapViewState extends State<UsersMapView> {
//   ClusterManager? _manager;
//   PersistentBottomSheetController? _bsController;
//   final Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> markers = Set();
//   List<Place>? clusterUsers;
//   CameraPosition? _cameraPosition;
//   int? bottomSheetSelectedIndex;
//   double lat = 0, lon = 0;
//   RangeValues _ageRangeValues = const RangeValues(0, 0);
//   bool isCm = false;
//
//   @override
//   void didUpdateWidget(covariant UsersMapView oldWidget) {
//     if (clusterUsers != oldWidget.clusterUsers) {
//       setState(() {
//         clusterUsers = widget.clusterUsers;
//         _manager!.setItems(clusterUsers!);
//       });
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void initState() {
//     Timer(
//       const Duration(seconds: 1),
//       () async {
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         bool? isShow = pref.getBool("isDialog") ?? false;
//         if (!isShow || isShow == null) {
//           showInformationDialog(context);
//         }
//       },
//     );
//     setState(() {
//       _ageRangeValues = RangeValues(
//           double.parse(widget.filterInfo['startAge'].toString()),
//           double.parse(widget.filterInfo['endAge'].toString()));
//       clusterUsers = widget.clusterUsers;
//     });
//     _cameraPosition = CameraPosition(
//         target: LatLng(
//           widget.currentUser.geoPoint.latitude,
//           widget.currentUser.geoPoint.longitude,
//         ),
//         zoom: 5.0);
//     _manager = _initClusterManager();
//     super.initState();
//     // _manager.getMarkers();
//   }
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   Future<void> showInformationDialog(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         builder: (context) {
//           bool isChecked = false;
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(Get.width * 0.05),
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               content: Form(
//                 key: _formKey,
//                 child: Container(
//                   width: Get.width,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Center(
//                         child: Text(
//                           'YOU ARE SAFE.',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 18),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Center(
//                         child: Container(
//                           height: 100.h,
//                           width: 140.w,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/noLocation.png'),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       RichText(
//                         text: TextSpan(
//                           text: '${widget.currentUser.name},',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.black,
//                               fontSize: 16),
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: ' learn how we are keeping you safe.',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   color: AppColors.black,
//                                   fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         '1). The locations are approximate (not precise) and aren\'t shared with anyone under all circumstances.',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         '2). Zooming in is restricted to 1 Km to strengthen the location privacy.',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         '3). We have removed every street\'s name, signs and landmarks as an additional measure.',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 24.0,
//                             height: 24.0,
//                             child: Checkbox(
//                                 value: isChecked,
//                                 activeColor: AppColors.primaryColor,
//                                 onChanged: (checked) {
//                                   setState(() {
//                                     isChecked = !isChecked;
//                                   });
//                                 }),
//                           ),
//                           const SizedBox(width: 8),
//                           const Text(
//                             "Don\'t ask me again.",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       AppButton(
//                         content: const Text(
//                           "OKAY",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.white),
//                         ),
//                         bgColor: AppColors.primaryColor,
//                         onPressed: () async {
//                           if (isChecked) {
//                             SharedPreferences pref =
//                                 await SharedPreferences.getInstance();
//                             pref.setBool("isDialog", isChecked);
//                           }
//                           Get.back();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           });
//         });
//   }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   myLocation(GoogleMapController controller) async {
//     await _determinePosition();
//     setState(() {});
//   }
//
//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     print('Step 1');
//     await _determinePosition();
//     print('Step 2');
//     var myLoc = const Marker(
//       markerId: MarkerId('My Location'),
//     );
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: LatLng(lat, lon),
//       zoom: 17.0,
//     )));
//   }
//
//   _determinePosition() async {
//     bool serviceEnabled;
//     // LocationPermission permission;
//     Location location = Location();
//     PermissionStatus permission;
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await location.hasPermission();
//     if (permission == PermissionStatus.denied) {
//       permission = await location.requestPermission();
//       if (permission == PermissionStatus.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == PermissionStatus.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     LocationData locationData = await location.getLocation();
//     setState(() {
//       lat = locationData.latitude!;
//       lon = locationData.longitude!;
//     });
//     print('LATITUDE -> $lat\nLONGITUDE -> $lon');
//   }
//
//   ClusterManager _initClusterManager() {
//     return ClusterManager<Place>(
//       clusterUsers!,
//       _updateMarkers,
//       markerBuilder: _markerBuilder,
//       stopClusteringZoom: 17.0,
//     );
//   }
//
//   void _updateMarkers(Set<Marker> markers) async {
//     setState(() {
//       this.markers = markers;
//     });
//   }
//
//   void applyFilterWhenComigBack(value, {name}) {
//     widget.setFilterOptions(widget.filterInfo);
//     if (value != null) {
//       if (value == 'BUSY') {
//         Helper.showBottomFlash(
//             false, 'Alert', '$name seems to be busy at the moment.');
//       } else {
//         Helper.showBottomFlash(false, 'Alert',
//             'Your chat request has been ${value.toLowerCase()}');
//       }
//     }
//   }
//
//   // custom compass button for google map
//   _compassButton() {
//     _controller.future.then((GoogleMapController controller) async {
//       double zoom = await controller.getZoomLevel();
//       controller.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(bearing: 0, target: LatLng(lat, lon), zoom: zoom)));
//     });
//   }
//
//   GoogleMapController? _googleMapController;
//
//   void _setMapStyle() async {
//     String style = await DefaultAssetBundle.of(context)
//         .loadString('assets/map_style.json');
//     _googleMapController!.setMapStyle(style);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               zoomGesturesEnabled: true,
//               mapToolbarEnabled: true,
//               mapType: MapType.normal,
//               zoomControlsEnabled: false,
//               initialCameraPosition: _cameraPosition!,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               compassEnabled: false,
//               trafficEnabled: false,
//               buildingsEnabled: false,
//               rotateGesturesEnabled: true,
//               markers: markers,
//               minMaxZoomPreference: const MinMaxZoomPreference(1, 15),
//               onTap: (_) {
//                 if (_bsController != null) _bsController!.close();
//               },
//               onMapCreated: (GoogleMapController controller) async {
//                 _googleMapController = controller;
//                 _setMapStyle();
//                 double temp = await controller.getZoomLevel();
//                 print('Zoom Level $temp');
//                 _controller.complete(controller);
//                 _manager!.setMapId(controller.mapId);
//               },
//               onCameraMove: _manager!.onCameraMove,
//               onCameraIdle: _manager!.updateMap,
//             ),
//             // if (clusterUsers == null || clusterUsers!.length == 0)
//             //   Container(
//             //     width: Get.width,
//             //     height: Get.height,
//             //     decoration: BoxDecoration(
//             //       color: AppColors.black.withOpacity(0.3),
//             //     ),
//             //     child: Center(
//             //       child: Container(
//             //         height: 42.h,
//             //         width: 255.w,
//             //         decoration: BoxDecoration(
//             //           color: AppColors.secondaryColor.withOpacity(0.8),
//             //           borderRadius: BorderRadius.circular(5.0),
//             //         ),
//             //         child: Center(
//             //           child: Text(
//             //             'Nobody is online!!!',
//             //             textAlign: TextAlign.center,
//             //             style: Get.textTheme.bodyText2!.copyWith(
//             //               fontSize: 14.sp,
//             //               color: const Color(0xffF61717),
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // Container(
//             //   width: Get.width,
//             //   height: Get.height,
//             //   padding: EdgeInsets.symmetric(
//             //     horizontal: 16.w,
//             //   ),
//             //   child: Column(
//             //     children: [
//             //       SizedBox(
//             //         height: 16.h,
//             //       ),
//             //       Row(
//             //         children: [
//             //           InkWell(
//             //             onTap: () {
//             //               Get.back();
//             //             },
//             //             child: Container(
//             //               height: 42.h,
//             //               width: 42.h,
//             //               padding: EdgeInsets.symmetric(
//             //                 horizontal: 7.w,
//             //               ),
//             //               decoration: BoxDecoration(
//             //                 color: AppColors.white,
//             //                 borderRadius: BorderRadius.circular(8),
//             //                 boxShadow: [
//             //                   BoxShadow(
//             //                     color: AppColors.black.withOpacity(0.1),
//             //                     offset: const Offset(0, 4),
//             //                     blurRadius: 10,
//             //                   ),
//             //                 ],
//             //               ),
//             //               child: Padding(
//             //                 padding: EdgeInsets.symmetric(
//             //                   vertical: 12.w,
//             //                 ),
//             //                 child: Image.asset(
//             //                   'assets/icons/Back_Icon.png',
//             //                   fit: BoxFit.fitWidth,
//             //                   color: AppColors.black,
//             //                 ),
//             //               ),
//             //             ),
//             //           ),
//             //           const Spacer(),
//             //           iconButton(
//             //             image: 'assets/icons/shuffle.png',
//             //             onTap: () {
//             //               Get.off(
//             //                 () => RandomRequestScreen(
//             //                   autoRun: true,
//             //                 ),
//             //               );
//             //             },
//             //           ),
//             //         ],
//             //       ),
//             //       const Spacer(),
//             //       Column(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           Row(
//             //             children: [
//             //               iconButton(
//             //                 image: 'assets/icons/compass.png',
//             //                 onTap: () {
//             //                   _compassButton();
//             //                 },
//             //               ),
//             //               const Spacer(),
//             //               iconButton(
//             //                 image: 'assets/icons/reload.png',
//             //                 onTap: () {
//             //                   widget.setFilterOptions(widget.filterInfo);
//             //                 },
//             //               ),
//             //               const Spacer(),
//             //               iconButton(
//             //                   image: 'assets/icons/my_locate.png',
//             //                   onTap: () async {
//             //                     print('LOCATION');
//             //                     GoogleMapController cont =
//             //                         await _controller.future;
//             //                     _onMapCreated(cont);
//             //                   }),
//             //             ],
//             //           ),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: 60.h,
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // Align(
//             //   alignment: Alignment.bottomCenter,
//             //   child: Container(
//             //     height: 30.h,
//             //     width: Get.width, //* 0.65,
//             //     decoration: BoxDecoration(
//             //       color: AppColors.secondaryColor.withOpacity(0.8),
//             //     ),
//             //     child: Center(
//             //       child: Text(
//             //         'Precise location never shared',
//             //         textAlign: TextAlign.center,
//             //         style: Get.textTheme.bodyText2!.copyWith(
//             //           fontSize: 14.sp,
//             //           color: const Color(0xffF61717),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget iconButton({String? image, Function()? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 42.h,
//         width: 42.h,
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black.withOpacity(0.1),
//               offset: const Offset(0, 4),
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: 10.w,
//           ),
//           child: Image.asset(
//             image!,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
//
//   makeDismissible({required Widget child}) => GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () => Get.back(),
//         child: child,
//       );
//
//   /* showUserSelectBottomSheet2(Cluster<Place> cluster, BuildContext context) {
//     showModalBottomSheet(
//       enableDrag: true,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       context: context,
//       isDismissible: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (context) {
//         return makeDismissible(
//           child: DraggableScrollableSheet(
//               initialChildSize: 0.3,
//               minChildSize: 0.3,
//               maxChildSize: 1,
//               builder: (_, controller) {
//                 return Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                   // height:
//                   //     cluster.items.length < 7 ? Get.height * 0.4 : Get.height * 0.6,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(height: 8.h),
//                       Container(
//                         height: 10.h,
//                         width: 50.w,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffD1D1D1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//                       Column(
//                         children: [
//                           for (int index = 0;
//                               index < cluster.items.length;
//                               index++)
//                             Column(
//                               children: [
//                                 ListTile(
//                                     selected: index == bottomSheetSelectedIndex,
//                                     onTap: () {
//                                       Get.back();
//                                       Future? result =
//                                           Get.to(() => WaitingScreen(
//                                                 otherUser: cluster.items
//                                                     .elementAt(index)
//                                                     .user,
//                                                 type: 'SENDER',
//                                                 callBack:
//                                                     applyFilterWhenComigBack,
//                                               ));
//                                       result!.then((value) {
//                                         applyFilterWhenComigBack(value,
//                                             name: cluster.items
//                                                 .elementAt(index)
//                                                 .user
//                                                 .name);
//                                       });
//                                     },
//                                     leading: Container(
//                                       height: 30.w,
//                                       width: 30.w,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: AppColors.primaryColor
//                                             .withOpacity(0.25),
//                                         image: cluster.items
//                                                     .elementAt(index)
//                                                     .user
//                                                     .imageUrl ==
//                                                 ''
//                                             ? const DecorationImage(
//                                                 image: AssetImage(
//                                                     'assets/logosplash.png'),
//                                               )
//                                             : DecorationImage(
//                                                 image: NetworkImage(
//                                                   cluster.items
//                                                       .elementAt(index)
//                                                       .user
//                                                       .imageUrl,
//                                                 ),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                       ),
//                                     ),
//                                     title: Container(
//                                       padding: const EdgeInsets.only(left: 20),
//                                       child: Text(
//                                         cluster.items
//                                             .elementAt(index)
//                                             .user
//                                             .name,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w800,
//                                         ),
//                                       ),
//                                     ),
//                                     trailing:
//                                         // index == bottomSheetSelectedIndex
//                                         //     ?
//                                         InkWell(
//                                       onTap: () {
//                                         Get.back();
//                                         Future? result =
//                                             Get.to(() => WaitingScreen(
//                                                   otherUser: cluster.items
//                                                       .elementAt(index)
//                                                       .user,
//                                                   type: 'SENDER',
//                                                   callBack:
//                                                       applyFilterWhenComigBack,
//                                                 ));
//                                         result!.then((value) {
//                                           applyFilterWhenComigBack(value,
//                                               name: cluster.items
//                                                   .elementAt(index)
//                                                   .user
//                                                   .name);
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 21.h,
//                                         width: 21.h,
//                                         decoration: const BoxDecoration(
//                                           image: DecorationImage(
//                                             image: AssetImage(
//                                               'assets/icons/send2.png',
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                     // : null,
//                                     ),
//                                 const Divider(
//                                   color: Color(0xfff0f0f0),
//                                   thickness: 1,
//                                   indent: 10,
//                                   endIndent: 10,
//                                 ),
//                               ],
//                             )
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         );
//       },
//     );
//   }*/
//
//   void listenScrollController(
//       ScrollController scrollController, VoidCallback onCallBack) {
//     scrollController.addListener(() {
//       onCallBack();
//     });
//   }
//
//   void listenDragScrollController(VoidCallback onCallBack) {
//     draggableScrollableController.addListener(() {
//       onCallBack();
//     });
//   }
//
//   late DraggableScrollableController draggableScrollableController;
//
//   showUserSelectBottomSheet(Cluster<Place> cluster, BuildContext context) {
//     draggableScrollableController = DraggableScrollableController();
//     RxList<Place> placesList = <Place>[].obs;
//     int maxItemCount = 50;
//     bool isLoading = false;
//
//     if (cluster.items.toList().length > maxItemCount) {
//       placesList.addAll(cluster.items.take(maxItemCount));
//     } else {
//       placesList.value = cluster.items.toList();
//     }
//     print('placesList=>${placesList.length}');
//     showModalBottomSheet(
//       enableDrag: true,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       context: context,
//       isDismissible: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext buildContext) {
//         return makeDismissible(
//           child: DraggableScrollableSheet(
//             initialChildSize: 0.3,
//             minChildSize: 0.3,
//             maxChildSize: 1,
//             controller: draggableScrollableController,
//             builder: (_, controller) {
//               if (placesList.length != cluster.items.length) {
//                 listenDragScrollController(
//                   () {
//                     print(
//                         'isLoading:=>$isLoading placesList=>${placesList.length}  cluster.items.length:=>${cluster.items.length}');
//                     if (placesList.length != cluster.items.length &&
//                         !isLoading) {
//                       isLoading = true;
//                       final remainingItemCount =
//                           cluster.items.length - placesList.length;
//                       print('remainingItemCount=>$remainingItemCount');
//
//                       placesList.addAll(cluster.items
//                           .skip(placesList.length)
//                           .take(remainingItemCount > maxItemCount
//                               ? maxItemCount
//                               : remainingItemCount)
//                           .toList());
//                       Future.delayed(
//                         1.5.seconds,
//                         () {
//                           isLoading = false;
//                         },
//                       );
//                     }
//                   },
//                 );
//                 listenScrollController(
//                   controller,
//                   () {
//                     print(
//                         'onCallBack============ ${placesList.length} CLU LENGTH=>${cluster.items.length}');
//                     if (placesList.length != cluster.items.length &&
//                         !isLoading) {
//                       isLoading = true;
//                       final remainingItemCount =
//                           cluster.items.length - placesList.length;
//                       print('remainingItemCount=>$remainingItemCount');
//
//                       placesList.addAll(cluster.items
//                           .skip(placesList.length)
//                           .take(remainingItemCount > maxItemCount
//                               ? maxItemCount
//                               : remainingItemCount)
//                           .toList());
//                       Future.delayed(
//                         1.5.seconds,
//                         () {
//                           isLoading = false;
//                         },
//                       );
//                     }
//                   },
//                 );
//               }
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 child: ListView(
//                   controller: controller,
//                   children: [
//                     SizedBox(height: 20.h),
//                     Center(
//                       child: Container(
//                         height: 8.h,
//                         width: 50.w,
//                         decoration: BoxDecoration(
//                           color: const Color(0xffD1D1D1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Obx(
//                       () => Padding(
//                         padding: EdgeInsets.only(
//                             left: 20.w, right: 20.w, bottom: 30.w),
//                         child: GridView.count(
//                           key: ValueKey(placesList.length),
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           crossAxisCount: 5,
//                           childAspectRatio: 1,
//                           crossAxisSpacing: 25,
//                           mainAxisSpacing: 25,
//                           children: List.generate(placesList.length,
//                               // cluster.items.length,
//                               (i) {
//                             // final item = cluster.items.toList()[i];
//                             final item = placesList[i];
//                             return InkWell(
//                               onTap: () {
//                                 Get.back();
//                                 Future? result = Get.to(() => WaitingScreen(
//                                       otherUser: item.user,
//                                       type: 'SENDER',
//                                       callBack: applyFilterWhenComigBack,
//                                     ));
//                                 result!.then((value) {
//                                   applyFilterWhenComigBack(value,
//                                       name: item.user.name);
//                                 });
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: AppColors.primaryColor
//                                         .withOpacity(0.25),
//                                   ),
//                                   child: item.user.imageUrl == ''
//                                       ? const Image(
//                                           image: AssetImage(
//                                               "assets/logosplash.png"))
//                                       : CachedNetworkImage(
//                                           imageUrl: item.user.imageUrl,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               Container(
//                                             color: Colors.black,
//                                             child: Center(
//                                               child: CircularProgressIndicator(
//                                                 strokeWidth: 3,
//                                                 color: AppColors.primaryColor,
//                                                 //backgroundColor: AppColors.secondaryColor,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
//       (cluster) async {
//         return Marker(
//           markerId: MarkerId(cluster.getId()),
//           position: cluster.location,
//           onTap: () {
//             bottomSheetSelectedIndex = null;
//             showUserSelectBottomSheet(
//                 cluster, widget.scaffoldKey.currentContext!);
//           },
//           icon: await _getMarkerBitmap(cluster.isMultiple ? 80 : 60,
//               text: cluster.isMultiple ? cluster.count.toString() : ''),
//         );
//       };
//
//   Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
//     assert(size != null);
//     final PictureRecorder pictureRecorder = PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint1 = Paint()
//       ..color = AppColors.primaryColor.withOpacity(0.8);
//     final Paint paint2 = Paint()..color = Colors.white;
//     // canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint)
//     canvas.drawRRect(
//         RRect.fromRectAndCorners(
//             Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
//             bottomRight: Radius.circular(size * 0.1714286),
//             bottomLeft: Radius.circular(size * 0.1714286),
//             topLeft: Radius.circular(size * 0.1714286),
//             topRight: Radius.circular(size * 0.1714286)),
//         paint1);
//
//     if (text != null) {
//       TextPainter painter = TextPainter(textDirection: TextDirection.rtl);
//       painter.text = TextSpan(
//         text: text.length <= 3 ? text : "${text.length - 3}k",
//         style: TextStyle(
//             fontSize: /*text.length==1?*/
//                 size / 2.5 /*:text.length==2?size / 3.0:size / 3.5*/,
//             color: Colors.white,
//             fontWeight: FontWeight.normal),
//       );
//       painter.layout();
//       painter.paint(
//         canvas,
//         Offset(
//             text.length == 1
//                 ? size / 2.5
//                 : text.length == 2
//                     ? size / 3.5
//                     : text.length == 3
//                         ? size / 6.2
//                         : size / 3.5,
//             size /
//                 4 /*text.length == 1
//                 ? size / 4
//                 : text.length == 2
//                     ? size / 4
//                     : text.length == 3
//                         ? size / 4
//                         : size / 4*/
//             ),
//       );
//     }
//     final img = await pictureRecorder.endRecording().toImage(size, size);
//     final data = await img.toByteData(format: ImageByteFormat.png);
//     return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
//   }
// }
//
// class Place with ClusterItem {
//   final User user;
//   final LatLng latLng;
//
//   Place({required this.user, required this.latLng});
//
//   @override
//   LatLng get location => latLng;
// }
