
import 'package:generic_project/core/data/repositories/medication_repository/medication_repository_impl.dart';
import 'package:generic_project/features/dashboard/domain/use_cases/dashboard_use_case_impl.dart';
import 'package:generic_project/features/dashboard/presentation/business_components/dashboard_cubit.dart';

class CubitFactory {
  static DashboardCubit get dashboardCubit => DashboardCubit(dashboardUseCase: DashboardUseCaseImpl(medicationRepository: MedicationRepositoryImpl()));
}
