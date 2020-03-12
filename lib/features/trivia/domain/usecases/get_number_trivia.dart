import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/usecase/usecase.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia extends UseCase<NumberTrivia, Params>{
  NumberTriviaRepository repository;
  GetNumberTrivia(this.repository);

  Future<Either<Failure,NumberTrivia>> call(Params params) async{
    return await repository.getNumberTrivia(params.number);
  }
}
class Params extends Equatable {
  final int number;

  Params({@required this.number});


  @override
  // TODO: implement props
  List<Object> get props => [number];}