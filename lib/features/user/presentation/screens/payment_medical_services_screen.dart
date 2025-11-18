import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clickpay_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_clickpay_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkApms.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_clickpay_bridge/flutter_clickpay_bridge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/parameters/requests_parameters/car_request_parameter.dart';
import '../../buisness_logic/user_services_cubit/user_requests_cubit.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../../shared_widget/custom_sizedbox.dart';
import '../widgets/payment_widgets/payment_butto.dart';
import '../widgets/payment_widgets/payment_summary_widget.dart';

class PaymentMedicalServicesArgs extends Equatable {
  final String price;
  final String totalPrice;
  final String description;
  final String servicesId;
  final String subServicesId;

  const PaymentMedicalServicesArgs({
    required this.totalPrice,
    required this.price,
    required this.description,
    required this.servicesId,
    required this.subServicesId,
  });

  @override

  List<Object?> get props => [
        totalPrice,
        price,
      ];
}

class PaymentMedicalServicesScreen extends StatefulWidget {
  final PaymentMedicalServicesArgs? paymentMedicalServicesArgs;

  const PaymentMedicalServicesScreen({
    super.key,
    this.paymentMedicalServicesArgs,
  });

  @override
  State<PaymentMedicalServicesScreen> createState() => _PaymentMedicalServicesScreenState();
}

class _PaymentMedicalServicesScreenState extends State<PaymentMedicalServicesScreen> {
  int paymentMethodType = 0;

  PaymentSdkConfigurationDetails generateConfig() {
    var billingDetails = BillingDetails(
      "",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );
    var shippingDetails = ShippingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.KNET_DEBIT);
    apms.add(PaymentSdkAPms.APPLE_PAY);
    var configuration = PaymentSdkConfigurationDetails(
      profileId: "45213",
      serverKey: "SBJNLZMHZG-JJND2BM6JR-6H96BWMMBJ",
      clientKey: "CPKMD6-D67G66-QDM2NG-GPG7MH",
      cartId: "12433",
      cartDescription: "Flowers",
      merchantName: "Flowers Store",
      screentTitle: "Pay with Card",
      amount: double.parse(widget.paymentMedicalServicesArgs!.price.toString()),
      showBillingInfo: true,
      forceShippingInfo: false,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      alternativePaymentMethods: apms,
      linkBillingNameWithCardHolderName: true,
    );

    var theme = IOSThemeConfigurations();
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed() async {
    UserRequestsCubit cubit = UserRequestsCubit.get(context);
    FlutterPaymentSdkBridge.startCardPayment(generateConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          if (transactionDetails["isSuccess"]) {
            cubit.sendVisitRequest(
              requestParameters: RequestAmpParameters(
                formLat: cubit.userCurrentPosition?.latitude ?? 0,
                formLong: cubit.userCurrentPosition?.longitude ?? 0,
                serviceId: widget.paymentMedicalServicesArgs!.servicesId,
                subServiceId: widget.paymentMedicalServicesArgs!.subServicesId,
                formAddress: cubit.fromAddress,
                infectiousDiseases: cubit.infectiousDiseases.name,
                natId: cubit.nationality?.id.toString() ?? "0",
                orderDate: Jiffy.parse(cubit.orderDate!.toString()).format(pattern: 'yyyy/MM/dd'),
                orderTime: cubit.orderTime?.format(context),
                patientName: cubit.patientNameController.text,
                payData: DateTime.now().timeZoneName,
                payMethod: "visa",
                relationId: cubit.selectedRelation?.id.toString(),
                sex: cubit.sexEnum.name,
                toAddressName: cubit.toAddress,
                transactionId: transactionDetails["transactionReference"],
              ),
            );
            if (transactionDetails["isPending"]) {}
          } else {}

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الدفع",
        ),
      ),
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {
          if (state is SendVisitRequestLoadingState) {
            showProgressIndicator(context);
          } else if (state is SendVisitRequestSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ScreenName.userMainLayoutScreen,
              (route) => false,
            );
            UserRequestsCubit.get(context).handleSentParameters();
            showToast(errorType: 0, message: state.baseResponseModel?.message ?? "");
          }
        },
        builder: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              PaymentButton(
                isSelected: paymentMethodType == 0,
                title: "بطاقة ائتمان",
                assetName: SvgPath.card,
                onPressed: () {
                  paymentMethodType = 0;
                  setState(() {});
                },
              ),
              // const CustomSizedBox(
              //   height: 16,
              // ),
              // PaymentButton(
              //   isSelected: paymentMethodType == 1,
              //   title: "محفظة الكترونية",
              //   onPressed: () {
              //     paymentMethodType = 1;
              //     setState(() {});
              //   },
              //   assetName: SvgPath.wallet,
              // ),
              const CustomSizedBox(
                height: 16,
              ),
              PaymentButton(
                isSelected: paymentMethodType == 2,
                title: "الدفع عند الوصول",
                onPressed: () {
                  paymentMethodType = 2;
                  setState(() {});
                },
                assetName: SvgPath.arival,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              // if (paymentMethodType == 0) const CardComponent(),
              // if (paymentMethodType == 1)
              //   const WalletComponent(
              //     isCodeSent: false,
              //   ),
              // if (paymentMethodType != 2)
              //   const CustomSizedBox(
              //     height: 16,
              //   ),
              Divider(
                color: AppColors.greyColorD3,
                thickness: 1.w,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              Text(
                "ملخص الدفع",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const CustomSizedBox(
                height: 16,
              ),
              PaymentSummaryWidget(
                title: widget.paymentMedicalServicesArgs?.description ?? "",
                price: widget.paymentMedicalServicesArgs?.price ?? "",
              ),
              const CustomSizedBox(
                height: 16,
              ),
              Divider(
                color: AppColors.greyColorD3,
                thickness: 1.w,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الاجمالى",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${widget.paymentMedicalServicesArgs?.totalPrice ?? ""} ريال",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(
                height: 32,
              ),
              CustomElevatedButton(
                text: "تأكيد الدفع",
                onPressed: () {
                  if (paymentMethodType == 0) {
                    payPressed();
                  } else {
                    cubit.sendVisitRequest(
                      requestParameters: RequestAmpParameters(
                          formLat: cubit.userCurrentPosition?.latitude ?? 0,
                          formLong: cubit.userCurrentPosition?.longitude ?? 0,
                          toLat: cubit.userDestinationPosition?.latitude ?? 0.0,
                          toLong: cubit.userDestinationPosition?.longitude ?? 0.0,
                          trip: cubit.tripEnum.name,
                          makkah: cubit.mekkahEnum.name,
                          doctor: cubit.needDoctorInsideAmb.name,
                          bookingFlight: cubit.bookingFlight.name,
                          bookingImage: cubit.bookingFile,
                          formAddress: cubit.fromAddress,
                          toAddress: cubit.toAddress,
                          infectiousDiseases: cubit.infectiousDiseases.name,
                          natId: cubit.nationality?.id.toString() ?? "0",
                          needsOxygen: cubit.needOxygen.name,
                          orderDate: Jiffy.parse(cubit.orderDate!.toString())
                              .format(pattern: 'yyyy/MM/dd'),
                          orderTime: cubit.orderTime?.format(context),
                          patientName: cubit.patientNameController.text,
                          payData: DateTime.now().timeZoneName,
                          payMethod: null,
                          serviceId: widget.paymentMedicalServicesArgs!.servicesId,
                          subServiceId: widget.paymentMedicalServicesArgs!.subServicesId,
                          relationId: cubit.selectedRelation?.id.toString(),
                          sex: cubit.sexEnum.name,
                          toAddressName: cubit.toAddress,
                          urinaryCatheter: cubit.urinaryCatheter.name,
                          weight: cubit.patientWeightController.text),
                    );
                  }
                },
                padding: EdgeInsets.symmetric(vertical: 16.h),
                backgroundColor: AppColors.primaryColor,
                titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
