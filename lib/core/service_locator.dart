import 'package:get_it/get_it.dart';
import 'package:kawaii_chat/screen/chat/data/response_database.dart';
import 'package:kawaii_chat/screen/chat/data/response_repository_implementation.dart';
import 'package:kawaii_chat/screen/chat/domain/response_repository.dart';
import 'package:kawaii_chat/screen/chat/domain/response_use_case.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocators() async {
  await sl.reset();

  sl.registerFactory<ResponseRepository>(() => ResponseRepositoryImpl());
  sl.registerFactory<ResponseDatabase>(() => ResponseDatabase());
  sl.registerFactory<ResponseUseCase>(() => const ResponseUseCase());
}