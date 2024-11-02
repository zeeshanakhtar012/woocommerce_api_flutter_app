import 'dart:developer';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import '../../constants/fonts.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> { 
  File? imageFile;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path); 
      });
      Navigator.pop(context);
      _showPicker(context);
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return; 
    Get.back();
  }

  Future<void> deleteImage() async { 
    Get.back();
    Get.back();
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.h),
            child: Wrap(
              children: <Widget>[
                _buildEditHeader(),
                _buildPickerOptions(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditHeader() {
    return Row(
      children: [
        if (widget.imageUrl.isNotEmpty)
          Image.network(widget.imageUrl, height: 47.h, width: 37.w),
        SizedBox(width: 6.sp),
        Text(
          'Edit profile picture',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700),
        ),
        Spacer(),
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ],
    ).marginOnly(top: 8.sp);
  }

  Widget _buildPickerOptions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25.h),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Color(0xFF222222),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPickerOption('Take photo', () => pickImage(ImageSource.camera),
              "assets/icons/camera.svg"),
          _buildDivider(),
          _buildPickerOption('Choose photo',
              () => pickImage(ImageSource.gallery), "assets/icons/gallery.svg"),
          _buildDivider(),
          _buildPickerOption(
              'Delete photo', deleteImage, "assets/icons/delete.svg",
              isDelete: true),
          if (imageFile != null) ...[
            _buildDivider(),
            _buildPickerOption(
                'Upload Photo', uploadImage, "assets/icons/upload_image.svg"),
          ],
        ],
      ),
    );
  }

  Widget _buildPickerOption(String label, VoidCallback onTap, String iconPath,
      {bool isDelete = false}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            label,
            style:
                TextStyle(color: isDelete ? Color(0xFFFF0000) : Colors.white),
          ),
          Spacer(),
          SvgPicture.asset(iconPath,
              color: isDelete ? Color(0xFFFF0000) : Colors.white),
        ],
      ).marginSymmetric(horizontal: 14.w),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.white).marginOnly(bottom: 10.h, left: 14.w);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: CircleAvatar(
            radius: 10.r,
            backgroundColor: Color(0xff4C6042),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        title: Text(
          "Profile photo",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: () => _showPicker(context),
            child: Text("Edit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: imageFile != null
                ? FileImage(imageFile!)
                : NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/9584/9584876.png")
                    as ImageProvider<Object>, // Typecast here
            backgroundDecoration: BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
          true
                ? Positioned(
                    child: Center(child: CircularProgressIndicator()),
                    bottom: 0,
                    right: 0)
                : SizedBox(),
           
        ],
      ),
    );
  }
}
