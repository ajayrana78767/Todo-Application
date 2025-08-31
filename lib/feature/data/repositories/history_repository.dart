import 'package:flutter/material.dart';
import 'package:todo_application/feature/core/network/api_constants.dart';
import 'package:todo_application/feature/core/network/dio_client.dart';
import 'package:todo_application/feature/data/models/history_model.dart';

class HistoryRepository {
  final DioClient dioClient;

  HistoryRepository(this.dioClient);

  Future<List<HistoryData>> fetchHistory() async {
    try {
      final response = await dioClient.dio.post(ApiConstants.historyEndpoint,data: {'user_id': 17});
      debugPrint('Row response: ${response.data}');
      if (response.statusCode == 200) {
        // final List<dynamic> newList = response.data['data'];
        return (response.data['data'] as List)
            .map((e) => HistoryData.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('$e');
      throw Exception('Failed to load history: $e');
    }

  }
}
