import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';

class MockAuthRepoDataSrcImpl extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRepoDataSrcImpl();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('CreateUser', () {
    test(
        'should call the [remoteDataSource.createUser] and complete successfully when the call to the remote source is successful',
        () async {
      when(() {
        return remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        );
      }).thenAnswer((_) async => Future.value());

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(result, equals(const Right(null)));

      verify(() {
        return remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar);
      }).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      when(() {
        return remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        );
      }).thenThrow((_) async => Future.value());
    });
  });
}
