import 'package:dartz/dartz.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

abstract class NumberTriviaRepository{
  Future<Either<Failure,NumberTrivia>> getNumberTrivia(int number);
  Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();
}