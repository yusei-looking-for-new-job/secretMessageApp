import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '画像ステガノグラフィ';

  @override
  String get selectImage => '画像を選択';

  @override
  String get noImageSelected => '画像が選択されていません(埋め込み可能な画像は10MB以下)';

  @override
  String get enterTextToEmbed => '埋め込むテキストを入力';

  @override
  String get embedString => '文字列を埋め込む';

  @override
  String get extractString => '文字列を抽出する';

  @override
  String get howToUseTheApp => 'アプリの使い方';

  @override
  String get success => '成功';

  @override
  String get stringEmbeddedSuccessfully => '文字列の埋め込みに成功しました';

  @override
  String get error => 'エラー';

  @override
  String get failedToEmbedString => '文字列の埋め込みに失敗しました';

  @override
  String get pleaseEnterTextToEmbed => '埋め込むテキストを入力してください';

  @override
  String get extractedString => '抽出された文字列';

  @override
  String get failedToExtractString => '文字列の抽出に失敗しました';

  @override
  String get ok => 'OK';

  @override
  String get whatIsThisSite => 'どんなサイト?';

  @override
  String get whatIsThisSiteBody => 'このサイトは、秘密のメッセージを画像の中に隠すことができるツールです。\n埋め込んだメッセージは目では見えないので第三者に気付かれず秘密のやり取りができます。\nまた画像の著作権保護にも適応できます。著作権情報を画像に埋め込めば不正防止に役立ちます。';

  @override
  String get howToEmbedMessage => '使い方1 メッセージの埋め込み';

  @override
  String get step1SelectImage => '手順1: メッセージを埋め込みたい画像を選択します';

  @override
  String get step2EnterMessage => '手順2: 埋め込むメッセージを入力します。一部の記号、絵文字は正常に埋め込めない可能性があります';

  @override
  String get step3EmbedString => '手順3: Embed String ボタンを押下します';

  @override
  String get step4Success => '手順4: 成功した場合、以下のダイアログが表示されます。ダイアログを消して、\"Download Image\" ボタンを押下し秘密のメッセージを埋め込んだ画像を保存します。\nPCの場合、画像はダウンロードフォルダに保存されます。スマホの場合は写真アルバムではなく、ライブラリやファイルアプリに保存されるのでご注意ください。';

  @override
  String get howToExtractMessage => '使い方2 メッセージの抽出';

  @override
  String get extractStep1SelectImage => '手順1: メッセージを抽出したい画像を選択します。';

  @override
  String get extractStep2Extract => '手順2: Extract String ボタンを押下します';

  @override
  String get extractStep3Success => '手順3: 成功した場合、隠されたメッセージが表示されます。';

  @override
  String get cautions => '注意点';

  @override
  String get caution1 => '注意1: 秘密のメッセージを埋め込んだ画像を編集、圧縮することでメッセージが抽出できなくなります。\n埋め込んだ画像はオリジナル(png)のまま使用してください。';

  @override
  String get caution2 => '注意2: メッセージで送受信をする場合はオリジナル品質で送信、ダウンロードを行ってください';

  @override
  String get exampleLineApp => '例:LINEアプリの場合';

  @override
  String get sendSecretMessage => '秘密メッセージの画像の送信: 秘密メッセージを送信する場合はオリジナルを選択して送信してください';

  @override
  String get downloadSecretMessage => '秘密メッセージの画像のダウンロード: 秘密メッセージをダウンロードする場合はオリジナルを選択してダウンロードしてください';

  @override
  String get errorSelectImageFormat => '選択された画像フォーマットは対応していません';

  @override
  String get tooLargeImage => '画像サイズが大きすぎます。10MB以下の画像を選択してください';

  @override
  String get embSuccess => 'メッセージの埋め込みに成功しました';
}
