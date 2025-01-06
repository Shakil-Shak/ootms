import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';

class SettingController extends ChangeNotifier{
  
  final ApiService apiService = ApiService();
  bool isLoading = false;
  //============================================change password method
  // changePass({String? correntPass,String? newPass,String? userEmail,context})async{
  //   isLoading = true;
  //   notifyListeners();
  //   var response = await apiService.patchRequest(ApiPaths.chagePassword, {
  //     "oldPassword": correntPasss,
  //     "newPassword":newPass,
  //     "userEmail":userEmail,
  //   });
  //   if (response["statusCode"]==200) {
  //   Navigator.pop;
  //   showCommonSnackbar(context, "Change password successful!");
  //   isLoading = true;
  //   notifyListeners();
  //   }else{
  //   showCommonSnackbar(context, "Change password Failed! Try Again");
  //   isLoading = true;
  //   notifyListeners();

  //   }
  // }
}