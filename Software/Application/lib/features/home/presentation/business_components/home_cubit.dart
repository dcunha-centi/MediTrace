import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_state.dart';
import 'package:generic_project/features/home/domain/use_cases/home_use_case.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<ApplicationState> {
  HomeCubit({required this.homeUseCase}) : super(const HomeInitialState());
  final HomeUseCase homeUseCase;

  void updateNumber(int number) {
    try {
      emit(const ApplicationLoadingState());
      Future.delayed(
        const Duration(seconds: 1),
        () {
          emit(HomeNumberUpdatedState(newNumber: ++number));
        },
      );
    } catch (e) {}
  }

  void getMedications()async {
    homeUseCase.getMedications();
  }
}
