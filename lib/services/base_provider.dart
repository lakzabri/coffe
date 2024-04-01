import 'package:flutter/cupertino.dart';

class BaseProvider extends ChangeNotifier {
  bool _busy = false;
  String _message;
  bool get busy => _busy;
  String get message => _message;

  BaseProvider() : _message = ''; // Initialize in the constructor

  void setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }

  void setMessage(String val) {
    _message = val;
    notifyListeners();
  }
}
