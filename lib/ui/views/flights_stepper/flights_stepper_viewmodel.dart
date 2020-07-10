import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterstacked/datamodels/flights_stepper_model.dart';
import 'package:flutterstacked/logger.dart';
import 'package:stacked/stacked.dart';

class FlightsStepperViewModel extends BaseViewModel {
  final log = getLogger('FlightsStepperViewModel');
  String _title = 'Flights Stepper View';
  List<FlightsStepperModel> _flightsStepperModelList;
  String testData =
      '[{"number": "01","question": "Do you typically fly for business, personal reasons, or some other reason?","answers": ["Business", "Personal", "Others"]},{"number": "02","question":"How many hours is your average flight?","answers": ["Less than two hours", "More than two but less than five hours", "Others"]}]';

  @protected
  set flightsStepperModelList(List<FlightsStepperModel> list) {
    _flightsStepperModelList = list;
  }

  String get title => _title;

  List<FlightsStepperModel> get flightsStepperModelList =>
      _flightsStepperModelList;

  void parseData() {
    _flightsStepperModelList = new List();
    List<dynamic> list = jsonDecode(testData);
    for (dynamic flightsStepperModel in list) {
      _flightsStepperModelList
          .add(FlightsStepperModel.fromJson(flightsStepperModel));
    }
  }
}
