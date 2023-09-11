import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/helpers.dart';
import '../../filter.dart';

class MaterialLayoutFilterPage extends StatelessWidget {
  final String previousPageTitle;
  final FilterPresenter presenter;
  final StreamController<IntervalEnum> intervalController;
  final StreamController<RangeDateEnum> rangeDateController;
  final StreamController<TotalItemEnum> totalItemController;

  const MaterialLayoutFilterPage({
    super.key,
    required this.presenter,
    required this.previousPageTitle,
    required this.intervalController,
    required this.rangeDateController,
    required this.totalItemController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Filtros"),
        actions: [
          TextButton(
            onPressed: presenter.save,
            child: const Text("Salvar"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              title: Text('Intervalo de data'),
            ),
            Obx(() {
              var range = presenter.rangeDateRx.value;
              return StreamBuilder(
                stream: rangeDateController.stream,
                initialData: range,
                builder: ((context, snapshot) {
                  var groupValue = snapshot.data ?? range;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: RangeDateEnum.values.length,
                    itemBuilder: (context, index) => RadioListTile<RangeDateEnum>(
                      title: Text(RangeDateEnum.values[index].toDescription()),
                      value: RangeDateEnum.values[index],
                      groupValue: groupValue,
                      onChanged: (value) {
                        if (value != null) {
                          rangeDateController.sink.add(value);
                        }
                      },
                    ),
                  );
                }),
              );
            }),
            const ListTile(
              title: Text('Intervalo de ativos'),
            ),
            Obx(() {
              var interval = presenter.intervalRx.value;
              return StreamBuilder(
                stream: intervalController.stream,
                initialData: interval,
                builder: ((context, snapshot) {
                  var groupValue = snapshot.data ?? interval;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: IntervalEnum.values.length,
                    itemBuilder: (context, index) => RadioListTile<IntervalEnum>(
                      title: Text(IntervalEnum.values[index].toDescription()),
                      value: IntervalEnum.values[index],
                      groupValue: groupValue,
                      onChanged: (value) {
                        if (value != null) {
                          intervalController.sink.add(value);
                        }
                      },
                    ),
                  );
                }),
              );
            }),
            const ListTile(
              title: Text('Mostrar total de items'),
            ),
            Obx(() {
              var total = presenter.totalItemRx.value;
              return StreamBuilder(
                stream: totalItemController.stream,
                initialData: total,
                builder: ((context, snapshot) {
                  var groupValue = snapshot.data ?? total;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: TotalItemEnum.values.length,
                    itemBuilder: (context, index) => RadioListTile<TotalItemEnum>(
                      title: Text(TotalItemEnum.values[index].toDescription()),
                      value: TotalItemEnum.values[index],
                      groupValue: groupValue,
                      onChanged: (value) {
                        if (value != null) {
                          totalItemController.sink.add(value);
                        }
                      },
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
