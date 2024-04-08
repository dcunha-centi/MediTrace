import 'package:generic_project/core/data/repositories/medication_repository/medication_repository.dart';
import 'package:generic_project/features/dashboard/domain/use_cases/temprature_use_case.dart';

class TempratureUseCaseImpl implements TempratureUseCase{
  final MedicationRepository medicationRepository;
  const TempratureUseCaseImpl({required this.medicationRepository});

  @override
  Future<void> getMedications() async {
    medicationRepository.getMedication();
  }
}