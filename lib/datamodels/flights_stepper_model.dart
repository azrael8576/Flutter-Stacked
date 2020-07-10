import 'package:flutter/material.dart';
import 'package:flutterstacked/datamodels/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flights_stepper_model.g.dart';

@JsonSerializable()
class FlightsStepperModel extends BaseModel {
  FlightsStepperModel(
      this.number, this.question, this.answers);

  String number;
  String question;
  List<String> answers;

  factory FlightsStepperModel.fromJson(Map<String, dynamic> json) => _$FlightsStepperModelFromJson(json);
  Map<String, dynamic>toJson() => _$FlightsStepperModelToJson(this);
}
