import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/payment/apple_pay_service.dart';

class ApplePayCheckoutButton extends StatefulWidget {
  final double amount;
  final String description;
  final void Function(String? transactionRef)? onSuccess;
  final void Function(String? errorMessage)? onError;

  const ApplePayCheckoutButton({
    super.key,
    required this.amount,
    required this.description,
    this.onSuccess,
    this.onError,
  });

  @override
  State<ApplePayCheckoutButton> createState() => _ApplePayCheckoutButtonState();
}

class _ApplePayCheckoutButtonState extends State<ApplePayCheckoutButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _loading ? null : _onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        icon: const Icon(Icons.apple, size: 24),
        label: Text(
          'الدفع عبر Apple Pay',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    setState(() => _loading = true);
    HapticFeedback.lightImpact();

    final service = const ApplePayService();
    final result = await service.payWithApplePay(
      amount: widget.amount,
      cartDescription: widget.description,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result.ok) {
      widget.onSuccess?.call(result.transactionReference);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الدفع بنجاح')),
      );
    } else {
      // Print detailed error for debugging
      print('Apple Pay Error: ${result.message}');
      print('Apple Pay Raw Response: ${result.raw}');
      
      widget.onError?.call(result.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'فشل الدفع')),
      );
    }
  }
}
