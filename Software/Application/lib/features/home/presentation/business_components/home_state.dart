part of 'home_cubit.dart';

class HomeInitialState extends ApplicationState {
  const HomeInitialState();
}

class HomeNumberUpdatedState extends ApplicationState{
  final int newNumber;

  const HomeNumberUpdatedState ({required this.newNumber});
}
