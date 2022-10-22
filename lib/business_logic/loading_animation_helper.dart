import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimationHelper{

  static BuildContext? _dialogContext;
  static Future<void> showLoading(BuildContext context) async {
  hideLoading(isClean: true);
  showDialog<dynamic>(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext dialogContext) {
  _dialogContext = dialogContext;
  SchedulerBinding.instance.addPostFrameCallback((_) {

  hideLoading();

  });
  return Material(
  type: MaterialType.transparency,
  child: Center(
  child: Container(
  alignment: Alignment.center,
  child: SpinKitDoubleBounce(color: Colors.white),
  ),
  ),
  );
  },
  );
  }

  /// Hide loading dialog
  static void hideLoading({bool isClean = false}) {
  if (_dialogContext != null) {
  if (Navigator.canPop(_dialogContext!)) {
  Navigator.pop(_dialogContext!);
  }
  _dialogContext = null;
  }
  }

}
