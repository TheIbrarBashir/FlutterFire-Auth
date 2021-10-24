import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PasswordVisibilityNotifier extends ChangeNotifier {
  bool _isObsure = true;
  bool get passwordVisibility => _isObsure;

  void password() {
    _isObsure = !_isObsure;
    notifyListeners();
  }
}
