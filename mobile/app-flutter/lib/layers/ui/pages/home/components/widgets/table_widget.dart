import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../ui.dart';
import '../../../../../../commons/validator/validator.dart';

class TableWidget extends StatelessWidget {
  final HomePresenter presenter;

  const TableWidget({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var list = presenter.tableListRx.toList();
        var loading = presenter.isLoadingRx.value;

        return SfDataGrid(
          source: FinanceDataSource(finances: loading ? [] : list),
          columnWidthMode: ColumnWidthMode.auto,
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
              columnName: 'day',
              allowSorting: true,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Dia',
                ),
              ),
            ),
            GridColumn(
              columnName: 'date',
              allowSorting: false,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Data',
                ),
              ),
            ),
            GridColumn(
              columnName: 'value',
              allowSorting: false,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Valor',
                ),
              ),
            ),
            GridColumn(
              columnName: 'variationInRelationToDMinus1',
              allowSorting: false,
              width: 220,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Variação em relaçào a D-1',
                ),
              ),
            ),
            GridColumn(
              columnName: 'variationFromTheFirstDate',
              allowSorting: false,
              width: 280,
              label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Variação em relação a primeira data',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FinanceDataSource extends DataGridSource {
  FinanceDataSource({required List<TableViewModel> finances}) {
    _fianaceData = finances
        .mapIndexed<DataGridRow>(
          (obj, index) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'day', value: index + 1),
              DataGridCell<String>(columnName: 'date', value: obj.date),
              DataGridCell<String>(columnName: 'value', value: obj.value),
              DataGridCell<String>(columnName: 'variationInRelationToDMinus1', value: obj.variationInRelationToDMinus1),
              DataGridCell<String>(columnName: 'variationFromTheFirstDate', value: obj.variationFromTheFirstDate),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _fianaceData = [];

  @override
  List<DataGridRow> get rows => _fianaceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row
          .getCells()
          .map<Widget>(
            (e) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            ),
          )
          .toList(),
    );
  }
}
