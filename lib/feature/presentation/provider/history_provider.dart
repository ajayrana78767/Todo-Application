import 'package:flutter/material.dart';
import 'package:todo_application/feature/core/network/dio_client.dart';
import 'package:todo_application/feature/data/models/history_model.dart';
import 'package:todo_application/feature/data/repositories/history_repository.dart';

class HistoryProvider with ChangeNotifier {
  final HistoryRepository _historyRepository = HistoryRepository(DioClient());
  List<HistoryData> _historyList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<HistoryData> get historyList => _historyList;

  // Set laoding
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Fetch History
  Future<void> fetchHistory() async {
    setLoading(true);
    try {
      final response = await _historyRepository.fetchHistory();
      _historyList = response;
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      setLoading(false);
    }
  }
}
