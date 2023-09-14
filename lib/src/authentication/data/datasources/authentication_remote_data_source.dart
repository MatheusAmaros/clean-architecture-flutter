import 'dart:convert';

import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const String kCreateUserEndPoint = '/users';
const String kGetUsersEndPoint = '/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);
  final http.Client _client;
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    final response = await _client.post(
      Uri.parse('$kbaseUrl$kCreateUserEndPoint'),
      body: jsonEncode(
        {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'},
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw APIException(message: response.body, statusCode: 400);
    }
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
