import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia});
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});
  List<Object> get props => [message];
}