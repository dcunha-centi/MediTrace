import 'package:generic_project/core/data/repositories/medication_repository/medication_repository.dart';
import 'package:generic_project/features/home/domain/use_cases/home_use_case.dart';

class HomeUseCaseImpl implements HomeUseCase{
  final MedicationRepository medicationRepository;
  const HomeUseCaseImpl({required this.medicationRepository});

  @override
  Future<void> getMedications() async {
    medicationRepository.getMedication();
  }
}