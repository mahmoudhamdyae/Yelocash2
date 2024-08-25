class UrlContainer {
  static const String domainUrl = 'https://yelocash.net';
  static const String baseUrl   = '$domainUrl/api/';

  static const String dashBoardEndPoint   = 'dashboard';
  static const String depositHistoryUrl   = 'deposit/history';
  static const String depositMethodUrl    = 'deposit/methods';
  static const String depositInsertUrl    = 'deposit/insert';
  static const String socialLoginEndPoint = 'social-login';

  static const String registrationEndPoint   = 'register';
  static const String loginEndPoint          = 'login';
  static const String logoutUrl              = 'logout';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint  = 'password/reset';
  static const String verify2FAUrl           = 'verify-g2fa';
  static const String referralEndPoint       = "affiliate";

   static const String accountDisable = "delete-account";

  static const String otpVerify = 'otp-verify';
  static const String otpResend = 'otp-resend';

  static const String verifyEmailEndPoint       = 'verify-email';
  static const String faqEndPoint               = 'faq';
  static const String verifySmsEndPoint         = 'verify-mobile';
  static const String resendVerifyCodeEndPoint  = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';

  static const String dashBoardUrl        = 'dashboard';
  static const String transactionEndpoint = 'transactions';

  static const String twoFactor        = "twofactor";
  static const String twoFactorEnable  = "twofactor/enable";
  static const String twoFactorDisable = "twofactor/disable";

  static const String withdraw                 = 'withdraw/';
  static const String widthrawCurrency         = 'currency';
  static const String widthrawSave             = 'save';
  static const String addWithdrawRequestUrl    = 'withdraw-request';
  static const String withdrawMethodUrl        = 'withdraw-method';
  static const String withdrawRequestConfirm   = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl       = 'withdraw/history';
  static const String withdrawStoreUrl         = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';

  static const String kycFormUrl             = 'kyc-form';
  static const String kycSubmitUrl           = 'kyc-submit';
  static const String generalSettingEndPoint = 'general-setting';
  static const String privacyPolicyEndPoint  = 'policies';

  static const String getProfileEndPoint      = 'user-info';
  static const String updateProfileEndPoint   = 'profile-setting';
  static const String profileCompleteEndPoint = 'user-data-submit';
  static const String changePasswordEndPoint  = 'change-password';
  static const String countryEndPoint         = 'get-countries';
  static const String deviceTokenEndPoint     = 'add-device-token';
  static const String languageUrl             = 'language/';
    // Currency
  static const String currencyUrl  = 'currency/list';
  static const String currencySell = '/sell';
  static const String currencyBuy  = '/buy';
  static const String getSelected = '/buy_filter';
  static const String getSelected2 = '/sell_filter';
    // exchanges
  static const String exchangeUrl     = 'exchange';
  static const String create          = 'exchange/create';
  static const String preview         = 'exchange/preview/';
  static const String confirm         = 'exchange/confirm/';
  static const String exchangeList    = 'exchange/list';
  static const String approved        = 'exchange/list/approved';
  static const String pending         = 'exchange/list/pending';
  static const String canceled        = 'exchange/list/canceled';
  static const String refunded        = 'exchange/list/refunded';
  static const String exchangeDetails = 'exchange/details/';
  static const String trackExchange   = 'exchange/track';

    /*
  static const String deviceTokenEndPoint = 'get/device/token';
  static const String languageUrl         = 'language/';
  static const String currencyUrl         = 'currency/list';
  static const String exchangeUrl         = 'exchange';
  static const String exchangeList        = '/list/';
  static const String exchangeDetails     = '$exchangeUrl/details';

  
  */

  static const String supportMethodsEndPoint  = 'support/method';
  static const String supportListEndPoint     = 'ticket';
  static const String storeSupportEndPoint    = 'ticket/create';
  static const String supportViewEndPoint     = 'ticket/view';
  static const String supportReplyEndPoint    = 'ticket/reply';
  static const String supportCloseEndPoint    = 'ticket/close';
  static const String supportDownloadEndPoint = 'ticket/download';
  static const String communityGroupsEndPoint = 'community-groups';
  static const String supportImagePath        = '$domainUrl/assets/support/';


  static const String exchangeHistory       = 'exchange/list';
  static const String exchangeManual        = 'manual/';
  static const String exchangeManualConfirm = 'exchange/manual/confirm/';
  static const String commissionLog         = 'affiliate';

     static const String countryFlagImageLink = 'https://flagpedia.net/data/flags/h24/{countryCode}.webp';
}
