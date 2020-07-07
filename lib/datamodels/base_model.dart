import 'package:json_annotation/json_annotation.dart';
abstract class BaseModel{
  @JsonKey(name: 'Status', defaultValue: '')
  String status;
  @JsonKey(name: 'ErrDesc', defaultValue: '')
  String errDesc;
  @JsonKey(name: 'Desc', defaultValue: '')
  String desc;
}