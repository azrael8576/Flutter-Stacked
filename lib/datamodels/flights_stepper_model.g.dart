// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flights_stepper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightsStepperModel _$FlightsStepperModelFromJson(Map<String, dynamic> json) {
  return FlightsStepperModel(
    json['number'] as String,
    json['question'] as String,
    (json['answers'] as List)?.map((e) => e as String)?.toList(),
  )
    ..status = json['Status'] as String ?? ''
    ..errDesc = json['ErrDesc'] as String ?? ''
    ..desc = json['Desc'] as String ?? '';
}

Map<String, dynamic> _$FlightsStepperModelToJson(
        FlightsStepperModel instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'ErrDesc': instance.errDesc,
      'Desc': instance.desc,
      'number': instance.number,
      'question': instance.question,
      'answers': instance.answers,
    };
