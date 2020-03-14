import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/usecase/usecase.dart';
import 'package:tddarchitecture/core/util/input_convertor.dart';
import 'package:tddarchitecture/features/trivia/domain/usecases/get_number_trivia.dart';
import 'package:tddarchitecture/features/trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConvertor inputConverter;

  NumberTriviaBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      //yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        // Although the "success case" doesn't interest us with the current test,
        // we still have to handle it somehow.
        (integer) async* {
          yield Loading();
          final failureOrTrivia = await getNumberTrivia(
            Params(number: integer),
          );
          yield failureOrTrivia.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (trivia) => Loaded(trivia: trivia),
          );
        },
      );
    }else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield failureOrTrivia.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (trivia) => Loaded(trivia: trivia),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

}
