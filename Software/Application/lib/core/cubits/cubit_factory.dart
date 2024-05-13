import 'package:meditrace/core/data/repositories/measurement_repository/measurement_repository_impl.dart';
import 'package:meditrace/core/data/repositories/movement_repository/movement_repository_impl.dart';
import 'package:meditrace/core/data/repositories/transportBox_repository/transportBox_repository_impl.dart';
import 'package:meditrace/features/dashboard/domain/use_cases/dashboard_use_case_impl.dart';
import 'package:meditrace/features/dashboard/presentation/business_components/dashboard_cubit.dart';

class CubitFactory {
  static DashboardCubit get measurementCubit => DashboardCubit(
      dashboardUseCase: DashboardUseCaseImpl(
          measurementRepository: MeasurementRepositoryImpl(),
          transportBoxRepository: TransportBoxRepositoryImpl(),
          movementRepository: MovementRepositoryImpl()));
}
