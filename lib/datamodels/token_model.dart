import 'package:flutterstacked/datamodels/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel extends BaseModel{
  TokenModel(this.gKey , this.userID, this.userName, this.userPhone,
      this.deptID, this.deptZip, this.deptName, this.deptLat,
      this.deptLng, this.deptType, this.jobID, this.jobName,
      this.jobTitle, this.debugModel, this.upperDeptID, this.upperDeptName,
      this.companyID, this.popup);
  static final String TAG = "JToken";

  @JsonKey(name: 'GKey', defaultValue: '')
  String gKey;
  @JsonKey(name: 'UserID', defaultValue: '')
  String userID;
  @JsonKey(name: 'UserName', defaultValue: '')
  String userName;
  @JsonKey(name: 'UserPhone', defaultValue: '')
  String userPhone;
  @JsonKey(name: 'DeptID', defaultValue: '')
  String deptID;
  @JsonKey(name: 'DeptZip', defaultValue: '')
  String deptZip;
  @JsonKey(name: 'DeptName', defaultValue: '')
  String deptName;
  @JsonKey(name: 'DeptLat', defaultValue: '')
  String deptLat;
  @JsonKey(name: 'DeptLng', defaultValue: '')
  String deptLng;
  @JsonKey(name: 'DeptType', defaultValue: '')
  String deptType;
  @JsonKey(name: 'JobID', defaultValue: '')
  String jobID;
  @JsonKey(name: 'JobName', defaultValue: '')
  String jobName;
  @JsonKey(name: 'JobTitle', defaultValue: '')
  String jobTitle;
  @JsonKey(name: 'DebugModel', defaultValue: '')
  String debugModel;
  @JsonKey(name: 'UpperDeptID', defaultValue: '')
  String upperDeptID;
  @JsonKey(name: 'UpperDeptName', defaultValue: '')
  String upperDeptName;
  @JsonKey(name: 'CompanyID', defaultValue: '')
  String companyID;
  @JsonKey(name: 'Popup', defaultValue: '')
  String popup;
  @JsonKey(name: 'Password', defaultValue: '')
  String password;

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
  Map<String, dynamic>toJson() => _$TokenModelToJson(this);
}