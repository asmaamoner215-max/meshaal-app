import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../features/user/buisness_logic/user_orders/user_orders_cubit.dart';
import '../../../../features/user/presentation/screens/profile_screen.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  @override
  void initState() {
    UserOrdersCubit.get(context).getMyInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الفواتير",
        ),
      ),
      body: BlocConsumer<UserOrdersCubit, UserOrdersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          UserOrdersCubit cubit = UserOrdersCubit.get(context);
          return cubit.getMyInvoicesLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (_, index) {
                    return ProfileItemWidget(
                      title: cubit.getMyInvoicesModel?.data?[index].fatoraName ?? "",
                      assetPath: SvgPath.taskSquare,
                      onPressed: () {
                        Navigator.pushNamed(context, ScreenName.resetDetailsScreen,
                            arguments: cubit.getMyInvoicesModel!.data![index]);
                      },
                    );
                  },
                  itemCount: cubit.getMyInvoicesModel?.data?.length ?? 0,
                );
        },
      ),
    );
  }
}
