import 'package:get_storage/get_storage.dart';

class PreferenceManagerUtils {
  static GetStorage getStorage = GetStorage();

  static String token = 'token';
  static String isLogin = 'isLogin';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String profile = 'profile';
  static String userName = 'userName';
  static String restoID = 'restoID';
  static String offerId = 'offerId';
  static String city = 'city';

  ///TOKEN
  static Future setToken(String? value) async {
    await getStorage.write(token, value);
  }

  static String getToken() {
    return getStorage.read(token) ?? '';
  }

  /// is Login
  static Future setIsLogin(String? value) async {
    await getStorage.write(isLogin, value);
  }

  static String getIsLogin() {
    return getStorage.read(isLogin) ?? '';
  }

  /// latitude
  static Future setLatitude(String? value) async {
    await getStorage.write(latitude, value);
  }

  static String getLatitude() {
    return getStorage.read(latitude) ?? '';
  }

  /// longitude
  static Future setLongitude(String? value) async {
    await getStorage.write(longitude, value);
  }

  static String getLongitude() {
    return getStorage.read(longitude) ?? '';
  }

  /// profile
  static Future setProfile(String? value) async {
    await getStorage.write(profile, value);
  }

  static String getProfile() {
    return getStorage.read(profile) ?? '';
  } /// cityName
  static Future setCity(String? value) async {
    await getStorage.write(city, value);
  }

  static String getCity() {
    return getStorage.read(city) ?? '';
  }

  /// user name
  static Future setUserName(String? value) async {
    await getStorage.write(userName, value);
  }

  static String getUserName() {
    return getStorage.read(userName) ?? '';
  }

  /// resto id
  static Future setRestoId(String? value) async {
    await getStorage.write(restoID, value);
  }

  static String getRestoId() {
    return getStorage.read(restoID) ?? '';
  }

  /// offer id
  static Future setOfferId(String? value) async {
    await getStorage.write(offerId, value);
  }

  static String getOfferId() {
    return getStorage.read(offerId) ?? '';
  }

  ///logout

  static Future clearPreference() async {
    // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // await firebaseMessaging.deleteToken();
    await getStorage.erase();
    // await NotificationMethods.getFcmToken();
  }
}
