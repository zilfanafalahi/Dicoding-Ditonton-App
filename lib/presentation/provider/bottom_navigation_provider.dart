import 'package:flutter/material.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _page = 0;

  int get page => _page;

  void setPage(int page) => _setPage(page);

  void _setPage(int page) {
    _page = page;
    notifyListeners();
  }
}
