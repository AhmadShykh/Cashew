import 'package:budget/firebase_options.dart';
import 'package:budget/functions.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/globalSnackbar.dart';
import 'package:budget/widgets/openSnackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:googleapis/abusiveexperiencereport/v1.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

bool isGoogleDriveApiDisabledError(Object error) {
  final String message = error.toString().toLowerCase();
  return message.contains('drive api has not been used') ||
      message.contains('drive.googleapis.com') && message.contains('403') ||
      (error is DetailedApiRequestError &&
          error.status == 403 &&
          (error.message ?? '').toLowerCase().contains('drive'));
}

Future<void> showGoogleDriveSetupErrorIfNeeded(Object error) async {
  if (!isGoogleDriveApiDisabledError(error)) return;

  debugPrint('Google Drive API is disabled for this Cloud project: $error');

  openSnackbar(
    SnackbarMessage(
      title: 'google-drive-api-disabled'.tr(),
      description: 'google-drive-api-disabled-description'.tr(),
      icon: appStateSettings['outlinedIcons']
          ? Icons.cloud_off_outlined
          : Icons.cloud_off_rounded,
      timeout: const Duration(milliseconds: 8000),
      onTap: () {
        openUrl(DefaultFirebaseOptions.googleDriveApiEnableUrl);
      },
    ),
  );
}

Future<bool> handleGoogleApiSignInError(Object error) async {
  if (isGoogleDriveApiDisabledError(error)) {
    await showGoogleDriveSetupErrorIfNeeded(error);
    return true;
  }
  if (error is DetailedApiRequestError && error.status == 401) {
    return false;
  }
  if (error is PlatformException) {
    return false;
  }
  return false;
}
