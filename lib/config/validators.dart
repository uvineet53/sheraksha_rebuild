import 'package:get/get.dart';

mixin Validators {
  String emailValidator(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String passwordValidator(String value) {
    if (value.length < 6) {
      return 'Password length is too short';
    }
    return null;
  }
}
