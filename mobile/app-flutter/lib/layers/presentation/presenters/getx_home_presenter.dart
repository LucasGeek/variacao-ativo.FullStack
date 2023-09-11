import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../commons/commons.dart';
import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxHomePresenter extends GetxController with LoadingManager, NavigationManager, UISnackbarMessageManager implements HomePresenter {
  GetxHomePresenter({
    required this.remoteYahooChart,
    required this.localYahooChart,
  });

  static const active = "PETR4.SA";

  final RemoteYahooChart remoteYahooChart;
  final LocalYahooChart localYahooChart;

  late MethodChannel _channel;

  @override
  void onInit() {
    _channel = const MethodChannel('app-flutter-engine');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setActive") {
        activeSelected = (call.arguments as String?) ?? active;
        isReceiver = true;
        fetch();
      } else {
        throw Exception('not implemented ${call.method}');
      }
    });

    fetch();
    super.onInit();
  }

  final Rx<TotalItemEnum> _totalItemRx = Rx<TotalItemEnum>(TotalItemEnum.thirty);
  set totalItem(TotalItemEnum value) => _totalItemRx.value = value;

  final Rx<IntervalEnum> _intervalRx = Rx<IntervalEnum>(IntervalEnum.oneDay);
  set interval(IntervalEnum value) => _intervalRx.value = value;

  final Rx<RangeDateEnum> _rangeDateRx = Rx<RangeDateEnum>(RangeDateEnum.oneYear);
  set rangeDate(RangeDateEnum value) => _rangeDateRx.value = value;

  @override
  RxList<ChartViewModel> get chartListRx => _chartList;
  final RxList<ChartViewModel> _chartList = RxList<ChartViewModel>([]);
  set chartList(List<ChartViewModel> value) => _chartList.value = value;

  @override
  RxList<TableViewModel> get tableListRx => _tableList;
  final RxList<TableViewModel> _tableList = RxList<TableViewModel>([]);
  set tableList(List<TableViewModel> value) => _tableList.value = value;

  @override
  RxString get activeSelectedRx => _activeSelectedRx;
  final _activeSelectedRx = active.obs;
  set activeSelected(String value) => _activeSelectedRx.value = value;

  @override
  RxBool get isReceiverRx => _isReceiver;
  final _isReceiver = false.obs;
  set isReceiver(bool value) => _isReceiver.value = value;

  @override
  int random() => 5 + Random().nextInt(50);

  @override
  void changeTotalItem(TotalItemEnum value) => totalItem = value;

  @override
  void changeRangeDate(RangeDateEnum value) => rangeDate = value;

  @override
  void changeInterval(IntervalEnum value) => interval = value;

  @override
  void toGoFilter() => navigateTo = {'/filter': false};

  @override
  Future<void> fetch() async {
    int startTimestamp = 0;
    int finalTimestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    switch (_rangeDateRx.value) {
      case RangeDateEnum.oneDay:
        startTimestamp = calcTimestamp(1);
        break;
      case RangeDateEnum.oneWeek:
        startTimestamp = calcTimestamp(7);
        break;
      case RangeDateEnum.oneMonth:
        startTimestamp = calcTimestamp(31);
        break;
      case RangeDateEnum.oneYear:
        startTimestamp = calcTimestamp(365);
        break;
    }

    try {
      isLoading = true;

      final either = await remoteYahooChart.fetch(
        activeSelectedRx.value,
        params: LoadYahooChartParams(
          periodOne: startTimestamp,
          periodTwo: finalTimestamp,
          interval: _intervalRx.value.toParams(),
        ),
      );

      either.fold(
        (success) {
          changingDataToView(success);
          saveCache(success);
        },
        (failure) {
          fetchCache();

          List<String> errors = [];
          for (var element in (failure.errors ?? [])) {
            errors.add(element);
          }

          mainSnackbarMessage = UISnackbarMessage(
            message: failure.message.tr,
            details: errors,
          );
        },
      );
    } catch (error) {
      fetchCache();

      mainSnackbarMessage = UISnackbarMessage(
        message: error.toString(),
        details: [],
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> saveCache(YahooChartEntity entity) async {
    try {
      await localYahooChart.delete(activeSelectedRx.value);
      await localYahooChart.save(activeSelectedRx.value, entity);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> fetchCache() async {
    try {
      final either = await localYahooChart.fetch(activeSelectedRx.value);

      either.fold(
        (success) {
          changingDataToView(success);
        },
        (failure) {
          mainSnackbarMessage = UISnackbarMessage(
            message: failure.cause.tr,
            details: [],
          );
        },
      );
    } catch (error) {
      mainSnackbarMessage = UISnackbarMessage(
        message: error.toString(),
        details: [],
      );
    }
  }

  void changingDataToView(YahooChartEntity entity) {
    List<TableViewModel> table = [];
    List<ChartViewModel> chart = [];

    List<double> openWithRange = [];
    List<DateTime> timestampWithRange = [];

    int countTotal = _totalItemRx.value.toCount();

    if (countTotal > entity.open.length) {
      openWithRange = entity.open.getRange(0, entity.open.length).toList();
    } else {
      openWithRange = entity.open.getRange(entity.open.length - countTotal, entity.open.length).toList();
    }

    if (countTotal > entity.timestamp.length) {
      timestampWithRange = entity.timestamp.getRange(0, entity.timestamp.length).toList();
    } else {
      timestampWithRange = entity.timestamp.getRange(entity.timestamp.length - countTotal, entity.timestamp.length).toList();
    }

    for (var index = 0; index < openWithRange.length; index++) {
      double variationInRelationToDMinus1 = calcVariationInRelationToDMinus1(index, openWithRange);
      double variationFromTheFirstDate = calcVariationFromTheFirstDate(index, openWithRange);

      table.add(
        TableViewModel(
          date: timestampWithRange[index].toDDMMYYYY(),
          value: 'R\$ ${openWithRange[index].toStringAsFixed(2)}',
          variationInRelationToDMinus1: variationInRelationToDMinus1 != 0.0 ? "$variationInRelationToDMinus1%" : "-",
          variationFromTheFirstDate: variationFromTheFirstDate != 0.0 ? "$variationFromTheFirstDate%" : "-",
        ),
      );

      chart.add(
        ChartViewModel(
          date: timestampWithRange[index].toDDMMYYYY(),
          variationInRelationToDMinus1: variationInRelationToDMinus1,
          variationFromTheFirstDate: variationFromTheFirstDate,
        ),
      );
    }

    tableList = table;
    chartList = chart;
  }

  double calcVariationInRelationToDMinus1(int index, List<double> list) {
    if (index == 0) {
      return 0.0;
    }

    return double.parse(calcVariation(list[index], list[index - 1]).toStringAsFixed(2));
  }

  double calcVariationFromTheFirstDate(int index, List<double> list) {
    if (index == 0) {
      return 0.0;
    }

    return double.parse(calcVariation(list[index], list[0]).toStringAsFixed(2));
  }

  double calcVariation(double valueAtLaterTime, double valueAtThePreviousMoment) {
    if (valueAtThePreviousMoment == 0.0) {
      return valueAtLaterTime;
    }

    return ((valueAtLaterTime / valueAtThePreviousMoment) - 1) * 100;
  }

  int calcTimestamp(int days) {
    return (DateTime.now().subtract(Duration(days: days)).millisecondsSinceEpoch / 1000).round();
  }
}
