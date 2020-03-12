import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tddarchitecture/features/trivia/domain/usecases/get_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}

void main(){
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetNumberTrivia usecase;

  setUp((){
    mockNumberTriviaRepository= MockNumberTriviaRepository();
    usecase=GetNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  test("description", () async{
    when(mockNumberTriviaRepository.getNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase(Params(number: tNumber));
    // UseCase should simply return whatever was returned from the Repository
    expect(result, Right(tNumberTrivia));
    // Verify that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getNumberTrivia(tNumber));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}