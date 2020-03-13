import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/error/exceptions.dart';

import 'package:tddarchitecture/core/network/network_info.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddarchitecture/features/trivia/data/models/number_trivia_model.dart';
import 'package:tddarchitecture/features/trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

final tNumber = 1;
final tNumberTriviaModel =
    NumberTriviaModel(number: tNumber, text: 'test trivia');
final NumberTrivia tNumberTrivia = tNumberTriviaModel;

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group("repo", () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: 'test trivia');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("net", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getNumberTrivia(tNumber);
      verify(mockNetworkInfo.isConnected);
    });
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return Number trivia when the call remote data is OK ', () async {
      //arrange
      when(mockRemoteDataSource.getNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await  repository.getNumberTrivia(tNumber);

      // assert
      verify(mockRemoteDataSource.getNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivia));
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNumberTrivia(tNumber))
            .thenThrow(ServerException());
        // act
        final result = await repository.getNumberTrivia(tNumber);
        // assert
        verify(mockRemoteDataSource.getNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
      'should return number trivia when the devic is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async=> tNumberTrivia);
        // act
        final result = await repository.getNumberTrivia(tNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      },
    );
    test(
      'should return cache failure when the call to local data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        // act
        final result = await repository.getNumberTrivia(tNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      },
    );

  });
}
