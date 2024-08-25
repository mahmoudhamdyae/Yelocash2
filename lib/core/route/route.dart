import 'package:changa_lab/view/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:changa_lab/view/components/preview_image.dart';
import 'package:changa_lab/view/screen/account/change-password/change_password_screen.dart';
import 'package:changa_lab/view/screen/auth/email_verification_page/email_verification_screen.dart';
import 'package:changa_lab/view/screen/auth/forget_password/forget_password/forget_password.dart';
import 'package:changa_lab/view/screen/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:changa_lab/view/screen/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:changa_lab/view/screen/auth/kyc/kyc.dart';
import 'package:changa_lab/view/screen/auth/login/login_screen.dart';
import 'package:changa_lab/view/screen/auth/profile_complete/profile_complete_screen.dart';
import 'package:changa_lab/view/screen/auth/registration/registration_screen.dart';
import 'package:changa_lab/view/screen/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/widraw/widraw_screen.dart';
import 'package:changa_lab/view/screen/commission_log/commitionlog_screen.dart';
import 'package:changa_lab/view/screen/edit_profile/edit_profile_screen.dart';
import 'package:changa_lab/view/screen/exchange/latest_exchange_screen.dart';
import 'package:changa_lab/view/screen/exchange_details/exchangeDetailsScreen.dart';
import 'package:changa_lab/view/screen/exchange_history/exchange_historyScreen.dart';
import 'package:changa_lab/view/screen/exchange_prevew/Exchange_prevew_Screen.dart';
import 'package:changa_lab/view/screen/faq/faq_screen.dart';
import 'package:changa_lab/view/screen/language/language_screen.dart';
import 'package:changa_lab/view/screen/manual_exchange_confirm_screen/manual_exchange_confirm_screen.dart';
import 'package:changa_lab/view/screen/onboard/onboard_screen.dart';
import 'package:changa_lab/view/screen/privacy_policy/privacy_policy_screen.dart';
import 'package:changa_lab/view/screen/payment/automatic_payment.dart';
import 'package:changa_lab/view/screen/profile/profile_screen.dart';
import 'package:changa_lab/view/screen/referral/referral_screen.dart';
import 'package:changa_lab/view/screen/splash/splash_screen.dart';
import 'package:changa_lab/view/screen/ticket/all_ticket_screen/all_ticket_screen.dart';
import 'package:changa_lab/view/screen/ticket/new_ticket_screen/new_ticket_screen.dart';
import 'package:changa_lab/view/screen/ticket/ticket_details_screen/ticket_details_screen.dart';
import 'package:changa_lab/view/screen/traceexchagne/trace_exchange_screen.dart';
import 'package:changa_lab/view/screen/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import 'package:changa_lab/view/screen/two_factor/two_factor_verification_screen/two_factor_verification_screen.dart';

import 'package:changa_lab/view/screen/withdraw/withdraw_history/withdraw_histry_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
 static const String languageScreen = "/languages_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  //
  static const String exchange = "/exchange_screen";
  static const String exchangePreview = "/exchange_preview";
  static const String manualExchangeConfirmScreen = "/manual_exchange_confirm";
  static const String exchangeHistory = "/exchange_history";
  static const String exchangeDetails = "/exchange_details";
  static const String exchangeTrack = "/exchange_trace";
  //
  static const String commissionLog = "/commission_log";
  static const String transactionScreen = "/transaction_screen";

  static const String myWalletScreen = "/my_wallet_screen";
  static const String addMoneyHistoryScreen = "/add_money_history_screen";
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String verifyPassCodeScreen = "/verify_pass_code_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String onboardScreen = "/onboard-screen";
  static const String twoFactorSetupScreen = "/two-factor-setup-screen";
  static const String resetPasswordScreen = "/reset_pass_screen";
  static const String transactionHistoryScreen = "/transaction_history_screen";
  static const String notificationScreen = "/notification_screen";
  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";
  static const String privacyScreen = "/privacy-screen";
 static const String newTicketScreen   = '/new_ticket_screen';
  static const String withdrawScreen = "/withdraw-screen";
  static const String addWithdrawMethodScreen = "/withdraw-method";
  static const String withdrawConfirmScreenScreen = "/withdraw-preview-screen";
  static const String withdrawHistory = "/withdraw_history";

  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen = '/deposit_webView';
  static const String faqScreen = "/faq-screen";
  static const String previewImageScreen               = "/preview-image-screen";
  //
  static const String autoPayementScreen = '/auto_payment_screen';

   static const String ticketDetailsScreen              = '/ticket_details_screen';
   static const String allTicketScreen              = '/all_ticket_screen';
   static const String refferalScreen              = '/refferal_screen';
   

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen()),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: twoFactorScreen, page: () =>const TwoFactorVerificationScreen()),
    GetPage(name: twoFactorSetupScreen, page: () =>const TwoFactorSetupScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardingScreen()),
    GetPage(name: refferalScreen, page: () => const ReferralScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: exchange, page: () => const ExchangeListScreen()),
    GetPage(name: exchangePreview, page: () => const ExchangePreviewScreen()),
    GetPage(name: exchangeHistory, page: () => const ExchangeHistory()),
    GetPage(name: exchangeDetails, page: () => const ExchangeDetailsScreen()),
    GetPage(name: exchangeTrack, page: () => const TraceExchangeScreen()),
    GetPage(name: commissionLog, page: () => const CommissionLogScreen()),
    GetPage(name: withdrawHistory, page: () => const WidthrawHistoryScreen()),
    GetPage(name: allTicketScreen, page: () => const AllTicketScreen()),
     GetPage(name: previewImageScreen, page: () => PreviewImage(url: Get.arguments)),
    GetPage(name: addWithdrawMethodScreen, page: () => WithdrawScreen(isBack: true)),
    //payment screen
    GetPage(name: autoPayementScreen, page: () => const AutoMaticPayemntScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: emailVerificationScreen, page: () =>const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: exchangePreview, page: () => const ExchangePreviewScreen()),
    GetPage(name: exchangeHistory, page: () => const ExchangeHistory()),
    GetPage(name: exchangeDetails, page: () => const ExchangeDetailsScreen()),
    GetPage(name: commissionLog, page: () => const CommissionLogScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
     GetPage(name: ticketDetailsScreen, page: () => const TicketDetailsScreen()),
    GetPage(name: manualExchangeConfirmScreen, page: () => const ManualExchangeConfirmScreen()),
  ];
}
