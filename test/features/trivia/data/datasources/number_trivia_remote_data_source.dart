import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tddarchitecture/core/error/exceptions.dart';
import 'package:tddarchitecture/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddarchitecture/features/trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

void main() {
  MockClient mockClient;
  NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;

  setUp(() {
    mockClient = MockClient();
    numberTriviaRemoteDataSource = NumberTriviaRemoteDataSourceImpl(mockClient);
  });

  group("get http request test", () {
    final tNumber = 1;
    test('should return 200 ', () {
      //arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(fixture("trivia.json"), 200));
      // act
      numberTriviaRemoteDataSource.getNumberTrivia(tNumber);
      // assert
      verify(mockClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });

    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(fixture('trivia.json'), 200),
        );
        // act
        final result =
            await numberTriviaRemoteDataSource.getNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    /*test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => Response('Something went wrong', 404),
        );
        // act
        final call = numberTriviaRemoteDataSource.getNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(ServerException));
      },
    );*/

  });
}
