import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc_observer.dart';
import 'core/app_router/app_router.dart';
import 'core/app_router/screens_name.dart';
import 'core/app_theme/app_theme.dart';
import 'core/cache_helper/shared_pref_methods.dart';
import 'core/network/dio_helper.dart';
import 'core/services/services_locator.dart';
import 'features/auth/buisness_logic/auth_cubit/auth_cubit.dart';
import 'features/user/buisness_logic/services_cubit/services_cubit.dart';
import 'features/user/buisness_logic/user_orders/user_orders_cubit.dart';
import 'features/user/buisness_logic/user_services_cubit/user_requests_cubit.dart';
import 'features/vendor/buisness_logic/vendor_orders_cubit/vendor_orders_cubit.dart';
import 'firebase_options.dart';
import 'translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CacheHelper.init();
  ServicesLocator().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(
          'en',
        ),
        Locale(
          'ar',
        ),
      ],
      startLocale: const Locale("ar"),
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthCubit(),
            ),
            BlocProvider(
              create: (_) => ServicesCubit(),
            ),
            BlocProvider(
              create: (_) => UserOrdersCubit(),
            ),
            BlocProvider(
              create: (_) => VendorOrdersCubit(),
            ),
            BlocProvider(
              create: (_) => UserRequestsCubit()..getNationality(),
            ),
          ],
          child: MaterialApp(
            title: 'MCA',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: ScreenName.splashScreen,
            // home: RoadProgressScreen(),
          ),
        );
      },
    );
  }
}



// is a

