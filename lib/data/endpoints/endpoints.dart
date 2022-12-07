abstract class EndPoints {
  static const String _baseUrl = 'http://www.boulouservice.com/api';

  static const String allUsers = '$_baseUrl/users/all';
  static const String sendOTP = '$_baseUrl/sendotp';
  static const String forgotPassword = '$_baseUrl/forgotpassword';
  static const String login = '$_baseUrl/login';
  static const String register = '$_baseUrl/register';
  static const String profile = '$_baseUrl/profile';
  static const String addVehicle = '$_baseUrl/addvehicle';
  static const String getProfile = '$_baseUrl/getprofile';
  static const String getVehicle = '$_baseUrl/vehicle';
  static const String editVehicle = '$_baseUrl/editvehicle';
  static const String getProviderList = '$_baseUrl/serviceprovider';
  static const String getCategoryList = '$_baseUrl/category';
  static const String serviceBooking = '$_baseUrl/booking';
  static const String banner = '$_baseUrl/banner';
  static const String myBooking = '$_baseUrl/mybooking';
  static const String marketVehicle = '$_baseUrl/marketvehicle';
  static const String marketallvehicle = '$_baseUrl/marketallvehicle';
  static const String addmarketvehicle = '$_baseUrl/addmarketvehicle';
  static const String editmarketvehicle = '$_baseUrl/editmarketvehicle';
  static const String getCard = '$_baseUrl/getcard';
  static const String chargeUser = '$_baseUrl/chargeuser';
  static const String addFeedback = '$_baseUrl/addfeedback';
  static const String addCard = '$_baseUrl/addcard';
  static const String deleteMyMarketPlaceVehicle = '$_baseUrl/deletemarketallvehicle';
  static const String markAsComplete = '$_baseUrl/markcomplete';
  static const String socialLoginUrl = '$_baseUrl/sociallogin';
}
