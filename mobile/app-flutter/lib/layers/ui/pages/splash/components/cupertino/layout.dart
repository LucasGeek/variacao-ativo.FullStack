import 'package:flutter/cupertino.dart';

import '../../splash.dart';

class CupertinoLayoutSplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const CupertinoLayoutSplashPage({
    super.key,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
