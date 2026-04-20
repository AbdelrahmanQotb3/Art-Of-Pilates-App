abstract class AppEndPoints {
  static const String baseUrl = "http://10.0.2.2:3000/";

  // Authentication Endpoints
  static const String signin = "auth/signin";
  static const String signup = "auth/signup";
  static const String signupWithSocial = "auth/social-signup";
  static const String signinWithSocial = "auth/social-signup";

  // Services Endpoints
  static const String getAllServices = "services/getServices";
  static const String getOneService = "services/getOneService";

  static const String getUser = "user/currentUser";
  static const String editUser = "user/editUser";

  static const String getAllSessions = "sessions/getAllSessions";
  static const String getOneSession = "sessions/getOneSession";

  static const String getAllPackages = "pricing-plans/getPlans";
  static const String getOnePackage = "pricing-plans/getPlanById";
}
