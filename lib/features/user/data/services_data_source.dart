import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weam/features/user/data/models/get_services_model.dart';


import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';

class ServicesDataSource {
  final DioHelper dioHelper;

  ServicesDataSource({required this.dioHelper,});



  Future<Either<ErrorException, GetServicesModel>> getServices() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.getServices,
      );
      if (response.data == null) {
        return const Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: 'No data received from server',
              status: false,
            ),
          ),
        );
      }
      return Right(GetServicesModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: e.message ?? 'خطأ في تحميل البيانات',
              status: false,
            ),
          ),
        );
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: e.toString(),
              status: false,
            ),
          ),
        );
      }
    }
  }
}
