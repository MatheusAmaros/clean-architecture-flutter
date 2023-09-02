import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';

import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //Test-Driven Development
    // call the remote data source
    //check if the method return the proper data
    // check if when the remoteDataSource throws an exception, we return a
    //failure and if it doesn't throw and exception we return the actual expected data
    await _remoteDataSource.createUser(
        createdAt: createdAt, name: name, avatar: avatar);
    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() {
    throw UnimplementedError();
  }
}
