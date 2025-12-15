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
import '../../../../core/payment/clickpay_credentials.dart';
import 'package:weam/features/payments/apple_pay_button.dart';
import 'dart:io' show Platform;
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/enums/trip_enum.dart';
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

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int paymentMethodType = 0;

  PaymentSdkConfigurationDetails generateConfig() {
    var billingDetails = BillingDetails(
      "",
      "dummy@email.com",
      "+20000000000",
      "address line",
      "eg",
      "saudi",
      "saudi",
      "12345",
    );
    var shippingDetails = ShippingDetails(
      "Dummy name",
      "dummy@email.com",
      "+20000000000",
      "address line",
      "eg",
      "saudi",
      "saudi",
      "12345",
    );
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.KNET_DEBIT);
    apms.add(PaymentSdkAPms.APPLE_PAY);
    var configuration = PaymentSdkConfigurationDetails(
      profileId: ClickPayCredentials.profileId,
      serverKey: ClickPayCredentials.serverKey,
      clientKey: ClickPayCredentials.clientKey,
      cartId: DateTime.now().millisecondsSinceEpoch.toString(),
      cartDescription: "Ambulance Request",
      merchantName: ClickPayCredentials.merchantDisplayName,
      screentTitle: "Pay with Card",
      amount: double.parse(UserRequestsCubit.get(context).priceModel!.total.toString()),
      showBillingInfo: true,
      forceShippingInfo: false,
      currencyCode: ClickPayCredentials.currencyCode,
      merchantCountryCode: ClickPayCredentials.countryCode,
      merchantApplePayIndentifier: ClickPayCredentials.appleMerchantId,
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
      print("print(transactionDetails);");
      print(event);
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print(cubit.fromAddress);
            print(cubit.toAddress);
            cubit.sendCarRequest(
              requestParameters: RequestAmpParameters(
                formLat: cubit.userCurrentPosition?.latitude ?? 0,
                formLong: cubit.userCurrentPosition?.longitude ?? 0,
                toLat: cubit.userDestinationPosition?.latitude ?? 0.0,
                toLong: cubit.userDestinationPosition?.longitude ?? 0.0,
                trip: cubit.tripEnum.name,
                makkah: cubit.mekkahEnum.name,
                couponId: cubit.promoModel?.promoId.toString(),
                sale: cubit.promoModel?.sale.toString(),
                saleTotal: cubit.promoModel?.total.toString(),
                doctor: cubit.needDoctorInsideAmb.name,
                bookingFlight: cubit.bookingFlight.name,
                bookingImage: cubit.bookingFile,
                formAddress: cubit.fromAddress,
                toAddress: cubit.toAddress,
                infectiousDiseases: cubit.infectiousDiseases.name,
                natId: cubit.nationality?.id.toString() ?? "0",
                needsOxygen: cubit.needOxygen.name,
                orderDate: Jiffy.parse(cubit.orderDate!.toString()).format(pattern: 'yyyy/MM/dd'),
                orderTime: cubit.orderTime?.format(context),
                patientName: cubit.patientNameController.text,
                payData: DateTime.now().timeZoneName,
                payMethod: "visa",
                relationId: cubit.selectedRelation?.id.toString(),
                sex: cubit.sexEnum.name,
                toAddressName: cubit.toAddress,
                transactionId: transactionDetails["transactionReference"],
                urinaryCatheter: cubit.urinaryCatheter.name,
                weight: cubit.patientWeightController.text,
              ),
            );
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
            showToast(errorType: 1, message: "فشلت عملية الدفع");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  // Apple Pay logic handled via callbacks on ApplePayCheckoutButton

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
          if (state is SendCarRequestLoadingState) {
            showProgressIndicator(context);
          } else if (state is SendCarRequestSuccessState) {
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
              //     isSelected: paymentMethodType == 1,
              //     title: "محفظة الكترونية",
              //     onPressed: () {
              //       paymentMethodType = 1;
              //       setState(() {});
              //     },
              //     assetName: SvgPath.wallet),
              const CustomSizedBox(height: 16),
              if (Platform.isIOS)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ApplePayCheckoutButton(
                    amount: double.parse(UserRequestsCubit.get(context).priceModel!.total.toString()),
                    description: 'Ambulance Request',
                    onSuccess: (ref) {
                      final cubit = UserRequestsCubit.get(context);
                      cubit.sendCarRequest(
                        requestParameters: RequestAmpParameters(
                          formLat: cubit.userCurrentPosition?.latitude ?? 0,
                          formLong: cubit.userCurrentPosition?.longitude ?? 0,
                          toLat: cubit.userDestinationPosition?.latitude ?? 0.0,
                          toLong: cubit.userDestinationPosition?.longitude ?? 0.0,
                          trip: cubit.tripEnum.name,
                          makkah: cubit.mekkahEnum.name,
                          couponId: cubit.promoModel?.promoId.toString(),
                          sale: cubit.promoModel?.sale.toString(),
                          saleTotal: cubit.promoModel?.total.toString(),
                          doctor: cubit.needDoctorInsideAmb.name,
                          bookingFlight: cubit.bookingFlight.name,
                          bookingImage: cubit.bookingFile,
                          formAddress: cubit.fromAddress,
                          toAddress: cubit.toAddress,
                          infectiousDiseases: cubit.infectiousDiseases.name,
                          natId: cubit.nationality?.id.toString() ?? '0',
                          needsOxygen: cubit.needOxygen.name,
                          orderDate: Jiffy.parse(cubit.orderDate!.toString()).format(pattern: 'yyyy/MM/dd'),
                          orderTime: cubit.orderTime?.format(context),
                          patientName: cubit.patientNameController.text,
                          payData: DateTime.now().timeZoneName,
                          payMethod: 'apple_pay',
                          relationId: cubit.selectedRelation?.id.toString(),
                          sex: cubit.sexEnum.name,
                          toAddressName: cubit.toAddress,
                          transactionId: ref ?? '',
                          urinaryCatheter: cubit.urinaryCatheter.name,
                          weight: cubit.patientWeightController.text,
                        ),
                      );
                    },
                    onError: (msg) {
                      showToast(errorType: 1, message: msg ?? 'فشل دفع Apple Pay');
                    },
                  ),
                ),
              // PaymentButton(
              //   isSelected: paymentMethodType == 2,
              //   title: "الدفع عند الوصول",
              //   onPressed: () {
              //     paymentMethodType = 2;
              //     setState(() {});
              //   },
              //   assetName: SvgPath.arival,
              // ),
              // const CustomSizedBox(
              //   height: 16,
              // ),
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
                title: cubit.tripEnum == TripEnum.go_back ? "توصيل ذهاب و عودة" : "توصيل ذهاب فقط",
                price: cubit.priceModel?.price ?? "",
              ),
              const CustomSizedBox(
                height: 16,
              ),
              PaymentSummaryWidget(
                title: "خدمة وجود ممرض/ة",
                price: cubit.priceModel?.doctor ?? "",
              ),
              const CustomSizedBox(
                height: 16,
              ),
              PaymentSummaryWidget(
                title: "ضريبة",
                price: cubit.priceModel?.taxTotal ?? "",
              ),
              //promo

              if (cubit.promoModel != null)
                const CustomSizedBox(
                  height: 16,
                ),
              if (cubit.promoModel != null)
                PaymentSummaryWidget(
                  title: "نسبة الخصم",
                  price: cubit.promoModel?.salePrice.toString() ?? "",
                ),
              if (cubit.promoModel != null)
                const CustomSizedBox(
                  height: 16,
                ),
              if (cubit.promoModel != null)
                PaymentSummaryWidget(
                  title: "السعر بعد الخصم",
                  price: cubit.promoModel?.total.toString() ?? "",
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
                  cubit.promoModel == null
                      ? Text(
                          "${cubit.priceModel?.total ?? ""} ريال",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: CustomThemes.primaryColorTextTheme(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            text: cubit.priceModel == null
                                ? "اطلب سعر"
                                : cubit.priceModel?.total ?? "",
                            style: cubit.promoModel != null
                                ? CustomThemes.greyColor49TextTheme(context).copyWith(
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppColors.greyColor49,
                                    fontWeight: FontWeight.w700,
                                  )
                                : CustomThemes.primaryColorTextTheme(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            children: [
                              if (cubit.promoModel != null)
                                TextSpan(
                                  text: "  ${cubit.promoModel?.total ?? ""} ",
                                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              TextSpan(
                                text: cubit.priceModel != null ? " ريـال" : "",
                                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
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
                  print(cubit.fromAddress);
                  print(cubit.toAddress);
                  if (paymentMethodType == 0) {
                    payPressed();
                  } else {
                    cubit.sendCarRequest(
                      requestParameters: RequestAmpParameters(
                        formLat: cubit.userCurrentPosition?.latitude ?? 0,
                        formLong: cubit.userCurrentPosition?.longitude ?? 0,
                        toLat: cubit.userDestinationPosition?.latitude ?? 0.0,
                        toLong: cubit.userDestinationPosition?.longitude ?? 0.0,
                        trip: cubit.tripEnum.name,
                        bedorchair: cubit.needsEnum.name,
                        details: cubit.detailsController.text,
                        floor: cubit.floorEnum.number.toString(),
                        makkah: cubit.mekkahEnum.name,
                        couponId: cubit.promoModel?.promoId.toString(),
                        sale: cubit.promoModel?.sale.toString(),
                        saleTotal: cubit.promoModel?.total.toString(),
                        doctor: cubit.needDoctorInsideAmb.name,
                        bookingFlight: cubit.bookingFlight.name,
                        bookingImage: cubit.bookingFile,
                        formAddress: cubit.fromAddress,
                        toAddress: cubit.toAddress,
                        infectiousDiseases: cubit.infectiousDiseases.name,
                        natId: cubit.nationality?.id.toString() ?? "0",
                        needsOxygen: cubit.needOxygen.name,
                        orderDate:
                            Jiffy.parse(cubit.orderDate!.toString()).format(pattern: 'yyyy/MM/dd'),
                        orderTime: cubit.orderTime?.format(context),
                        patientName: cubit.patientNameController.text,
                        payData: DateTime.now().timeZoneName,
                        payMethod: null,
                        relationId: cubit.selectedRelation?.id.toString(),
                        sex: cubit.sexEnum.name,
                        mesaad: cubit.mesaad.name,
                        toAddressName: cubit.toAddress,
                        urinaryCatheter: cubit.urinaryCatheter.name,
                        weight: cubit.patientWeightController.text,
                      ),
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
