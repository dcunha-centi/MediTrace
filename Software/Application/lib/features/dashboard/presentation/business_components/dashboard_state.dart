part of 'dashboard_cubit.dart';

class DashboardInitialState extends ApplicationState {
  const DashboardInitialState();
}

class DashboardNumberUpdatedState extends ApplicationState{
  final int newNumber;

  const DashboardNumberUpdatedState ({required this.newNumber});
}

class DashboardChartDataLoadedState extends ApplicationState{
  final List<double> chartData;

  const DashboardChartDataLoadedState ({required this.chartData});
}
