import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/common/google_auth_controller.dart';
import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:ootms/presentation/screens/auth/sign_in_sign_up_chosser.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/select_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navigation/animeted_navigation.dart';

void saveUserAcessDetails(String token, String role) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setString(ootmsUserAccessToken, token);
  preferences.setString(ootmsUserRole, role);
}

Future<List<String>?> getUserAcessDetails() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString(ootmsUserAccessToken);
  String? role = preferences.getString(ootmsUserRole);
  if (token != null && role != null) {
    return [token, role];
  }

  return null;
}

void deleteUserAccessDetails({required BuildContext context}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final GoogleAuth _googleAuth = GoogleAuth();
  preferences.remove(ootmsUserAccessToken);
  preferences.remove(ootmsUserRole);
  _googleAuth.signOut();
  slideNavigationPushAndRemoveUntil(const SelectRole(), context);
}

void clearAllData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
}
