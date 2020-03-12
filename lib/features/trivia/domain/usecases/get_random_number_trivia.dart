import 'package:dartz/dartz.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

import '../../../../core/usecase/usecase.dart';

import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}