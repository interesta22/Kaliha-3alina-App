import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

abstract class Alerts {
  static void successDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        color: AppColors.primary,
        messageTextStyle: AppTextStyles.font17WhiteMedium.copyWith(
          color: AppColors.white,
        ),
        titleTextStyle: AppTextStyles.font20BlackBold.copyWith(
          color: AppColors.white,
        ),
        title: title,
        message: message,
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void failureDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        messageTextStyle: AppTextStyles.font17WhiteMedium.copyWith(
          color: AppColors.white,
        ),
        titleTextStyle: AppTextStyles.font20BlackBold.copyWith(
          color: AppColors.white,
        ),
        title: title,
        message: message,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
