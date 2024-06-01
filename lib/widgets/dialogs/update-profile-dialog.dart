import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizz_app/controllers/controllers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class UpdateProfileDialog extends StatefulWidget {
  @override
  _UpdateProfileDialogState createState() => _UpdateProfileDialogState();
}

class _UpdateProfileDialogState extends State<UpdateProfileDialog> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController.text =
        Get.find<AuthController>().getUser()?.displayName ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isUpdating = true;
    });

    final AuthController _auth = Get.find<AuthController>();
    User? user = _auth.getUser();
    if (user != null) {
      String? photoURL;
      if (_image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${user.uid}.jpg');
        await ref.putFile(_image!);
        photoURL = await ref.getDownloadURL();
      }
      // Update Firestore
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        if (photoURL != null) 'profilepic': photoURL,
      });

      // Update Firebase Auth
      await user.updateDisplayName(_nameController.text);
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
      await user.reload();
      Get.back();
    }

    setState(() {
      _isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 20),
          _image == null
              ? Text('No image selected.')
              : Image.file(_image!, height: 100, width: 100),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isUpdating ? null : _updateProfile,
          child: _isUpdating ? CircularProgressIndicator() : Text('Update'),
        ),
      ],
    );
  }
}
