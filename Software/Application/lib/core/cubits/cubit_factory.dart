
import 'package:generic_project/core/data/repositories/medication_repository/medication_repository_impl.dart';
import 'package:generic_project/features/home/domain/use_cases/home_use_case_impl.dart';
import 'package:generic_project/features/home/presentation/business_components/home_cubit.dart';

class CubitFactory {
  static HomeCubit get homeCubit => HomeCubit(homeUseCase: HomeUseCaseImpl(medicationRepository: MedicationRepositoryImpl()));
}
