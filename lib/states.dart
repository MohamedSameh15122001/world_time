abstract class MainStates {}

//init state
class MainInitial extends MainStates {}

class ChangeContinent extends MainStates {}

class ChangeCity extends MainStates {}

//get home data
class LoadingHomeState extends MainStates {}

class SuccessHomeState extends MainStates {
  final allContries;

  SuccessHomeState(this.allContries);
}

class ErrorHomeState extends MainStates {}

class LoadingCitiesState extends MainStates {}

class SuccessCitiesState extends MainStates {}

class ErrorCitiesState extends MainStates {}

class LoadingTimeState extends MainStates {}

class SuccessTimeState extends MainStates {}

class ErrorTimeState extends MainStates {}
