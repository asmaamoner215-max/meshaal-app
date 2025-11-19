import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weam/core/network/error_message_model.dart';
import 'package:weam/features/user/data/models/get_services_model.dart';

import '../../../../core/models/base_response_model.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/services_data_source.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesDataSource _servicesDataSource = sl();
  ServicesCubit() : super(ServicesInitial());

  static ServicesCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  bool getServicesLoading = false;
  GetServicesModel? getServicesModel;
  void getServices() async {
    getServicesLoading = true;
    emit(GetServicesLoadingState());

    final response = await _servicesDataSource.getServices();
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        getServicesLoading = false;
        print('Services Error: ${l.baseErrorModel.message}');
        emit(
          GetServicesErrorState(error: l.baseErrorModel.message),
        );
      },
          (r) async {
        getServicesModel = r;
        getServicesLoading = false;
        print('Services Success: ${getServicesModel?.data?.length} services loaded');
        print(getServicesModel?.data?[0].subs);
        emit(
          GetServicesSuccessState(getServicesModel: r),
        );
      },
    );
  }
}
