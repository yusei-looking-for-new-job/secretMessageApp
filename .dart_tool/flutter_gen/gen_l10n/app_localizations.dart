import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Image Steganography'**
  String get appTitle;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected(embedding must be 10MB or smaller )'**
  String get noImageSelected;

  /// No description provided for @enterTextToEmbed.
  ///
  /// In en, this message translates to:
  /// **'Enter text to embed'**
  String get enterTextToEmbed;

  /// No description provided for @embedString.
  ///
  /// In en, this message translates to:
  /// **'Embed String'**
  String get embedString;

  /// No description provided for @extractString.
  ///
  /// In en, this message translates to:
  /// **'Extract String'**
  String get extractString;

  /// No description provided for @howToUseTheApp.
  ///
  /// In en, this message translates to:
  /// **'How to use the app'**
  String get howToUseTheApp;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @stringEmbeddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'String embedded successfully'**
  String get stringEmbeddedSuccessfully;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @failedToEmbedString.
  ///
  /// In en, this message translates to:
  /// **'Failed to embed string'**
  String get failedToEmbedString;

  /// No description provided for @pleaseEnterTextToEmbed.
  ///
  /// In en, this message translates to:
  /// **'Please enter text to embed'**
  String get pleaseEnterTextToEmbed;

  /// No description provided for @extractedString.
  ///
  /// In en, this message translates to:
  /// **'Extracted String'**
  String get extractedString;

  /// No description provided for @failedToExtractString.
  ///
  /// In en, this message translates to:
  /// **'Failed to extract string'**
  String get failedToExtractString;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @whatIsThisSite.
  ///
  /// In en, this message translates to:
  /// **'What is this site?'**
  String get whatIsThisSite;

  /// No description provided for @whatIsThisSiteBody.
  ///
  /// In en, this message translates to:
  /// **'This site provides a tool that allows you to hide secret messages within images. The embedded messages are invisible to the naked eye, enabling you to exchange secret information without being noticed by third parties. Additionally, this tool can be applied to protect image copyrights. By embedding copyright information into an image, it can help prevent unauthorized use.'**
  String get whatIsThisSiteBody;

  /// No description provided for @howToEmbedMessage.
  ///
  /// In en, this message translates to:
  /// **'How to embed a message'**
  String get howToEmbedMessage;

  /// No description provided for @step1SelectImage.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Select an image to embed a message into'**
  String get step1SelectImage;

  /// No description provided for @step2EnterMessage.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Enter the message to embed. Some symbols and emojis may not embed correctly'**
  String get step2EnterMessage;

  /// No description provided for @step3EmbedString.
  ///
  /// In en, this message translates to:
  /// **'Step 3: Click the Embed String button'**
  String get step3EmbedString;

  /// No description provided for @step4Success.
  ///
  /// In en, this message translates to:
  /// **'Step 4: If successful, the following dialog will be displayed. Close the dialog and click the \"Download Image\" button to save the image with the embedded secret message.\nFor PC, the image will be saved in the Downloads folder. For mobile devices, note that the image will be saved in the Library or Files app, not the Photo Album.'**
  String get step4Success;

  /// No description provided for @howToExtractMessage.
  ///
  /// In en, this message translates to:
  /// **'How to extract a message'**
  String get howToExtractMessage;

  /// No description provided for @extractStep1SelectImage.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Select the image you want to extract the message from'**
  String get extractStep1SelectImage;

  /// No description provided for @extractStep2Extract.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Click the Extract String button'**
  String get extractStep2Extract;

  /// No description provided for @extractStep3Success.
  ///
  /// In en, this message translates to:
  /// **'Step 3: If successful, the hidden message will be displayed'**
  String get extractStep3Success;

  /// No description provided for @cautions.
  ///
  /// In en, this message translates to:
  /// **'Cautions'**
  String get cautions;

  /// No description provided for @caution1.
  ///
  /// In en, this message translates to:
  /// **'Caution 1: Editing or compressing an image with an embedded secret message may make the message unextractable. Use the embedded image in its original (png) format.'**
  String get caution1;

  /// No description provided for @caution2.
  ///
  /// In en, this message translates to:
  /// **'Caution 2: When sending or receiving messages, use the original quality images for sending and downloading'**
  String get caution2;

  /// No description provided for @exampleLineApp.
  ///
  /// In en, this message translates to:
  /// **'Example: For the LINE app'**
  String get exampleLineApp;

  /// No description provided for @sendSecretMessage.
  ///
  /// In en, this message translates to:
  /// **'Sending a secret message image: When sending a secret message, select Original to send'**
  String get sendSecretMessage;

  /// No description provided for @downloadSecretMessage.
  ///
  /// In en, this message translates to:
  /// **'Downloading a secret message image: When downloading a secret message, select Original to download'**
  String get downloadSecretMessage;

  /// No description provided for @errorSelectImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Selected image format is not supported'**
  String get errorSelectImageFormat;

  /// No description provided for @tooLargeImage.
  ///
  /// In en, this message translates to:
  /// **'Image size is too large, please select images under 10MB'**
  String get tooLargeImage;

  /// No description provided for @embSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message successfully embedded.'**
  String get embSuccess;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
