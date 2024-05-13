part of 'dashboard_cubit.dart';

class DashboardInitialState extends ApplicationState {
  const DashboardInitialState();
}

class DashboardNumberUpdatedState extends ApplicationState{
  final int newNumber;

  const DashboardNumberUpdatedState ({required this.newNumber});
}

class DashboardChartDataLoadedState extends ApplicationState{
  final List<MeasurementModel> chartData;

  const DashboardChartDataLoadedState ({required this.chartData});
}

class DashboardTransportBoxLoadedState extends ApplicationState{
  final List<TransportBoxModel> transportBoxes;

  const DashboardTransportBoxLoadedState ({required this.transportBoxes});
}

class DashboardMovementInLoadedState extends ApplicationState{
  final List<MovementModel> movementsIn;

  const DashboardMovementInLoadedState ({required this.movementsIn});
}

class DashboardMovementOutLoadedState extends ApplicationState{
  final List<MovementModel> movementsOut;

  const DashboardMovementOutLoadedState ({required this.movementsOut});
}

class UpdateDataLoadedState extends ApplicationState{
  final List<MovementModel> movementsOut;
  final List<MovementModel> movementsIn;
  final List<MeasurementModel> chartData;

  const UpdateDataLoadedState ({required this.movementsOut, required this.movementsIn, required this.chartData});
}


