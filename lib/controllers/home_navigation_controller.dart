import 'package:flutter/material.dart';

/// Controller for managing home screen navigation business logic
/// Handles bottom navigation and page switching
class HomeNavigationController {
  HomeNavigationController() {
    _pageIndex = ValueNotifier(0);
    _title = ValueNotifier(_pageTitles[0]);
  }

  late final ValueNotifier<int> _pageIndex;
  late final ValueNotifier<String> _title;

  final List<String> _pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  ValueNotifier<int> get pageIndex => _pageIndex;
  ValueNotifier<String> get title => _title;

  /// Handle navigation item selection
  void onNavigationItemSelected(int index) {
    _title.value = _pageTitles[index];
    _pageIndex.value = index;
  }

  /// Clean up resources
  void dispose() {
    _pageIndex.dispose();
    _title.dispose();
  }
}
