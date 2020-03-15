import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_convertor.dart';
import 'features/trivia/data/datasources/number_trivia_local_datasource.dart';
import 'features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/trivia/domain/repositories/number_trivia_repository.dart';
import 'features/trivia/domain/usecases/get_number_trivia.dart';
import 'features/trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/trivia/presentation/bloc/number_trivia_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
        () =>
        NumberTriviaBloc(
          concrete: sl(),
          inputConverter: sl(),
          random: sl(),
        ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
        () =>
        NumberTriviaRepositoryImpl(
          localDataSource: sl(),
          networkInfo: sl(),
          remoteDataSource: sl(),
        ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConvertor());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //final sharedPreferences = await SharedPreferences.getInstance();
  //sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}