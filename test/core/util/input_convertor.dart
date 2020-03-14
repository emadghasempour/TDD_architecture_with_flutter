import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddarchitecture/core/error/Failures.dart';
import 'package:tddarchitecture/core/util/input_convertor.dart';

void main(){
  InputConvertor inputConverter;
  setUp((){
    inputConverter=InputConvertor();
  });
  group("check returning integer", (){
    test('should return integer ', () {
        //arrange
        final str='123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, Right(123));
      });
    test(
      'should return a failure when the string is a negative integer',
          () async {
        // arrange
        final str = '-123';
        // act
        final result = inputConverter.stringToUnsignedInteger(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });


}