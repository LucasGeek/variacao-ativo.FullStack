import 'dart:async';

import '../../../../ui.dart';
import '../widgets/widgets.dart';

class MaterialLayoutHomePage extends StatefulWidget {
  final HomePresenter presenter;
  final String activeSelected;
  final bool isReceiver;

  const MaterialLayoutHomePage({
    super.key,
    required this.presenter,
    required this.activeSelected,
    required this.isReceiver,
  });

  @override
  State<MaterialLayoutHomePage> createState() => _MaterialLayoutHomePageState();
}

class _MaterialLayoutHomePageState extends State<MaterialLayoutHomePage> with SingleTickerProviderStateMixin {
  final StreamController<int> _indexPageController = StreamController<int>.broadcast();

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) => _indexPageController.sink.add(index);

  void bottomTapped(int index) {
    _indexPageController.sink.add(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _indexPageController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.isReceiver
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: Text(widget.activeSelected),
        actions: [
          BottomSheetWidget(
            presenter: widget.presenter,
          ),
        ],
      ),
      body: PageView(
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChanged,
        children: [
          RefreshIndicator(
            onRefresh: widget.presenter.fetch,
            child: TableWidget(presenter: widget.presenter),
          ),
          ChartWidget(presenter: widget.presenter),
        ],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: _indexPageController.stream,
          initialData: 0,
          builder: (context, snapshot) {
            int indexPage = snapshot.data ?? 0;
            return BottomNavigationBar(
              onTap: bottomTapped,
              currentIndex: indexPage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart_outlined),
                  activeIcon: Icon(Icons.table_chart_rounded),
                  label: "Tabela",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_line_chart_outlined),
                  activeIcon: Icon(Icons.stacked_line_chart_rounded),
                  label: "Gráfico",
                ),
              ],
            );
          }),
    );
  }
}
