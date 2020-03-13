import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/error/exceptions.dart';
import 'package:tddarchitecture/core/network/network_info.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(
      int number,
      ) async {
    return await _getTrivia(() {
      return remoteDataSource.getNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }
  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
