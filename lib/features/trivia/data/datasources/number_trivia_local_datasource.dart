import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/error/exceptions.dart';
import 'package:tddarchitecture/features/trivia/data/models/number_trivia_model.dart';
import 'package:tddarchitecture/features/trivia/domain/entitiies/model_trivia.dart';

abstract class NumberTriviaLocalDataSource{
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia) {
    return sharedPreferences.setString(
      'CACHED_NUMBER_TRIVIA',
      json.encode(numberTrivia.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final rawJson=sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
    if(rawJson!=null) {
      final numberTrivia = Future.value(
          NumberTriviaModel.fromJson(json.decode(rawJson)));
      return numberTrivia;
    }else throw CacheException;

  }

}
