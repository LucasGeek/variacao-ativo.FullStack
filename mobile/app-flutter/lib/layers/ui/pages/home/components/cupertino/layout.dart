import 'package:flutter/cupertino.dart';

import '../../home.dart';
import '../widgets/widgets.dart';

class CupertinoLayoutHomePage extends StatelessWidget {
  final HomePresenter presenter;
  final String activeSelected;
  final bool isReceiver;

  const CupertinoLayoutHomePage({
    Key? key,
    required this.presenter,
    required this.activeSelected,
    required this.isReceiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.table),
            label: "Tabela",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_square),
            label: "Gráfico",
          ),
        ],
      ),
      tabBuilder: (BuildContext tabCtx, int index) => CupertinoTabView(
        builder: (BuildContext _) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(activeSelected),
            leading: isReceiver
                ? CupertinoNavigationBarBackButton(
                    previousPageTitle: 'Voltar',
                    onPressed: () {},
                  )
                : null,
            trailing: BottomSheetWidget(
              presenter: presenter,
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: presenter.fetch,
                ),
                SliverFillRemaining(
                  child: IndexedStack(
                    index: index,
                    children: [
                      TableWidget(presenter: presenter),
                      ChartWidget(presenter: presenter),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
