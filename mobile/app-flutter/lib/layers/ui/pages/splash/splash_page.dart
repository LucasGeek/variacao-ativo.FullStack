import '../../ui.dart';
import 'components/components.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;

  const SplashPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin, NavigationManager {
  late PlatformDesign design;

  @override
  void initState() {
    design = getPlatformStyle();
    handleNavigation(widget.presenter.navigateToStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        switch (design) {
          case PlatformDesign.cupertino:
            return CupertinoLayoutSplashPage(
              presenter: widget.presenter,
            );
          case PlatformDesign.material:
          default:
            return MaterialLayoutSplashPage(
              presenter: widget.presenter,
            );
        }
      },
    );
  }
}
