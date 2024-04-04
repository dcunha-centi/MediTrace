import 'package:generic_project/core/data/repositories/medication_repository/medication_repository.dart';
import 'package:generic_project/features/dashboard/domain/use_cases/dashboard_use_case.dart';

class DashboardUseCaseImpl implements DashboardUseCase{
  final MedicationRepository medicationRepository;
  const DashboardUseCaseImpl({required this.medicationRepository});

  @override
  Future<void> getMedications() async {
    medicationRepository.getMedication();
  }
}