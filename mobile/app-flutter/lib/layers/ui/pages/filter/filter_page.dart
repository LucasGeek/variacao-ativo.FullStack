import 'dart:async';

import 'package:get/get.dart';

import '../../ui.dart';
import './components/components.dart';

class FilterPage extends StatefulWidget {
  final FilterPresenter presenter;

  const FilterPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with SingleTickerProviderStateMixin, NavigationManager {
  late PlatformDesign design;

  final StreamController<TotalItemEnum> _totalItemController = StreamController<TotalItemEnum>.broadcast();
  final StreamController<RangeDateEnum> _rangeDateController = StreamController<RangeDateEnum>.broadcast();
  final StreamController<IntervalEnum> _intervalController = StreamController<IntervalEnum>.broadcast();

  @override
  void initState() {
    design = getPlatformStyle();

    _totalItemController.stream.listen((event) {
      widget.presenter.changeTotalItem(event);
    });

    _rangeDateController.stream.listen((event) {
      widget.presenter.changeRangeDate(event);
    });

    _intervalController.stream.listen((event) {
      widget.presenter.changeInterval(event);
    });

    super.initState();
  }

  @override
  void dispose() {
    _totalItemController.close();
    _rangeDateController.close();
    _intervalController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        switch (design) {
          case PlatformDesign.cupertino:
            return Obx(() => CupertinoLayoutFilterPage(
                  presenter: widget.presenter,
                  previousPageTitle: widget.presenter.activeSelectedRx.value,
                  intervalController: _intervalController,
                  rangeDateController: _rangeDateController,
                  totalItemController: _totalItemController,
                ));
          case PlatformDesign.material:
          default:
            return Obx(() {
              return MaterialLayoutFilterPage(
                presenter: widget.presenter,
                previousPageTitle: widget.presenter.activeSelectedRx.value,
                intervalController: _intervalController,
                rangeDateController: _rangeDateController,
                totalItemController: _totalItemController,
              );
            });
        }
      },
    );
  }
}
