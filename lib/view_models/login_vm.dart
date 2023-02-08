import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_it/services/auth.dart';

enum LoginStatus {idle, busy, error}

class LoginViewModel with ChangeNotifier {
  final _auth = Auth();

  LoginStatus status = LoginStatus.idle;

  String _email = "";
  String _password = "";
  String? _error;

  User? get user => _auth.user;
  String? get error => _error;
  bool? get isUserVerified => _auth.user?.emailVerified;

  void setEmail(String email) {
    _email = email;
  }

  void checkVerified() {
    if (isUserVerified ?? false) {
      print("Verified");
    } else {
      print("Not Verified");
    }
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
  }
  
  Future<void> login(BuildContext context, Widget errorWidget) async {
    try {
      status = LoginStatus.busy;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      status = LoginStatus.error;
      _error = e.message;
      status = LoginStatus.idle;
      rethrow;
    }
    status = LoginStatus.idle;
    notifyListeners();
  }

  Future<void> signup(BuildContext context, Widget errorWidget) async {
    try {
      status = LoginStatus.busy;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      status = LoginStatus.error;
      _error = e.message;
      status = LoginStatus.idle;
      rethrow;
    }
    status = LoginStatus.idle;
    notifyListeners();
  }

  void sendVerificationEmail() {
    _auth.sendVerificationEmail();
  }
}