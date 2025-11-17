import 'package:get_it/get_it.dart';
import 'package:weam/features/auth/data/data_source/auth_data_source.dart';

import '../../features/user/data/orders_data_source.dart';
import '../../features/user/data/requests_data_source.dart';
import '../../features/user/data/services_data_source.dart';
import '../../features/vendor/data/orders_remote_data_source.dart';
import '../network/dio_helper.dart';
import 'maps_services.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///DATA SOURCE

    /// API Methods Class (DIO)
    sl.registerLazySingleton(() => DioHelper());
    sl.registerLazySingleton(() => GoogleMapsServices());
    sl.registerLazySingleton(() => AuthRemoteDataSource(dioHelper: sl()));
    sl.registerLazySingleton(() => RequestsDataSource(dioHelper: sl()));
    sl.registerLazySingleton(() => ServicesDataSource(dioHelper: sl()));
    sl.registerLazySingleton(() => UserOrdersDataSource(dioHelper: sl()));
    sl.registerLazySingleton(() => VendorOrdersDataSource(dioHelper: sl()));
  }
}
