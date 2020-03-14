import 'package:dartz/dartz.dart';
import 'package:tddarchitecture/core/error/Failures.dart';

class InputConvertor {
  Either<Failure, int> stringToUnsignedInteger(String number) {
    try {
      final integer = int.parse(number);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
