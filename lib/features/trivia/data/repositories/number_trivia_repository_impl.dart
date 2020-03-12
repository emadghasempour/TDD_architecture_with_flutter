import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/platform/network_info.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository{
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });


  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number) {
    // TODO: implement getNumberTrivia
    return null;
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    return null;
  }

}