import 'package:dartz/dartz.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository{
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