import 'package:get/get.dart';

import '../../helpers/helpers.dart';

abstract class FilterPresenter {
  Rx<RangeDateEnum> get rangeDateRx;
  Rx<TotalItemEnum> get totalItemRx;
  Rx<IntervalEnum> get intervalRx;
  RxString get activeSelectedRx;

  void changeTotalItem(TotalItemEnum value);
  void changeRangeDate(RangeDateEnum value);
  void changeInterval(IntervalEnum value);

  void find();
  Future<void> save();
}
