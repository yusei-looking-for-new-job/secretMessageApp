import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stego_app/Model/ImageModel.dart';

void showExtStringDialog(BuildContext context, ExtStringModel extStringModel) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.extractedString),
      content: SingleChildScrollView(
        child: SelectableText(extStringModel.extString!),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    ),
  );
}
