class EndPoints {
  static const String baseUrl = "http://10.0.2.2:3000/";

  // Authentication Endpoints
  static const String signin = "auth/signin";
  static const String signup = "auth/signup";
  static const String signupWithSocial = "auth/social-signup";
  static const String signinWithSocial = "auth/social-signup";

  // Services Endpoints
  static const String getAllServices = "services/getServices";
  static const String getOneService = "services/getOneService";

}