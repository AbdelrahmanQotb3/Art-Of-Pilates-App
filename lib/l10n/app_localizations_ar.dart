// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'فن البيلاتس';

  @override
  String get welcome => 'مرحبا بك في تطبيق فن البيلاتس';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterPassword => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get invalidPassword => 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get passwordMinLength =>
      'يجب أن تتكون كلمة المرور من ٨ أحرف على الأقل';

  @override
  String get passwordUpperCase =>
      'يجب احتواء كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordLowerCase =>
      'يجب احتواء كلمة المرور على حرف صغير واحد على الأقل';

  @override
  String get passwordNumber => 'يجب احتواء كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordSpecialChar =>
      'يجب احتواء كلمة المرور على رمز خاص واحد على الأقل';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordNotMatched => 'كلمات المرور غير متطابقة';

  @override
  String get userNameRequired => 'اسم المستخدم مطلوب';

  @override
  String get phoneNumberRequired => 'رقم الهاتف مطلوب';

  @override
  String get firstNameRequired => 'الاسم الأول مطلوب';

  @override
  String get lastNameRequired => 'اسم العائلة مطلوب';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get thisEmailIsNotValid => 'هذا البريد الإلكتروني غير صالح';
}
