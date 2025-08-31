import 'package:todo_application/feature/core/network/api_constants.dart';
import 'package:todo_application/feature/core/network/dio_client.dart';
import 'package:todo_application/feature/data/models/character_model.dart';

class CharactersRepository {
  final DioClient dioClient;
  CharactersRepository(this.dioClient);

  Future<List<CharacterModel>> fetchCharacters({String query = ''}) async {
    try {
      final response = await dioClient.dio.get(ApiConstants.charcaterEndpoint,queryParameters: {
        if (query.isNotEmpty) 'name': query,
      });
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((e) => CharacterModel.fromJson(e)).toList();
      } else {
        throw Exception('Some thing went wrong: [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
