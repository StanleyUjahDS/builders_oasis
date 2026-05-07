import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class MessageHelper {

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, ContentType.failure);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, ContentType.success);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, ContentType.help);
  }

  static void _showSnackBar(
      BuildContext context,
      String message,
      ContentType type,
      ) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: type == ContentType.failure
            ? 'Error'
            : type == ContentType.success
            ? 'Success'
            : 'Info',
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}