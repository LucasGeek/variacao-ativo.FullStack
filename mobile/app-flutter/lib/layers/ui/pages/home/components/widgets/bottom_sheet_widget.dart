import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../components/components.dart';
import '../../home_presenter.dart';

class BottomSheetWidget extends StatelessWidget {
  final HomePresenter presenter;

  const BottomSheetWidget({
    required this.presenter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (getPlatformStyle().isCupertino) {
      return CupertinoButton(
        onPressed: () => menuCupertino(context),
        padding: EdgeInsets.zero,
        child: const Icon(
          CupertinoIcons.ellipsis,
        ),
      );
    }

    return IconButton(
      onPressed: () => menuMaterial(context),
      icon: const Icon(
        Icons.menu,
      ),
    );
  }

  void menuMaterial(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.filter_list),
                title: const Text('Filtros'),
                onTap: () {
                  Get.back();
                  presenter.toGoFilter();
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuração'),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancelar'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );

  void menuCupertino(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                presenter.toGoFilter();
              },
              child: const Text('Filtros'),
            ),
            CupertinoActionSheetAction(
              child: const Text('Configuração'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      );
}
