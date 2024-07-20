import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showErrorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.error),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    ),
  );
}
