class ApiConstants {
  static const String apiBaseUrl = "https://api.tvplus24.com/api";
  // fixtures/
  static const String fixtures = "/fixtures";
  static const String leagues = "/leagues";
  static const String calendar = "/calendar";
  static const String standings = "/standings";
  static const String team = "/team";
  static const String matches = "/matches";
  static const String topscorers = "/topscorers";
  static const String categories = "/categories";
  static const String todayMatches = "/today_matches";
  static const String allCategoriesWithChannels = "/all-with-channels";
  // LEAGUE_MATCHES
  static const String leagueMatches = "/league";

  //  final String baseUrl = 'https://api.tvplus24.com/api';

  // Define all endpoints as variables
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String updateUserDetailsEndpoint = '/auth/update';
  static const String updateUserPasswordEndpoint = '/auth/update-password';
  static const String updateUserEmailEndpoint = '/auth/update-email';
  static const String deleteUserEndpoint = '/auth/delete';
  static const String getAllUsersEndpoint = '/auth/all-users';
  static const String getUserDataEndpoint = '/auth/user';
  static const String sendResetOtp = '/auth/send-reset-otp';
  static const String resetPasswordWithOtp = '/auth//reset-password-with-otp';

  // Payment and subscription endpoints
  static const String getPaymentMethodsEndpoint = '/payment/methods';
  static const String addPaymentMethodEndpoint = '/payment/methods';
  static const String updatePaymentMethodEndpoint = '/payment/methods';
  static const String deletePaymentMethodEndpoint = '/payment/methods';
  static const String getCurrentSubscriptionEndpoint = '/subscription/current';
  static const String subscribeToPlanEndpoint = '/subscription/subscribe';
}
