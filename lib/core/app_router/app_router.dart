import 'package:flutter/material.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:weam/features/auth/presentation/screens/login_or_register_screen.dart';
import 'package:weam/features/auth/presentation/screens/login_screen.dart';
import 'package:weam/features/auth/presentation/screens/new_password_screen.dart';
import 'package:weam/features/auth/presentation/screens/otp_screen.dart';
import 'package:weam/features/auth/presentation/screens/splash_screen.dart';
import 'package:weam/features/auth/presentation/screens/welcome_screen.dart';
import 'package:weam/features/user/data/models/get_services_model.dart';
import 'package:weam/features/user/data/models/order_model.dart';
import 'package:weam/features/user/presentation/screens/change_directions_screen.dart';
import 'package:weam/features/user/presentation/screens/choose_direction_screen.dart';
import 'package:weam/features/user/presentation/screens/complete_request_ambulance_form_first_screen.dart';
import 'package:weam/features/user/presentation/screens/edit_profile_screen.dart';
import 'package:weam/features/user/presentation/screens/patien_details_screen.dart';
import 'package:weam/features/user/presentation/screens/patient_transfer_acknowledgement_screen.dart';
import 'package:weam/features/user/presentation/screens/payment_screen.dart';
import 'package:weam/features/user/presentation/screens/profile_screen.dart';
import 'package:weam/features/user/presentation/screens/request_doctor_and_confirm_screen.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/complete_service_request_screen.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/doctor_arrives_screen.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/medical_services_screen.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/start_request_screen.dart';
import 'package:weam/features/user/presentation/screens/reset_details_screen.dart';
import 'package:weam/features/user/presentation/screens/reset_screen.dart';
import 'package:weam/features/user/presentation/screens/road_progress_screen.dart';
import 'package:weam/features/user/presentation/screens/user_main_layout.dart';
import 'package:weam/features/user/presentation/screens/user_orders/order_details_screen.dart';
import 'package:weam/features/user/presentation/screens/user_orders/user_order_screen.dart';
import 'package:weam/features/vendor/presentation/screens/start_order_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_edit_profile_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_home_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_main_layout_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_order_progress_screen.dart';
import 'package:weam/features/vendor/presentation/screens/vendor_profile_screen.dart';

import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/user/presentation/screens/acknowledge_screen.dart';
import '../../features/user/presentation/screens/home_screen.dart';
import '../../features/user/presentation/screens/payment_medical_services_screen.dart';
import '../../features/user/presentation/screens/request_medical_services_screen/sub_services_details_screen.dart';
import '../../features/user/presentation/screens/request_medical_services_screen/sub_services_screen.dart';
import '../../features/user/presentation/screens/terms_conditions_screen.dart';
import '../../features/vendor/presentation/screens/vendor_order_details_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case ScreenName.splashScreen:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        case ScreenName.welcomeScreen:
          return MaterialPageRoute(builder: (_) => const WelcomeScreen());
        case ScreenName.loginOrRegisterScreen:
          return MaterialPageRoute(builder: (_) => const LoginOrRegisterScreen());
        case ScreenName.registerScreen:
          return MaterialPageRoute(builder: (_) => const RegisterScreen());
        case ScreenName.loginScreen:
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        case ScreenName.userMainLayoutScreen:
          return MaterialPageRoute(builder: (_) => const UserMainLayoutScreen());
        case ScreenName.vendorMainLayoutScreen:
          return MaterialPageRoute(builder: (_) => const VendorMainLayoutScreen());
        case ScreenName.vendorHomeScreen:
          return MaterialPageRoute(builder: (_) => const VendorHomeScreen());
        case ScreenName.userHomeScreen:
          return MaterialPageRoute(builder: (_) => const UserHomeScreen());
        case ScreenName.otpScreen:
          final args = settings.arguments as OtpArguments;
          return MaterialPageRoute(
              builder: (_) => OtpScreen(
                    otpArguments: args,
                  ));
        case ScreenName.forgetPasswordScreen:
          return MaterialPageRoute(builder: (_) => const ForgetPasswordScreenScreen());
        case ScreenName.newPasswordScreen:
          return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
        case ScreenName.doctorArrivesScreen:
          return MaterialPageRoute(builder: (_) => const DoctorArrivesScreen());
        case ScreenName.medicalServicesScreen:
          return MaterialPageRoute(builder: (_) => const MedicalServicesScreen());
        case ScreenName.userOrdersScreen:
          return MaterialPageRoute(builder: (_) => const UserOrdersScreen());
        case ScreenName.changeDirectionsScreen:
          final args = settings.arguments as String;
          return MaterialPageRoute(
              builder: (_) => ChangeDirectionScreen(
                    id: args,
                  ));
        case ScreenName.completeRequestAmbScreen:
          return MaterialPageRoute(builder: (_) => const CompleteRequestAmbulanceFormScreen());
        case ScreenName.patientRequestAmbScreen:
          return MaterialPageRoute(builder: (_) => const RequestAmbPatientScreenScreen());
        case ScreenName.requestDoctorAndConfirmScreen:
          return MaterialPageRoute(builder: (_) => const RequestDoctorAndConfirmScreen());
        case ScreenName.editUserProfile:
          return MaterialPageRoute(builder: (_) => const EditProfileScreen());
        case ScreenName.paymentScreen:
          return MaterialPageRoute(builder: (_) => const PaymentScreen());
        case ScreenName.profileScreen:
          return MaterialPageRoute(builder: (_) => const ProfileScreen());
        case ScreenName.resetScreen:
          return MaterialPageRoute(builder: (_) => const ResetScreen());
        case ScreenName.startOrderScreen:
          return MaterialPageRoute(builder: (_) => const StartOrderScreen());
        case ScreenName.vendorEditProfileScreen:
          return MaterialPageRoute(builder: (_) => const VendorEditProfileScreen());
        case ScreenName.vendorOrderDetailsScreen:
          return MaterialPageRoute(builder: (_) => const VendorOrderDetailsScreen());
        case ScreenName.termsAndConditionsScreen:
          return MaterialPageRoute(builder: (_) => const TermsAndConditionsScreen());
        case ScreenName.acknowledgmentScreen:
          return MaterialPageRoute(builder: (_) => const AcknowledgeScreen());
        case ScreenName.patientTransferAcknowledgementScreen:
          return MaterialPageRoute(builder: (_) => const PatientTransferAcknowledgementScreen());
        case ScreenName.vendorProfileScreen:
          return MaterialPageRoute(builder: (_) => const VendorProfileScreen());
        case ScreenName.chooseDirectionsScreen:
          final args = settings.arguments as ChooseDirectionScreenArguments;
          return MaterialPageRoute(
              builder: (_) => ChooseDirectionScreen(chooseDirectionScreenArguments: args));
        case ScreenName.subServicesDetailsScreen:
          final args = settings.arguments as ServiceSubModel;
          return MaterialPageRoute(builder: (_) => SubServicesDetailsScreen(serviceSubModel: args));
        case ScreenName.paymentMedicalServicesScreen:
          final args = settings.arguments as PaymentMedicalServicesArgs;
          return MaterialPageRoute(
              builder: (_) => PaymentMedicalServicesScreen(paymentMedicalServicesArgs: args));
        case ScreenName.subServicesScreen:
          final args = settings.arguments as SubServicesArgs;
          return MaterialPageRoute(
            builder: (_) => SubServicesScreen(
              args: SubServicesArgs(
                list: args.list,
                appBarTitle: args.appBarTitle,
              ),
            ),
          );
        case ScreenName.resetDetailsScreen:
          final args = settings.arguments as OrderModel;
          return MaterialPageRoute(
              builder: (_) => ResetDetailsScreen(
                    orderModel: args,
                  ));
        case ScreenName.orderDetailsScreen:
          final args = settings.arguments as OrderModel;
          return MaterialPageRoute(
              builder: (_) => OrderDetailsScreen(
                    orderModel: args,
                  ));
        case ScreenName.roadProgressScreen:
          final args = settings.arguments as OrderModel;
          return MaterialPageRoute(
              builder: (_) => RoadProgressScreen(
                    orderModel: args,
                  ));
        case ScreenName.completeServicesRequestScreen:
          final args = settings.arguments as CompleteServiceRequestArgs;
          return MaterialPageRoute(
              builder: (_) => CompleteServiceRequestScreen(
                    completeServiceRequestArgs: args,
                  ));
        case ScreenName.startRequestScreen:
          final args = settings.arguments as CompleteServiceRequestArgs;
          return MaterialPageRoute(
              builder: (_) => StartRequestScreen(
                    completeServiceRequestArgs: args,
                  ));
        case ScreenName.vendorOrderScreen:
          return MaterialPageRoute(builder: (_) => const VendorOrderProgressScreen());
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error when routing to this screen'),
        ),
      );
    });
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 250),
        );
}
