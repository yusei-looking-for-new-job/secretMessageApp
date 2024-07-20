import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  static const double _spacingHeight = 50.0;
  static const double _dotSize = 10.0;
  static const double _activeDotWidth = 20.0;
  static const double _activeDotHeight = 10.0;
  static const double _dotSpacing = 3.0;
  static const double _dotBorderRadius = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          scrollPhysics: const BouncingScrollPhysics(),
          pages: [
            _buildWhatIsThisSitePage(context),
            _buildHowToEmbedMessagePage(context),
            _buildHowToExtractMessagePage(context),
            _buildCautionsPage(context),
          ],
          onDone: () async => Navigator.pop(context),
          showBackButton: true,
          next: const Icon(Icons.arrow_forward_ios),
          back: const Icon(Icons.arrow_back_ios),
          done: const Text(
            'OK!',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          dotsDecorator: _buildDotsDecorator(),
        ),
      ),
    );
  }

  PageViewModel _buildWhatIsThisSitePage(BuildContext context) {
    return PageViewModel(
      title: AppLocalizations.of(context)!.whatIsThisSite,
      body: AppLocalizations.of(context)!.whatIsThisSiteBody,
      image: Image.asset('images/image4.png'),
    );
  }

  PageViewModel _buildHowToEmbedMessagePage(BuildContext context) {
    return PageViewModel(
      title: AppLocalizations.of(context)!.howToEmbedMessage,
      bodyWidget: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageWithText(AppLocalizations.of(context)!.step1SelectImage,
                'images/intro1.png'),
            _buildImageWithText(AppLocalizations.of(context)!.step2EnterMessage,
                'images/intro2.png'),
            _buildImageWithText(AppLocalizations.of(context)!.step3EmbedString,
                'images/intro3.png'),
            _buildImageWithText(AppLocalizations.of(context)!.step4Success,
                'images/intro4.png'),
          ],
        ),
      ),
    );
  }

  PageViewModel _buildHowToExtractMessagePage(BuildContext context) {
    return PageViewModel(
      title: AppLocalizations.of(context)!.howToExtractMessage,
      bodyWidget: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageWithText(
                AppLocalizations.of(context)!.extractStep1SelectImage,
                'images/intro1.png'),
            _buildImageWithText(
                AppLocalizations.of(context)!.extractStep2Extract,
                'images/intro5.png'),
            _buildImageWithText(
                AppLocalizations.of(context)!.extractStep3Success,
                'images/intro6.png'),
          ],
        ),
      ),
    );
  }

  PageViewModel _buildCautionsPage(BuildContext context) {
    return PageViewModel(
      title: AppLocalizations.of(context)!.cautions,
      bodyWidget: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: _spacingHeight),
            _buildBoldText(AppLocalizations.of(context)!.caution1),
            const SizedBox(height: _spacingHeight),
            _buildBoldText(AppLocalizations.of(context)!.caution2),
            const SizedBox(height: _spacingHeight),
            Text(AppLocalizations.of(context)!.exampleLineApp),
            Text(AppLocalizations.of(context)!.sendSecretMessage),
            Image.asset('images/coution2.jpg'),
            const SizedBox(height: _spacingHeight),
            Text(AppLocalizations.of(context)!.downloadSecretMessage),
            Image.asset('images/coution3.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithText(String text, String imagePath) {
    return Column(
      children: [
        Text(text),
        Image.asset(imagePath),
        const SizedBox(height: _spacingHeight),
      ],
    );
  }

  Widget _buildBoldText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  DotsDecorator _buildDotsDecorator() {
    return DotsDecorator(
      size: const Size.square(_dotSize),
      activeSize: const Size(_activeDotWidth, _activeDotHeight),
      activeColor: Colors.blue,
      color: Colors.black26,
      spacing: const EdgeInsets.symmetric(horizontal: _dotSpacing),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_dotBorderRadius),
      ),
    );
  }
}
