import 'package:flutter/material.dart';

class AppLoader {
  AppLoader._();

  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    final overlayState = Navigator.of(context).overlay;
    print('show');

    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              hide();
            }
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              )
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}