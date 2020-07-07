import 'dart:collection';

import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/logger.dart';
import 'package:injectable/injectable.dart';

import 'api.dart';

final log = getLogger('TokenApi');
final int DEV_TYPE_ANDROID = 3;

@lazySingleton
class TokenApi {
  final Api _api = locator<Api>();
  String encryptKey;
  String apiUrl;
  String nameSpace;
  String token;
  String userID;
  String appName;
  bool isDebug;

  String getEncryptKey() {
    return encryptKey;
  }
  void setEncryptKey(String encryptKey) {
    this.encryptKey = encryptKey;
  }
  String getApiUrl() {
    return apiUrl;
  }
  void setApiUrl(String apiUrl) {
    this.apiUrl = apiUrl;
  }
  String getToken() {
    return token;
  }
  void setToken(String token) {
    this.token = token;
  }

  bool init(bool isDebug, String url, int timeout, String appName) {
    log.d("init() called with: isDebug = [" + isDebug.toString() + "], url = [" + url + "], timeout = [" + timeout.toString() + "], appName = [" + appName + "]");
    bool isSuccess = false;
    this.isDebug = isDebug;
    this.apiUrl = url;
    this.appName = appName;

    try {
      Api().init(timeout);
    } catch  (e) {
      e.printStackTrace();
      return isSuccess;
    }
    isSuccess = true;
    return isSuccess;
  }

  /**
   * App取得存取權限
   *
   * @param UserID
   * @param PWD
   * @param UUID
   * @param OSVer
   * @param ApVer
   * @param ApName
   * @param MobileId
   * @return
   */

  Future<dynamic> GetAuthToken(String UserID, String PWD, String UUID, String OSVer,
      String ApVer, String ApName, String MobileId, String PnToken) async {

    log.i("GetAuthToken: {UserID: $UserID  PWD: $PWD}");
    HashMap<String, String> data = new HashMap<String, String>();
    data.addAll({
      "UserID" : UserID,
      "PWD" : PWD,
      //Android10 開始只帶入UUID至DevNewHID，DevHID與DevHID2帶空值
      "DevHID" : "", //IMEI
      "DevHID2" : "", //IMSI
      "DevNewHID" : UUID,
      "OSVer" : OSVer,
      "ApVer" : ApVer,
      "ApName" : ApName,
      "MobileId" : MobileId,
      "PnToken" : PnToken,
      "DevType" : DEV_TYPE_ANDROID.toString()
    });
    HashMap<String, String> header = new HashMap<String, String>();
    header.addAll({"Content-Type" : "application/json"});
    Map<String, dynamic> httpResult = await _api.post(this.apiUrl, "taGetAuthToken",
        data, header);


    return httpResult;
  }
}