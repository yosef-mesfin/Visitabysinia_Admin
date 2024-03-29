
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visab_admin/data/firebase_auth_admin.dart';

class ResetPasswordController extends GetxController {
  Rx<bool> isFormValid = false.obs;
  FirebaseAuthAdmin _firebaseAuthAdmin = FirebaseAuthAdmin();
  Rx<String> invalidEmailError = "".obs;
  TextEditingController emailController;


//User get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    emailController  = TextEditingController();
  }


  void resetPassword(String email){
    try {
      _firebaseAuthAdmin.resetPassword(email);
    }catch(e){

    }
  }

  void onSubmitPressed() async{
    if (validate()) {
     resetPassword(emailController.text.trim());
    }else{
      Get.snackbar("Validation error", "forms are not valid");
    }

  }
  bool isEmailValid(String value){
    if(!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
        r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
        r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
        r"(?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool checkEmptyField(String value){
    if(value == null || value.isEmpty){
      return true;
    }
    return false;
  }

  bool validate(){
    bool isValid = true;
    invalidEmailError.value = "";
    if(checkEmptyField(emailController.text.trim()) || !isEmailValid(emailController.text.trim())){
      print("invalidity while checking for empty fields email part ");
      invalidEmailError.value = "Please, enter a valid email";
      isFormValid.value = false;
      isValid = false;

    }
    if(isValid == true){
      isFormValid.value = true;
    }
    return isValid;
  }

}