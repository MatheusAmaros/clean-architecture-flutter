import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() {
        return client.post(any(), body: any(named: 'body'));
      }).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;
      expect(methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(() {
        return client.post(Uri.parse('$kbaseUrl$kCreateUserEndPoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar'
            }));
      }).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should complete successfully when the status code is not 200 or 201',
        () async {
      when(() {
        return client.post(any(), body: any(named: 'body'));
      }).thenAnswer((_) async => http.Response('Invalid Email address', 400));

      final methodCall = remoteDataSource.createUser;
      expect(
          methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(const APIException(
              message: 'Invalid Email address', statusCode: 400)));

      verify(() {
        return client.post(Uri.parse('$kbaseUrl$kCreateUserEndPoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar'
            }));
      }).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}