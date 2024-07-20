import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stego_app/View/dialog/downloadDialog.dart';
import 'package:stego_app/View/dialog/errorDialog.dart';
import 'package:stego_app/View/dialog/extStringDialog.dart';
import 'package:stego_app/View/introductionPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stego_app/ViewModel/homePageViewModel.dart';

import '../Model/ImageModel.dart';
import '../ViewModel/dataIO/fileInput.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _textController = TextEditingController();

  // Constants
  static const double _buttonHorizontalPadding = 40.0;
  static const double _buttonVerticalPadding = 15.0;
  static const double _borderRadius = 20.0;
  static const double _spacing = 20.0;
  static const double _imageSize = 200.0;
  static const double _textFieldWidth = 300.0;
  static const int _maxTextLength = 1000;
  static const int _maxImageSize = 10000000; // 10MB in bytes

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(loadingNotifireProvider);
    final selectImage = ref.watch(selectImageNotifireProvider);
    // final embImage = ref.watch(embImageNotifireProvider);
    // final extString = ref.watch(extStringNotifireProvider);
    return Scaffold(
      body: Stack(
        children: [
          _BackgroundGradient(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SelectImageButton(ref: ref),
                  const SizedBox(height: _spacing),
                  _SelectedImageDisplay(selectImage: selectImage),
                  const SizedBox(height: _spacing),
                  _InputTextField(controller: _textController),
                  const SizedBox(height: _spacing),
                  _EmbedButton(
                      ref: ref,
                      selectImage: selectImage,
                      textController: _textController),
                  const SizedBox(height: _spacing),
                  _ExtractButton(ref: ref, selectImage: selectImage),
                  const SizedBox(height: _spacing),
                  _HowToUseButton(),
                ],
              ),
            ),
          ),
          if (isVisible) _LoadingOverlay(),
        ],
      ),
    );
  }
}

class _BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.indigo.shade100],
        ),
      ),
    );
  }
}

class _SelectImageButton extends StatelessWidget {
  final WidgetRef ref;

  const _SelectImageButton({Key? key, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final notifire = ref.read(selectImageNotifireProvider.notifier);
        final Uint8List? selectImage = await selectFromGalleryImage();
        if (selectImage != null) {
          notifire.selectImage(selectImage);
        } else {
          showErrorDialog(
              context, AppLocalizations.of(context)!.errorSelectImageFormat);
        }
      },
      icon: const Icon(Icons.image),
      label: Text(AppLocalizations.of(context)!.selectImage),
      style: _buttonStyle(),
    );
  }
}

class _SelectedImageDisplay extends StatelessWidget {
  final SelectImageModel selectImage;

  const _SelectedImageDisplay({Key? key, required this.selectImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectImage.selectImageBytes != null
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(HomePage._borderRadius),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.memory(
              selectImage.selectImageBytes!,
              height: HomePage._imageSize,
              width: HomePage._imageSize,
              fit: BoxFit.cover,
            ),
          )
        : Text(
            AppLocalizations.of(context)!.noImageSelected,
            style: const TextStyle(color: Colors.white),
          );
  }
}

class _InputTextField extends StatelessWidget {
  final TextEditingController controller;

  const _InputTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomePage._textFieldWidth,
      child: TextField(
        maxLength: HomePage._maxTextLength,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: AppLocalizations.of(context)!.enterTextToEmbed,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(HomePage._borderRadius),
          ),
        ),
      ),
    );
  }
}

class _EmbedButton extends StatelessWidget {
  final WidgetRef ref;
  final SelectImageModel selectImage;
  final TextEditingController textController;

  const _EmbedButton({
    Key? key,
    required this.ref,
    required this.selectImage,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: selectImage.selectImageBytes != null
          ? () async {
              String stringToEmbed = textController.text.trim();
              if (stringToEmbed.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.error),
                    content: Text(
                        AppLocalizations.of(context)!.pleaseEnterTextToEmbed),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)!.ok),
                      ),
                    ],
                  ),
                );
              } else if (selectImage.selectImageBytes!.length >
                  HomePage._maxImageSize) {
                showErrorDialog(
                    context, AppLocalizations.of(context)!.tooLargeImage);
              } else {
                final loading = ref.read(loadingNotifireProvider.notifier);
                loading.show();
                final notifire = ref.read(embImageNotifireProvider.notifier);
                final rev =
                    await notifire.embedString(stringToEmbed, selectImage);
                if (rev == true) {
                  await showDownloadDialog(
                      context, notifire.state.embImageBytes!);
                } else {
                  showErrorDialog(context,
                      AppLocalizations.of(context)!.failedToEmbedString);
                }
                loading.hide();
              }
            }
          : null,
      icon: const Icon(Icons.lock),
      label: Text(AppLocalizations.of(context)!.embedString),
      style: _buttonStyle(),
    );
  }
}

class _ExtractButton extends StatelessWidget {
  final WidgetRef ref;
  final SelectImageModel selectImage;

  const _ExtractButton({Key? key, required this.ref, required this.selectImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: selectImage.selectImageBytes != null
          ? () async {
              final loading = ref.read(loadingNotifireProvider.notifier);
              loading.show();
              final notifire = ref.read(extStringNotifireProvider.notifier);
              final rev = await notifire.extractString(selectImage);
              if (rev == true) {
                showExtStringDialog(context, notifire.state);
              } else {
                showErrorDialog(context,
                    AppLocalizations.of(context)!.failedToExtractString);
              }
              loading.hide();
            }
          : null,
      icon: const Icon(Icons.lock_open),
      label: Text(AppLocalizations.of(context)!.extractString),
      style: _buttonStyle(),
    );
  }
}

class _HowToUseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.info_outline),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroductionPage(),
          ),
        );
      },
      label: Text(AppLocalizations.of(context)!.howToUseTheApp),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.indigo,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(HomePage._borderRadius),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: HomePage._buttonHorizontalPadding,
      vertical: HomePage._buttonVerticalPadding,
    ),
  );
}
