import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
