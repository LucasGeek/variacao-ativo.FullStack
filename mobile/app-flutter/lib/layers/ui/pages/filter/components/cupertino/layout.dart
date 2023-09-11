import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../helpers/enum/enum.dart';
import '../../filter.dart';

class CupertinoLayoutFilterPage extends StatelessWidget {
  final String previousPageTitle;
  final FilterPresenter presenter;
  final StreamController<IntervalEnum> intervalController;
  final StreamController<RangeDateEnum> rangeDateController;
  final StreamController<TotalItemEnum> totalItemController;

  const CupertinoLayoutFilterPage({
    super.key,
    required this.presenter,
    required this.previousPageTitle,
    required this.intervalController,
    required this.rangeDateController,
    required this.totalItemController,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: previousPageTitle,
        middle: const Text("Filtros"),
        trailing: CupertinoButton(
          onPressed: presenter.save,
          padding: EdgeInsets.zero,
          child: const Text("Salvar"),
        ),
      ),
      child: ListView(
        children: [
          Obx(() {
            var range = presenter.rangeDateRx.value;
            return StreamBuilder(
              stream: rangeDateController.stream,
              initialData: range,
              builder: ((context, snapshot) {
                var groupValue = snapshot.data ?? range;

                return CupertinoListSection(
                  header: const Text('Intervalo de data'),
                  children: RangeDateEnum.values
                      .map(
                        (e) => CupertinoListTile(
                          title: Text(e.toDescription()),
                          leading: CupertinoRadio<RangeDateEnum>(
                            value: e,
                            groupValue: groupValue,
                            onChanged: (value) {
                              if (value != null) {
                                rangeDateController.sink.add(value);
                              }
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            );
          }),
          Obx(() {
            var interval = presenter.intervalRx.value;
            return StreamBuilder(
              stream: intervalController.stream,
              initialData: interval,
              builder: ((context, snapshot) {
                var groupValue = snapshot.data ?? interval;

                return CupertinoListSection(
                  header: const Text('Intervalo de ativos'),
                  children: IntervalEnum.values
                      .map(
                        (e) => CupertinoListTile(
                          title: Text(e.toDescription()),
                          leading: CupertinoRadio<IntervalEnum>(
                            value: e,
                            groupValue: groupValue,
                            onChanged: (value) {
                              if (value != null) {
                                intervalController.sink.add(value);
                              }
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            );
          }),
          Obx(() {
            var total = presenter.totalItemRx.value;
            return StreamBuilder(
              stream: totalItemController.stream,
              initialData: total,
              builder: ((context, snapshot) {
                var groupValue = snapshot.data ?? total;

                return CupertinoListSection(
                  header: const Text('Mostrar total de items'),
                  children: TotalItemEnum.values
                      .map(
                        (e) => CupertinoListTile(
                          title: Text(e.toDescription()),
                          leading: CupertinoRadio<TotalItemEnum>(
                            value: e,
                            groupValue: groupValue,
                            onChanged: (value) {
                              if (value != null) {
                                totalItemController.sink.add(value);
                              }
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
