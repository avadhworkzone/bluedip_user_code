import 'dart:async';
import 'dart:io';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_post_req_model.dart'
    as reqModel;
import 'package:bluedip_user/modal/apiModel/response_modal/add_post_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_preview_res_model.dart';
// import 'package:bluedip_user/modal/apiModel/response_modal/view_post_detail_res_model.dart';
import 'package:bluedip_user/utils/Utility.dart';
import 'package:bluedip_user/view/food_buddy/OwnPostDetail.dart';
import 'package:bluedip_user/viewModel/food_buddy_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/upload_profile_pic_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/validation_utils.dart';
import 'package:bluedip_user/viewModel/upload_image_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../modal/apiModel/request_modal/upload_profile_req_model.dart';
import '../../modal/apiModel/response_modal/view_post_detail_res_model.dart';
import 'CreatePostPreivew.dart';
import '../SelecLocationCreatePost.dart';
import '../../Widget/common_red_button.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key, this.postId, this.isPreviewEdit}) : super(key: key);
  int? postId;
  bool? isPreviewEdit;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String selectDate = "";
  File? selectedImage;

  final _titleController = TextEditingController();
  UploadImageViewModel uploadImageViewModel = Get.find();
  reqModel.AddPostReqModel addPostReqModel = reqModel.AddPostReqModel();
  UploadProfilePicReqModel uploadProfilePicReqModel =
      UploadProfilePicReqModel();
  FoodBuddyViewModel foodBuddyViewModel = Get.find();
  bool isAnyIcon = false;
  bool isAny = false;
  bool isMaleIcon = false;
  bool isMale = false;
  bool isFemaleIcon = false;
  bool isFemale = false;
  bool isBoth = false;
  bool isVeg = false;
  bool isNonVeg = false;
  final _descController = TextEditingController();
  DateTime? from_date;
  String? apiImage;
  ViewPostDetailResModel? viewPostDetailRes;
  ViewPostPreviewResModel? viewPreviewRes;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  ImagePicker picker = ImagePicker();
  XFile? image;
  getPostDetail() async {
    await foodBuddyViewModel
        .viewPostDetailViewModel(postId: widget.postId!)
        .then((value) {
      if (foodBuddyViewModel.viewPostDetailApiResponse.status ==
          Status.COMPLETE) {
        viewPostDetailRes = foodBuddyViewModel.viewPostDetailApiResponse.data;
        if (viewPostDetailRes != null) {
          apiImage = viewPostDetailRes!.data!.postImg ?? "";
          _titleController.text = viewPostDetailRes!.data!.postTitle ?? "";
          _descController.text = viewPostDetailRes!.data!.description ?? "";
          Utility.address = viewPostDetailRes!.data!.location == null
              ? ""
              : viewPostDetailRes!.data!.location!.address ?? "";
          if (viewPostDetailRes!.data!.date == null ||
              viewPostDetailRes!.data!.date == "") {
          } else {
            String dateString = viewPostDetailRes!.data!.date!;
            List<String> dateParts = dateString.split('-');
            String formattedDateString =
                "${dateParts[0]}-${dateParts[1].padLeft(2, '0')}-${dateParts[2].padLeft(2, '0')}";
            from_date = DateTime.parse(formattedDateString);
          }

          viewPostDetailRes!.data!.preferredGender == 'ANY'
              ? isAny = true
              : viewPostDetailRes!.data!.preferredGender == 'MALE'
                  ? isMale = true
                  : isFemale = true;
          viewPostDetailRes!.data!.preferredFood == 'BOTH'
              ? isBoth = true
              : viewPostDetailRes!.data!.preferredFood == 'VEG'
                  ? isVeg = true
                  : isNonVeg = true;
        }
      }
    });
  }

  getPostPreview() async {
    await foodBuddyViewModel
        .viewPostPreviewViewModel(postId: widget.postId!)
        .then((value) {
      if (foodBuddyViewModel.viewPostPreviewApiResponse.status ==
          Status.COMPLETE) {
        viewPreviewRes = foodBuddyViewModel.viewPostPreviewApiResponse.data;
        if (viewPreviewRes != null) {
          apiImage = viewPreviewRes!.data!.postImg ?? "";
          _titleController.text = viewPreviewRes!.data!.postTitle ?? "";
          _descController.text = viewPreviewRes!.data!.description ?? "";
          Utility.address = viewPreviewRes!.data!.location == null
              ? ""
              : viewPreviewRes!.data!.location!.address ?? "";
          if (viewPreviewRes!.data!.date == null ||
              viewPreviewRes!.data!.date == "") {
          } else {
            String dateString = viewPreviewRes!.data!.date!;
            List<String> dateParts = dateString.split('-');
            String formattedDateString =
                "${dateParts[0]}-${dateParts[1].padLeft(2, '0')}-${dateParts[2].padLeft(2, '0')}";
            from_date = DateTime.parse(formattedDateString);
          }

          viewPreviewRes!.data!.preferredGender == 'ANY'
              ? isAny = true
              : viewPreviewRes!.data!.preferredGender == 'MALE'
                  ? isMale = true
                  : isFemale = true;
          viewPreviewRes!.data!.preferredFood == 'BOTH'
              ? isBoth = true
              : viewPreviewRes!.data!.preferredFood == 'VEG'
                  ? isVeg = true
                  : isNonVeg = true;
        }
      }
    });
  }

  @override
  void initState() {
    widget.isPreviewEdit == false ? getPostDetail() : getPostPreview();
    // TODO: implement initState
    super.initState();
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
        backgroundColor: white_ffffff,
        body: GetBuilder<FoodBuddyViewModel>(
          builder: (controller) {
            if (controller.viewPostDetailApiResponse.status == Status.LOADING ||
                controller.viewPostPreviewApiResponse.status ==
                    Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.viewPostDetailApiResponse.status == Status.ERROR) {
              return const SizedBox();
            }
            if (controller.viewPostPreviewApiResponse.status == Status.ERROR) {
              return const SizedBox();
            }

            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ToolbarWithTitle(widget.isPreviewEdit == null
                        ? "Create Post"
                        : "Edit Post"),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: divider_d4dce7,
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8.r),
                                color: red_dc3642,
                                //color of dotted/dash line
                                strokeWidth: 1,
                                //thickness of dash/dots
                                dashPattern: [4, 3],
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.w, horizontal: 12.h),
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                              icon_warning_rectangle),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          // This post will only be valid for 24 hours.
                                          Text(
                                              "This post will only be valid for 24 hours.",
                                              style: TextStyle(
                                                  color: red_dc3642,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                  "Connect with thousands of foodies like you. Meet the community",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProRegular,
                                      fontSize: 14.sp,
                                      height: 1.5),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 20.h,
                              ),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8.r),
                                color: grey_d9dde3,
                                //color of dotted/dash line
                                strokeWidth: 1,
                                //thickness of dash/dots
                                dashPattern: [4, 3],
                                child: GestureDetector(
                                  onTap: () async {
                                    _openImagePicker();
                                    // image = await picker.pickImage(
                                    //     source: ImageSource.gallery);.
                                    setState(() {
                                      //update UI
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      child: Container(
                                          height: 180.h,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.w, horizontal: 12.h),
                                          width: double.infinity,
                                          color: bg_fafbfb,
                                          child: apiImage != null
                                              ? Image.network(
                                                  apiImage!,
                                                  fit: BoxFit.fill,
                                                )
                                              : selectedImage == null
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        SvgPicture.asset(
                                                          icon_add_post_food_buddy,
                                                          width: 29.w,
                                                          height: 29.h,
                                                        ),
                                                        SizedBox(
                                                          height: 6.w,
                                                        ),
                                                        Text("Upload Image",
                                                            style: TextStyle(
                                                                color:
                                                                    black_504f58,
                                                                fontFamily:
                                                                    fontMavenProProSemiBold,
                                                                fontSize:
                                                                    14.sp),
                                                            textAlign:
                                                                TextAlign.left)
                                                      ],
                                                    )
                                                  : Image.file(
                                                      selectedImage!))),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Post Title",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontMavenProRegular,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 6.h,
                              ),
                              loginTextformField(
                                "",
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: _titleController,
                                obscureText: true,
                                regularExpression:
                                    RegularExpression.alphabetSpacePattern,
                                onChanged: (value) {},
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Description",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontMavenProRegular,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 6.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(14.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.r),
                                    border: Border.all(
                                        width: 1, color: grey_d9dde3)),
                                child: TextField(
                                    maxLines: 5,
                                    controller: _descController,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: fontMavenProMedium,
                                        color: black_504f58), //or null
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Write here...",
                                      hintStyle: TextStyle(
                                          fontFamily: fontMavenProMedium,
                                          color: grey_77879e,
                                          fontSize: 14.sp),
                                    )),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Location",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontMavenProRegular,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 6.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelecLocationCreatePost(),
                                      )).then((value) {
                                    setState(() {});
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                          width: 1, color: grey_d9dde3)),
                                  child: // Hint text
                                      Text(
                                          "${Utility.address == "" ? 'Select' : Utility.address}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Date",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontMavenProRegular,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 6.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDialog(
                                    CupertinoDatePicker(
                                      // initialDateTime: DateTime.now(),
                                      minimumDate: DateTime.now(),
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: false,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          from_date = newTime;
                                        });
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                          width: 1, color: grey_d9dde3)),
                                  child: // Hint text
                                      Text(
                                          from_date == null
                                              ? "Select"
                                              : "${from_date!.month}-${from_date!.day}-${from_date!.year}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Preferred Gender",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 15.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isAny = true;
                                          isMale = false;
                                          isFemale = false;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isAny
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              icon_any,
                                              color: isAny
                                                  ? red_dc3642
                                                  : grey_504f58,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Any",
                                                style: TextStyle(
                                                    color: isAny
                                                        ? red_dc3642
                                                        : grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isAny = false;
                                          isMale = true;
                                          isFemale = false;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isMale
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              icon_male,
                                              color: isMale
                                                  ? red_dc3642
                                                  : grey_504f58,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Male",
                                                style: TextStyle(
                                                    color: isMale
                                                        ? red_dc3642
                                                        : grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isAny = false;
                                          isMale = false;
                                          isFemale = true;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isFemale
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              icon_female,
                                              color: isFemale
                                                  ? red_dc3642
                                                  : grey_504f58,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Female",
                                                style: TextStyle(
                                                    color: isFemale
                                                        ? red_dc3642
                                                        : grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text("Preferred Food",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 15.sp),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBoth = true;
                                          isVeg = false;
                                          isNonVeg = false;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isBoth
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              icon_anyfood_png,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Both",
                                                style: TextStyle(
                                                    color: grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBoth = false;
                                          isVeg = true;
                                          isNonVeg = false;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isVeg
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              icon_veg_second,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Veg",
                                                style: TextStyle(
                                                    color: grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBoth = false;
                                          isVeg = false;
                                          isNonVeg = true;
                                        });
                                      },
                                      child: Container(
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: isNonVeg
                                                    ? red_dc3642
                                                    : grey_d9dde3,
                                                width: 1),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              icon_non_veg_second,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            // All day
                                            Text("Non Veg",
                                                style: TextStyle(
                                                    color: grey_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CommonRedButton(strContinue.toUpperCase(),
                                  () async {
                                addPostReqModel.action =
                                    widget.isPreviewEdit == null
                                        ? 'add_post'
                                        : 'edit_post';
                                addPostReqModel.postImg = apiImage;
                                addPostReqModel.postTitle =
                                    _titleController.text;
                                widget.isPreviewEdit == null
                                    ? SizedBox()
                                    : addPostReqModel.postId =
                                        widget.postId.toString();
                                addPostReqModel.description =
                                    _descController.text;
                                addPostReqModel.date = from_date == null
                                    ? ""
                                    : "${from_date!.year}-${from_date!.month}-${from_date!.day}";
                                addPostReqModel.preferredGender = isAny == true
                                    ? 'ANY'
                                    : isMale == true
                                        ? 'MALE'
                                        : 'FEMALE';
                                addPostReqModel.preferredFood = isVeg == true
                                    ? 'VEG'
                                    : isNonVeg == true
                                        ? 'NON_VEG'
                                        : 'BOTH';
                                reqModel.Location location =
                                    reqModel.Location();
                                location.country = Utility.country;
                                location.countryCode = Utility.country_code;
                                location.cityName = Utility.city_name;
                                location.state = Utility.state;
                                location.address = Utility.address;
                                location.pincode = Utility.pincode;
                                location.lat = Utility.lat;
                                location.lang = Utility.lang;
                                addPostReqModel.location = location;

                                await foodBuddyViewModel.addPostViewModel(
                                    body: addPostReqModel);

                                if (foodBuddyViewModel
                                        .addPostApiResponse.status ==
                                    Status.COMPLETE) {
                                  AddPostResModel res = foodBuddyViewModel
                                      .addPostApiResponse.data;
                                  if (res.status == true) {
                                    if (widget.isPreviewEdit == true ||
                                        widget.isPreviewEdit == null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CreatePostPreivew(
                                                    postId:
                                                        widget.isPreviewEdit ==
                                                                null
                                                            ? res.postId!
                                                            : widget.postId!),
                                          ));
                                    } else {
                                      Get.offAll(PostDetailScreen(
                                          postId: widget.postId!));
                                    }
                                  } else {
                                    snackBar(title: res.message);
                                  }
                                }
                                if (foodBuddyViewModel
                                        .addPostApiResponse.status ==
                                    Status.ERROR) {
                                  const ServerError();
                                }
                              }, red_dc3642),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GetBuilder<FoodBuddyViewModel>(
                  builder: (controller) {
                    if (foodBuddyViewModel.addPostApiResponse.status ==
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
    );
  }

  Future<void> _openImagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      print("=======_selectedImage========${selectedImage}");
      // Get.back();
      setState(() {});
      uploadProfilePicReqModel.folder = "images";
      uploadProfilePicReqModel.fileName = "test";
      uploadProfilePicReqModel.contentType =
          "image/${pickedImage.path.split('.').last}";
      await uploadImageViewModel.uploadImage(body: uploadProfilePicReqModel);

      if (uploadImageViewModel.uploadImageApiResponse.status ==
          Status.COMPLETE) {
        UploadProfilePicResModel res =
            uploadImageViewModel.uploadImageApiResponse.data;

        var response = await http.put(
          Uri.parse(res.uploadURL!),
          headers: {
            'Content-Type': "image/${pickedImage.path.split('.').last}",
            'Accept': "*/*",
            'Content-Length': File(pickedImage.path).lengthSync().toString(),
            'Connection': 'keep-alive',
          },
          body: File(pickedImage.path).readAsBytesSync(),
        );
        if (response.statusCode == 200) {
          apiImage = 'https://bluedip.s3.ap-south-1.amazonaws.com/${res.key}';
          // Get.back();
        }
      }
      // await uploadImage(file: selectedImage!);
    }
  }
}
