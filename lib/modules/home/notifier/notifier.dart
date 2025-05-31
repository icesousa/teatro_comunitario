// lib/viewmodels/show_list_viewmodel.dart

import 'package:faculdadeextensao/modules/home/model/show.dart';
import 'package:faculdadeextensao/services/show_service.dart';
import 'package:flutter/material.dart';

/// The ViewModel for the home page. It fetches the list of shows and
/// handles interest submissions.
class ShowListViewModel extends ChangeNotifier {
  final ShowService _service;

  ShowListViewModel({ShowService? service})
      : _service = service ?? ShowService();

  List<Show> _shows = [];
  bool _isLoading = false;
  String? _errorMessage;
  int? _selectedMonth; // 1-12, null means all months

  List<Show> get shows => _selectedMonth == null
      ? _shows
      : _shows.where((show) => show.date.month == _selectedMonth).toList();
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get selectedMonth => _selectedMonth;

  /// Fetches upcoming shows from the service.
  Future<void> loadShows() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _shows = await _service.fetchUpcomingShows();
    } catch (e) {
      _errorMessage = 'Failed to load shows.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets the selected month for filtering (1-12, or null for all)
  void setSelectedMonth(int? month) {
    _selectedMonth = month;
    notifyListeners();
  }

  /// Submits interest for a show. Returns true if successful.
  Future<bool> submitInterest({
    required String showId,
    required String name,
    required String email,
  }) async {
    try {
      final success = await _service.submitInterest(
        showId: showId,
        name: name,
        email: email,
      );
      return success;
    } catch (e) {
      return false;
    }
  }
}
