import 'package:get_it/get_it.dart';
import 'package:ppeongnote/service/shared_preferences_service.dart';

GetIt locator = GetIt.instance;
initLocator() {
  locator.registerSingleton<SharedPreferencesService>(
      SharedPreferencesServiceImp());
}
