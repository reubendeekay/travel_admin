import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:travel_admin/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;

  Future<void> login({String email, String password}) async {
    final UserCredential _currentUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    final _userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.user.uid)
        .get();

    notifyListeners();
  }

  Future<void> signUp(
      {String email,
      String password,
      String fullName,
      String phoneNumber}) async {
    final UserCredential _currentUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.user.uid)
        .set({
      'userId': _currentUser.user.uid,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': null,
      'profilePic': null,
      'dateOfBirth': null,
      'nationalId': null,
    });

    notifyListeners();
  }

  Future<void> getCurrentUser(String userId) async {
    final _currentUser =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    _user = UserModel(
        address: _currentUser['address'],
        dateOfBirth: _currentUser['dateOfBirth'],
        email: _currentUser['email'],
        fullName: _currentUser['fullName'],
        nationalId: _currentUser['nationalId'],
        phoneNumber: _currentUser['phoneNumber'],
        imageUrl: _currentUser['profilePic'],
        userId: _currentUser['userId'],
        password: _currentUser['password']);

    notifyListeners();
  }

  Future<void> updateProfile(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'email': user.email,
      'fullName': user.fullName,
      'phoneNumber': user.phoneNumber,
      'address': user.address,
      'profilePic': user.imageUrl,
      'dateOfBirth': user.dateOfBirth == null
          ? null
          : DateFormat('dd/MM/yyyy').format(user.dateOfBirth),
      'nationalId': user.nationalId,
    });
    notifyListeners();
  }
}
