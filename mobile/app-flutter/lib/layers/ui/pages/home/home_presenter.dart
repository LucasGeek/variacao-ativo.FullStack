import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import './viewmodel/viewmodel.dart';

abstract class HomePresenter {
  Stream<SnackbarMessage?> get mainSnackbarMessageStream;
  Stream<Map<String, bool>?> get navigateToStream;
  RxList<TableViewModel> get tableListRx;
  RxList<ChartViewModel> get chartListRx;
  RxString get activeSelectedRx;
  RxBool get isLoadingRx;
  RxBool get isReceiverRx;

  int random();

  void changeTotalItem(TotalItemEnum value);
  void changeRangeDate(RangeDateEnum value);
  void changeInterval(IntervalEnum value);

  void toGoFilter();

  Future<void> fetch();
}
