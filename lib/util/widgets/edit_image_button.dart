import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controllers/profile_controller.dart';




class EditImageButton extends StatefulWidget {
  const EditImageButton({Key? key}) : super(key: key);

  @override
  State<EditImageButton> createState() => _EditImageButtonState();
}

class _EditImageButtonState extends State<EditImageButton> {
  final ProfileController _profileController = Get.put(ProfileController());
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picker = ImagePicker();
        final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = pickedFile;
          _profileController.profileImageUpdate(context, _image);
        });
      },
      child: const CircleAvatar(
        radius: 16,
        backgroundColor: Colors.blueAccent,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Icon(
            Icons.edit,
            color: Colors.white, size: 20,
          ),
        ),
      ),
    );
  }
}