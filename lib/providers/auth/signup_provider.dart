import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/alert_helper.dart';

class SignUpProvider extends ChangeNotifier {
  //---------email controller
  final _emailController = TextEditingController();
  //---------get email controller
  TextEditingController get emailController => _emailController;

  //---------password controller
  final _passwordController = TextEditingController();
  //---------get password controller
  TextEditingController get passwordController => _passwordController;

  //---------name controller
  final _nameController = TextEditingController();
  //---------get name controller
  TextEditingController get nameController => _nameController;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //-------------validate textfields function
  bool validateFields(BuildContext context) {
    //-------first checking all the textfields are empty or not
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please fill all the fields");
      return false;
    } else if (!_emailController.text.contains("@")) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please enter a valid email");
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR",
          "Password must have more than 6 digits");
      return false;
    } else {
      return true;
    }
  }

  //-------------start signup process
  Future<void> startSignup(BuildContext context) async {
    try {
      if (validateFields(context)) {
        //------start the loader
        setLoading(true);

        await AuthController().registerUser(
          context,
          _emailController.text,
          _passwordController.text,
          _nameController.text,
        );

        //------clear textfields
        _emailController.clear();
        _passwordController.clear();
        _nameController.clear();

        //------stop the loader
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AlertHelper.showAlert(context, DialogType.ERROR, "Error", e.toString());
    }
  }
}
