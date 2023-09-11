import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import 'filter_presenter_factory.dart';

Widget makeFilterPage() {
  final presenter = Get.put<FilterPresenter>(makeGetxFilterPresenter());
  return FilterPage(presenter);
}
