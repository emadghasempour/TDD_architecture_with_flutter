import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent([List props = const <dynamic>[]]);
}

class GetTriviaForNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForNumber(this.numberString) : super([numberString]);

  @override
  // TODO: implement props
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
