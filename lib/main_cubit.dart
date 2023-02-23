import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:world_time/states.dart';
import 'package:http/http.dart' as http;

class MainCubit extends Cubit<MainStates> {
  // MainCubit(super.initialState);
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  //Continents varibales
  List allContinents = [];
  String selectedContinent = 'Africa';
  //Cities variables
  List allCities = [];
  String selectedCity = 'Cairo';
  //time variable
  var time;

  Future fetchData() async {
    emit(LoadingHomeState());
    final response =
        await http.get(Uri.parse('https://worldtimeapi.org/api/timezone'));
    if (response.statusCode == 200) {
      allContinents = await jsonDecode(response.body);

      allContinents = getContinents(allContinents);
      allContinents = removeDuplicates(allContinents);
      emit(SuccessHomeState(allContinents));

      await fetchCities(selectedContinent);

      String continentAndCity = '$selectedContinent/$selectedCity';
      await fetchTime(continentAndCity);
    } else {
      emit(ErrorHomeState());
      throw Exception('Failed to load data');
    }
  }

  //gets only the name of the Continents from start to /
  List<String> getContinents(timeZoneList) {
    List<String> result = [];

    for (String timeZone in timeZoneList) {
      int index = timeZone.indexOf('/');
      if (index >= 0) {
        result.add(timeZone.substring(0, index));
      }
    }

    return result;
  }

  // remove Duplicate values
  List<String> removeDuplicates(list) {
    // Create an empty set to store unique values
    Set<String> uniqueSet = {};

    // Iterate over each element in the list
    for (String element in list) {
      // If the set does not contain the element, add it to the set
      if (!uniqueSet.contains(element)) {
        uniqueSet.add(element);
      }
    }

    // Convert the set back to a list
    List<String> uniqueList = uniqueSet.toList();

    return uniqueList;
  }

//change the value of continent dropdownbutton

  changeContinent(newValue) {
    selectedContinent = newValue;
    emit(ChangeContinent());
  }

  //-------------------------------------

  Future fetchCities(continentName) async {
    emit(LoadingCitiesState());
    final response = await http
        .get(Uri.parse('https://worldtimeapi.org/api/timezone/$continentName'));
    if (response.statusCode == 200) {
      allCities = await jsonDecode(response.body);

      allCities = getCities(allCities);
      emit(SuccessCitiesState());
    } else {
      emit(ErrorCitiesState());
      throw Exception('Failed to load data');
    }
  }

  //to get the cities from / to the last
  List<String> getCities(inputList) {
    List<String> outputList = [];
    for (String str in inputList) {
      List<String> splitStr = str.split('/');
      outputList.add(splitStr.last);
    }
    return outputList;
  }

  //change the value of City dropdownbutton

  changeCity(newValue) {
    selectedCity = newValue;
    emit(ChangeCity());
  }
  //-------------------------------------

  Future fetchTime(continentAndCity) async {
    emit(LoadingTimeState());
    final response = await http.get(
        Uri.parse('https://worldtimeapi.org/api/timezone/$continentAndCity'));
    if (response.statusCode == 200) {
      time = await jsonDecode(response.body);
      String datetime = time['datetime'];
      String offset = time['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(now);

      emit(SuccessTimeState());
    } else {
      emit(ErrorTimeState());
      throw Exception('Failed to load data');
    }
  }
}
