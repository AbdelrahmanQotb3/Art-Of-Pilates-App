abstract class AppEndPoints {
  static const String baseUrl = "http://10.0.2.2:3000/";

  // Authentication Endpoints
  static const String signin = "auth/signin";
  static const String signup = "auth/signup";
  static const String signupWithSocial = "auth/social-signup";
  static const String signinWithSocial = "auth/social-signup";
  static const String logout = "auth/logout";

  // Services Endpoints
  static const String getAllServices = "services/getServices";
  static const String getOneService = "services/getOneService";

  static const String getUser = "user/currentUser";
  static const String editUser = "user/editUser";
  static const String deleteAccount = "user/deleteUser";

  static const String getAllSessions = "sessions/getAllSessions";
  static const String getOneSession = "sessions/getOneSession";

  static const String getAllPackages = "pricing-plans/getPlans";
  static const String getOnePackage = "pricing-plans/getPlanById";

  static const String getAllBookings = "bookings/my-bookings";
  static const String getMyPlans = "bookings/my-plans";
  static const String cancelBooking = "bookings/cancel/{bookingId}";
  static const String bookSessionDirectly = "bookings/book";
  static const String purchasePlan = "bookings/purchase-plan";
  static const String bookWithPlan = "bookings/book-with-plan";
  static const String checkBooking = "bookings/check/{sessionId}";
  static const String bookPlan = "bookings/bookPlan";

  static const String createCharge = "payments/create-charge";
  static const String verifyPayment = "payments/verify/{chargeId}";
  static const String createPlanCharge = "payments/create-charge-plan";

  static const String getAnnouncements = "announcements/all-announcements";

  // Waiting List
  static const String joinWaitingList = "bookings/waiting-list/join";
  static const String leaveWaitingList =
      "bookings/waiting-list/leave/{sessionId}";
  static const String checkWaitingList =
      "bookings/waiting-list/check/{sessionId}";

  static const String checkPlanForSession = "bookings/check-plan/{sessionId}";
  static const String getPlanSummery = "bookings/my-plan-summary";
}
