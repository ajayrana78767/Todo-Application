import 'package:flutter/material.dart';
import 'package:todo_application/feature/core/network/dio_client.dart';
import 'package:todo_application/feature/data/models/character_model.dart';
import 'package:todo_application/feature/data/repositories/characters_repository.dart';

class CharactersProvider with ChangeNotifier {
  final CharactersRepository _charactersRepository = CharactersRepository(DioClient());
  List<CharacterModel> _list = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<CharacterModel> get list => _list;

  // Set laoding
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Fetch Characters
  Future<void> fetchCharacters( {required String query}) async {
    setLoading(true);
    try {
      final response = await _charactersRepository.fetchCharacters(query:query);
      _list = response;
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      setLoading(false);
    }
  }
}
