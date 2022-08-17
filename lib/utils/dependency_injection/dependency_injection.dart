import 'dart:developer';

import 'package:ssl_app/controller/service.dart';
import 'package:ssl_app/utils/globals.dart';
import 'package:ssl_app/view/providers/documents_provider.dart';
import 'package:ssl_app/view/usecases/create_document.dart';
import 'package:ssl_app/view/usecases/get_doc_type.dart';

Future<void> init() async {
  registerModules();

  registerControllers();
  registerUseCases();
}

void registerUseCases() {
  sl.registerLazySingleton(() => GetDocumentTypes(sl()));
  sl.registerLazySingleton(() => CreateDocument(sl()));
}

void registerControllers() {
  sl.registerLazySingleton(() => DocumentProvider(
        getDocumentTypes: sl(),
        createDocument: sl(),
      ));
}

void registerModules() {
  sl.registerLazySingleton(() => Service());
  sl.registerLazySingleton(() => RemoteDataSource());
}
