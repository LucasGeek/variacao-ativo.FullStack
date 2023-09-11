import 'package:flutter/material.dart';

import '../../splash.dart';

class MaterialLayoutSplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const MaterialLayoutSplashPage({
    super.key,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
