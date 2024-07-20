import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Image Steganography';

  @override
  String get selectImage => 'Select Image';

  @override
  String get noImageSelected => 'No image selected(embedding must be 10MB or smaller )';

  @override
  String get enterTextToEmbed => 'Enter text to embed';

  @override
  String get embedString => 'Embed String';

  @override
  String get extractString => 'Extract String';

  @override
  String get howToUseTheApp => 'How to use the app';

  @override
  String get success => 'Success';

  @override
  String get stringEmbeddedSuccessfully => 'String embedded successfully';

  @override
  String get error => 'Error';

  @override
  String get failedToEmbedString => 'Failed to embed string';

  @override
  String get pleaseEnterTextToEmbed => 'Please enter text to embed';

  @override
  String get extractedString => 'Extracted String';

  @override
  String get failedToExtractString => 'Failed to extract string';

  @override
  String get ok => 'OK';

  @override
  String get whatIsThisSite => 'What is this site?';

  @override
  String get whatIsThisSiteBody => 'This site provides a tool that allows you to hide secret messages within images. The embedded messages are invisible to the naked eye, enabling you to exchange secret information without being noticed by third parties. Additionally, this tool can be applied to protect image copyrights. By embedding copyright information into an image, it can help prevent unauthorized use.';

  @override
  String get howToEmbedMessage => 'How to embed a message';

  @override
  String get step1SelectImage => 'Step 1: Select an image to embed a message into';

  @override
  String get step2EnterMessage => 'Step 2: Enter the message to embed. Some symbols and emojis may not embed correctly';

  @override
  String get step3EmbedString => 'Step 3: Click the Embed String button';

  @override
  String get step4Success => 'Step 4: If successful, the following dialog will be displayed. Close the dialog and click the \"Download Image\" button to save the image with the embedded secret message.\nFor PC, the image will be saved in the Downloads folder. For mobile devices, note that the image will be saved in the Library or Files app, not the Photo Album.';

  @override
  String get howToExtractMessage => 'How to extract a message';

  @override
  String get extractStep1SelectImage => 'Step 1: Select the image you want to extract the message from';

  @override
  String get extractStep2Extract => 'Step 2: Click the Extract String button';

  @override
  String get extractStep3Success => 'Step 3: If successful, the hidden message will be displayed';

  @override
  String get cautions => 'Cautions';

  @override
  String get caution1 => 'Caution 1: Editing or compressing an image with an embedded secret message may make the message unextractable. Use the embedded image in its original (png) format.';

  @override
  String get caution2 => 'Caution 2: When sending or receiving messages, use the original quality images for sending and downloading';

  @override
  String get exampleLineApp => 'Example: For the LINE app';

  @override
  String get sendSecretMessage => 'Sending a secret message image: When sending a secret message, select Original to send';

  @override
  String get downloadSecretMessage => 'Downloading a secret message image: When downloading a secret message, select Original to download';

  @override
  String get errorSelectImageFormat => 'Selected image format is not supported';

  @override
  String get tooLargeImage => 'Image size is too large, please select images under 10MB';

  @override
  String get embSuccess => 'Message successfully embedded.';
}
