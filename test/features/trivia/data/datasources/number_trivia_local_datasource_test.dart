import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddarchitecture/core/error/exceptions.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tddarchitecture/features/trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  NumberTriviaLocalDataSource numberTriviaLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("local data source", () {
    final tNumberTrivialModle =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('should  ', ()async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia.json'));
      // act
      final result = await numberTriviaLocalDataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, tNumberTrivialModle);
    });

    test('should throw exeption ', () {
      //arrange
      when(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'))
          .thenReturn(null);
      // act
      final call = numberTriviaLocalDataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(CacheException));

    });
  });
}
