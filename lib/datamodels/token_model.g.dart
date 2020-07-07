// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) {
  return TokenModel(
    json['GKey'] as String ?? '',
    json['UserID'] as String ?? '',
    json['UserName'] as String ?? '',
    json['UserPhone'] as String ?? '',
    json['DeptID'] as String ?? '',
    json['DeptZip'] as String ?? '',
    json['DeptName'] as String ?? '',
    json['DeptLat'] as String ?? '',
    json['DeptLng'] as String ?? '',
    json['DeptType'] as String ?? '',
    json['JobID'] as String ?? '',
    json['JobName'] as String ?? '',
    json['JobTitle'] as String ?? '',
    json['DebugModel'] as String ?? '',
    json['UpperDeptID'] as String ?? '',
    json['UpperDeptName'] as String ?? '',
    json['CompanyID'] as String ?? '',
    json['Popup'] as String ?? '',
  )
    ..status = json['Status'] as String ?? ''
    ..errDesc = json['ErrDesc'] as String ?? ''
    ..desc = json['Desc'] as String ?? ''
    ..password = json['Password'] as String ?? '';
}

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'ErrDesc': instance.errDesc,
      'Desc': instance.desc,
      'GKey': instance.gKey,
      'UserID': instance.userID,
      'UserName': instance.userName,
      'UserPhone': instance.userPhone,
      'DeptID': instance.deptID,
      'DeptZip': instance.deptZip,
      'DeptName': instance.deptName,
      'DeptLat': instance.deptLat,
      'DeptLng': instance.deptLng,
      'DeptType': instance.deptType,
      'JobID': instance.jobID,
      'JobName': instance.jobName,
      'JobTitle': instance.jobTitle,
      'DebugModel': instance.debugModel,
      'UpperDeptID': instance.upperDeptID,
      'UpperDeptName': instance.upperDeptName,
      'CompanyID': instance.companyID,
      'Popup': instance.popup,
      'Password': instance.password,
    };
