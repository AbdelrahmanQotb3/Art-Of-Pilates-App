import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Art of Pilates'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Art of Pilates'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get invalidPassword;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordUpperCase.
  ///
  /// In en, this message translates to:
  /// **'At least one uppercase letter required'**
  String get passwordUpperCase;

  /// No description provided for @passwordLowerCase.
  ///
  /// In en, this message translates to:
  /// **'At least one lowercase letter required'**
  String get passwordLowerCase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'At least one number required'**
  String get passwordNumber;

  /// No description provided for @passwordSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'At least one special character required'**
  String get passwordSpecialChar;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordNotMatched.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatched;

  /// No description provided for @userNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get userNameRequired;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @thisEmailIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get thisEmailIsNotValid;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Art of Pilates'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your body, Your masterpiece'**
  String get appTagline;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @termsPart1.
  ///
  /// In en, this message translates to:
  /// **'By signing up you agree to our '**
  String get termsPart1;

  /// No description provided for @termsPart2.
  ///
  /// In en, this message translates to:
  /// **', to get email & updates, and you acknowledge that you have read the '**
  String get termsPart2;

  /// No description provided for @termsPart3.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get termsPart3;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Art of Pilates Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @adminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your studio, staff, bookings and more in one place.'**
  String get adminDashboardSubtitle;

  /// No description provided for @welcomeAppName.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Art of Pilates'**
  String get welcomeAppName;

  /// No description provided for @enterYourEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to continue'**
  String get enterYourEmailAndPassword;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signin;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;

  /// No description provided for @enterYourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterYourFirstName;

  /// No description provided for @enterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterYourLastName;

  /// No description provided for @enterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get enterYourConfirmPassword;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createYourAccount;

  /// No description provided for @enterYourDetailsToSignup.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to create an account'**
  String get enterYourDetailsToSignup;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @artOfPilates.
  ///
  /// In en, this message translates to:
  /// **'Art of Pilates'**
  String get artOfPilates;

  /// No description provided for @upcomingBookins.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Bookings'**
  String get upcomingBookins;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @searchForServices.
  ///
  /// In en, this message translates to:
  /// **'Search for services'**
  String get searchForServices;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @payableWithPlan.
  ///
  /// In en, this message translates to:
  /// **'Payable with Plan'**
  String get payableWithPlan;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @partOfPricingPlan.
  ///
  /// In en, this message translates to:
  /// **'Part of Pricing Plan'**
  String get partOfPricingPlan;

  /// No description provided for @selectService.
  ///
  /// In en, this message translates to:
  /// **'Select Service'**
  String get selectService;

  /// No description provided for @myAccounts.
  ///
  /// In en, this message translates to:
  /// **'My Accounts'**
  String get myAccounts;

  /// No description provided for @editInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit Info'**
  String get editInfo;

  /// No description provided for @myActivities.
  ///
  /// In en, this message translates to:
  /// **'My Activities'**
  String get myActivities;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @seeYourInfoAndActivities.
  ///
  /// In en, this message translates to:
  /// **'See your info & activity as a member of Art of Pilates'**
  String get seeYourInfoAndActivities;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @myPrograms.
  ///
  /// In en, this message translates to:
  /// **'My Programs'**
  String get myPrograms;

  /// No description provided for @overView.
  ///
  /// In en, this message translates to:
  /// **'OverView'**
  String get overView;

  /// No description provided for @notPublished.
  ///
  /// In en, this message translates to:
  /// **'Not Published'**
  String get notPublished;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @updateYourPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information'**
  String get updateYourPersonalInformation;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated!'**
  String get updateSuccess;

  /// No description provided for @bookThisSession.
  ///
  /// In en, this message translates to:
  /// **'Book This Session'**
  String get bookThisSession;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @bookAndPay.
  ///
  /// In en, this message translates to:
  /// **'Book & Pay'**
  String get bookAndPay;

  /// No description provided for @spotsLeft.
  ///
  /// In en, this message translates to:
  /// **'spots left'**
  String get spotsLeft;

  /// No description provided for @viewPaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'View Payment Options'**
  String get viewPaymentOptions;

  /// No description provided for @dueNow.
  ///
  /// In en, this message translates to:
  /// **'due now'**
  String get dueNow;

  /// No description provided for @enterCouponcode.
  ///
  /// In en, this message translates to:
  /// **'Enter coupon code'**
  String get enterCouponcode;

  /// No description provided for @buyAPlan.
  ///
  /// In en, this message translates to:
  /// **'Buy a Plan'**
  String get buyAPlan;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @onlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// No description provided for @onlinePaymentDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay securely with credit card, debit card, or digital wallet'**
  String get onlinePaymentDescription;

  /// No description provided for @cashPayment.
  ///
  /// In en, this message translates to:
  /// **'Cash Payment'**
  String get cashPayment;

  /// No description provided for @cashPaymentDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay in person at the studio location'**
  String get cashPaymentDescription;

  /// No description provided for @planCashPaymentNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Plans must be paid online.'**
  String get planCashPaymentNotAvailable;

  /// No description provided for @confirmAndPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Pay'**
  String get confirmAndPay;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @showBenefits.
  ///
  /// In en, this message translates to:
  /// **'Show Benefits'**
  String get showBenefits;

  /// No description provided for @validFor.
  ///
  /// In en, this message translates to:
  /// **'Valid for'**
  String get validFor;

  /// No description provided for @noPackagesFound.
  ///
  /// In en, this message translates to:
  /// **'No packages found'**
  String get noPackagesFound;

  /// No description provided for @planSummary.
  ///
  /// In en, this message translates to:
  /// **'Plan Summary'**
  String get planSummary;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @selectDuringCheckout.
  ///
  /// In en, this message translates to:
  /// **'Select during checkout'**
  String get selectDuringCheckout;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @totalToday.
  ///
  /// In en, this message translates to:
  /// **'Total today'**
  String get totalToday;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @taxDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Final price with tax rates will be determined during checkout.'**
  String get taxDisclaimer;

  /// No description provided for @planStarts.
  ///
  /// In en, this message translates to:
  /// **'Plan Starts'**
  String get planStarts;

  /// No description provided for @copounNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Coupon not added'**
  String get copounNotAdded;

  /// No description provided for @iHaveReadAndAcceptPlanPolicy.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept '**
  String get iHaveReadAndAcceptPlanPolicy;

  /// No description provided for @planPolicy.
  ///
  /// In en, this message translates to:
  /// **'plan policy'**
  String get planPolicy;

  /// No description provided for @mustAcceptPlanPolicy.
  ///
  /// In en, this message translates to:
  /// **'You must accept the plan policy to continue.'**
  String get mustAcceptPlanPolicy;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @couponCode.
  ///
  /// In en, this message translates to:
  /// **'Coupon code'**
  String get couponCode;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @buyPlan.
  ///
  /// In en, this message translates to:
  /// **'Buy Plan'**
  String get buyPlan;

  /// No description provided for @buyAPlanToBookThisSession.
  ///
  /// In en, this message translates to:
  /// **'Buy a plan to book this session'**
  String get buyAPlanToBookThisSession;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @notificationsSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications Settings'**
  String get notificationsSettings;

  /// No description provided for @appDisplay.
  ///
  /// In en, this message translates to:
  /// **'App Display'**
  String get appDisplay;

  /// No description provided for @deleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Your Account'**
  String get deleteYourAccount;

  /// No description provided for @aboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'About The App'**
  String get aboutTheApp;

  /// No description provided for @welcomeToOurApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our App'**
  String get welcomeToOurApp;

  /// No description provided for @welcomeToOurAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with \"Art of Pilates\" and stay updated on the go with our mobile app.'**
  String get welcomeToOurAppSubtitle;

  /// No description provided for @aboutTheAppDescription1.
  ///
  /// In en, this message translates to:
  /// **'The app gives you everything you need to stay in touch with \"Art of Pilates\" anytime, anywhere.'**
  String get aboutTheAppDescription1;

  /// No description provided for @aboutTheAppDescription2.
  ///
  /// In en, this message translates to:
  /// **'Easily get in contact with us using real-time chat, and receive push notifications with our latest news & offers so you never miss a thing.'**
  String get aboutTheAppDescription2;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfService;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @appWillRestartOnLanguageChange.
  ///
  /// In en, this message translates to:
  /// **'The app will restart once a new language is saved'**
  String get appWillRestartOnLanguageChange;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// No description provided for @noUserDataFound.
  ///
  /// In en, this message translates to:
  /// **'No user data found'**
  String get noUserDataFound;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email notifications'**
  String get emailNotifications;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Your account will be deleted from this app. You won\'t be able to restore your account after it\'s deleted, but you can always create a new one.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @noUpcomingBookings.
  ///
  /// In en, this message translates to:
  /// **'No upcoming bookings'**
  String get noUpcomingBookings;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get orderSummary;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promoCode;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @reviewAndPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Review & Place Order'**
  String get reviewAndPlaceOrder;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iAgreeToThe;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @returnPolicy.
  ///
  /// In en, this message translates to:
  /// **'Return Policy'**
  String get returnPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms to continue.'**
  String get mustAcceptTerms;

  /// No description provided for @sendMeMarketingCommunications.
  ///
  /// In en, this message translates to:
  /// **'Send me marketing communications via email & SMS'**
  String get sendMeMarketingCommunications;

  /// No description provided for @estimatedTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated total'**
  String get estimatedTotal;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @sessionBookedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Session booked successfully!'**
  String get sessionBookedSuccessfully;

  /// No description provided for @continueToPayment.
  ///
  /// In en, this message translates to:
  /// **'Continue to Payment'**
  String get continueToPayment;

  /// No description provided for @alreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'You have already booked this session'**
  String get alreadyBooked;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @full.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get full;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed or was cancelled.'**
  String get paymentFailed;

  /// No description provided for @planPurchasedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Plan purchased successfully!'**
  String get planPurchasedSuccessfully;

  /// No description provided for @signinErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing in. Please try again.'**
  String get signinErrorMessage;

  /// No description provided for @signupErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing up. Please try again.'**
  String get signupErrorMessage;

  /// No description provided for @signinWithGoogleErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing in with Google. Please try again.'**
  String get signinWithGoogleErrorMessage;

  /// No description provided for @signupWithGoogleErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing up with Google. Please try again.'**
  String get signupWithGoogleErrorMessage;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get comment;

  /// No description provided for @someThingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get someThingWentWrong;

  /// No description provided for @perSession.
  ///
  /// In en, this message translates to:
  /// **'per session'**
  String get perSession;

  /// No description provided for @thisSessionHasEnded.
  ///
  /// In en, this message translates to:
  /// **'This session has ended'**
  String get thisSessionHasEnded;

  /// No description provided for @sessionEnded.
  ///
  /// In en, this message translates to:
  /// **'Session Ended'**
  String get sessionEnded;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @noSessionsForThisDay.
  ///
  /// In en, this message translates to:
  /// **'No sessions for this day'**
  String get noSessionsForThisDay;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @bookingClosed.
  ///
  /// In en, this message translates to:
  /// **'Booking Closed'**
  String get bookingClosed;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @youAreOnTheWaitingListMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re on the waiting list. We\'ll notify you if a spot opens.'**
  String get youAreOnTheWaitingListMessage;

  /// No description provided for @thisSessionIsFullSoJoinTheWaitingList.
  ///
  /// In en, this message translates to:
  /// **'This session is full. Join the waiting list to get notified.'**
  String get thisSessionIsFullSoJoinTheWaitingList;

  /// No description provided for @onWaitingList.
  ///
  /// In en, this message translates to:
  /// **'On Waiting List'**
  String get onWaitingList;

  /// No description provided for @joinWaitingList.
  ///
  /// In en, this message translates to:
  /// **'Join Waiting List'**
  String get joinWaitingList;

  /// No description provided for @thisSessionIsFyllyBooked.
  ///
  /// In en, this message translates to:
  /// **'This session is fully booked.'**
  String get thisSessionIsFyllyBooked;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
