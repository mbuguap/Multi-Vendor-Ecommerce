import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  _uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        _firebaseStorage.ref().child('profiles').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> signUpUsers(
      String fullName, String email, String password, Uint8List image) async {
    String res = 'some error occured';

    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadImageToStorage(image);
        await _firestore.collection('customers').doc(cred.user!.uid).set({
          'cid': cred.user!.uid,
          "fullName": fullName,
          "email": email,
          "image": downloadUrl,
          "address": ''
        });

        res = 'success';
        // print('Account Created');
      } else {
        res = 'Please fill all fields';
        // print('Please fill all fields');
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUsers(String email, String password) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
        print('Login Successful');
      } else {
        res = 'All fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
