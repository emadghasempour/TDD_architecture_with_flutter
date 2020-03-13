import 'package:tddarchitecture/features/trivia/data/models/number_trivia_model.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

abstract class NumberTriviaLocalDataSource{
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia numberTrivia);
}
