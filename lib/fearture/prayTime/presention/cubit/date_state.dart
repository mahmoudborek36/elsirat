class DateState {}

class DateAlitilState extends DateState {}

class DatesuccessState extends DateState {}

class DateLoadingState extends DateState {}

class DaterrorState extends DateState {
  String erroe;
  DaterrorState({required this.erroe});
}
