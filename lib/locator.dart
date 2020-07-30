import 'package:get_it/get_it.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/services/firestore_service.dart';
import 'package:recipesaver/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(()=> AuthenticationService());
  locator.registerLazySingleton(()=> FirestoreService());
}
