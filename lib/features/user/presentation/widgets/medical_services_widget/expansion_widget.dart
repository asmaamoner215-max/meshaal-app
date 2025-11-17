import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/assets_path/svg_path.dart';
import '../../../../../core/app_theme/custom_themes.dart';


class ExpansionWidget extends StatefulWidget {
  final String title;
  final String body;

  const ExpansionWidget({super.key, required this.title, required this.body});

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget>
    with TickerProviderStateMixin {
  late Animation<double> arrowAnimation;
  late AnimationController arrowAnimationController;
  late Animation<double> boxAnimation;
  late AnimationController boxAnimationController;

  @override
  void initState() {
    super.initState();
    arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    boxAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    arrowAnimation =
        Tween<double>(begin: 0, end: -0.25).animate(arrowAnimationController);
    boxAnimation = CurvedAnimation(
      parent: boxAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity:
          const VisualDensity(vertical: VisualDensity.minimumDensity),
          onTap: () {
            if (!isExpanded) {
              boxAnimationController.forward();
              arrowAnimationController.forward();
              isExpanded = true;
              setState(() {});
            } else {
              boxAnimationController.reverse();
              arrowAnimationController.reverse();
              isExpanded = false;
              setState(() {});
            }
          },
          title: Text(
            widget.title,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: RotationTransition(
              turns: arrowAnimation,
              child: SvgPicture.asset(
                SvgPath.arrowRight,
              )),
        ),
        SizeTransition(
          sizeFactor: boxAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.greyColorF6,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            child: Text(
              widget.body,
              textAlign: TextAlign.center,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }
}