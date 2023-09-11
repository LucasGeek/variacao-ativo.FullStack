import 'package:get/get.dart';

import '../../ui.dart';
import 'components/components.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationManager, UISnackbarMessageManager {
  late PlatformDesign design;

  @override
  void initState() {
    design = getPlatformStyle();
    handleSnackbarMessage(widget.presenter.mainSnackbarMessageStream, context);
    handleNavigation(widget.presenter.navigateToStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String activeSelected = widget.presenter.activeSelectedRx.value;
      bool isReceiver = widget.presenter.isReceiverRx.value;

      switch (design) {
        case PlatformDesign.cupertino:
          return CupertinoLayoutHomePage(
            presenter: widget.presenter,
            activeSelected: activeSelected,
            isReceiver: isReceiver,
          );
        case PlatformDesign.material:
        default:
          return MaterialLayoutHomePage(
            presenter: widget.presenter,
            activeSelected: activeSelected,
            isReceiver: isReceiver,
          );
      }
    });
  }
}
