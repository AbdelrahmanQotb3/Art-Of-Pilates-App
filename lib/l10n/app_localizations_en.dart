// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Art of Pilates';

  @override
  String get welcome => 'Welcome to Art of Pilates';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidPassword => 'Password must be at least 6 characters';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get passwordUpperCase => 'At least one uppercase letter required';

  @override
  String get passwordLowerCase => 'At least one lowercase letter required';

  @override
  String get passwordNumber => 'At least one number required';

  @override
  String get passwordSpecialChar => 'At least one special character required';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordNotMatched => 'Passwords do not match';

  @override
  String get userNameRequired => 'Username is required';

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get thisEmailIsNotValid => 'This email is not valid';
}
