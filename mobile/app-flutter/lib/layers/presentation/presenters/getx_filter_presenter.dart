import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxFilterPresenter extends GetxController implements FilterPresenter {
  GetxFilterPresenter();

  @override
  void onInit() {
    find();
    super.onInit();
  }

  @override
  Rx<IntervalEnum> get intervalRx => _intervalRx;
  final Rx<IntervalEnum> _intervalRx = Rx<IntervalEnum>(IntervalEnum.oneDay);
  set interval(IntervalEnum value) => _intervalRx.value = value;

  @override
  Rx<RangeDateEnum> get rangeDateRx => _rangeDateRx;
  final Rx<RangeDateEnum> _rangeDateRx = Rx<RangeDateEnum>(RangeDateEnum.oneYear);
  set rangeDate(RangeDateEnum value) => _rangeDateRx.value = value;

  @override
  Rx<TotalItemEnum> get totalItemRx => _totalItemRx;
  final Rx<TotalItemEnum> _totalItemRx = Rx<TotalItemEnum>(TotalItemEnum.thirty);
  set totalItem(TotalItemEnum value) => _totalItemRx.value = value;

  @override
  RxString get activeSelectedRx => _activeSelectedRx;
  final _activeSelectedRx = "".obs;
  set activeSelected(String value) => _activeSelectedRx.value = value;

  @override
  void changeTotalItem(TotalItemEnum value) => totalItem = value;

  @override
  void changeRangeDate(RangeDateEnum value) => rangeDate = value;

  @override
  void changeInterval(IntervalEnum value) => interval = value;

  @override
  Future<void> save() async {
    if (Get.isRegistered<HomePresenter>()) {
      var home = Get.find<HomePresenter>();

      home.changeInterval(_intervalRx.value);
      home.changeTotalItem(_totalItemRx.value);
      home.changeRangeDate(_rangeDateRx.value);

      home.fetch();
    }

    Get.back();
  }

  @override
  Future<void> find() async {
    if (Get.isRegistered<HomePresenter>()) {
      var home = Get.find<HomePresenter>();

      activeSelected = home.activeSelectedRx.value;
    }
  }
}
