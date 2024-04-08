part of 'temprature_cubit.dart';

class TempratureInitialState extends ApplicationState {
  const TempratureInitialState();
}

class TempratureNumberUpdatedState extends ApplicationState{
  final int newNumber;

  const TempratureNumberUpdatedState ({required this.newNumber});
}

class TempratureChartDataLoadedState extends ApplicationState{
  final List<double> chartData;

  const TempratureChartDataLoadedState ({required this.chartData});
}
