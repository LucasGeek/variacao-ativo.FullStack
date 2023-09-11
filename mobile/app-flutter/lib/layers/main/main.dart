import 'package:get/get.dart';

import '../ui/ui.dart';
import './factories/factories.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Variação de Ativo';
    List<GetPage> getPages = [
      GetPage(
        name: '/',
        page: makeSplashPage,
      ),
      GetPage(
        name: '/home',
        page: makeHomePage,
      ),
      GetPage(
        name: '/filter',
        page: makeFilterPage,
      ),
    ];

    if (getPlatformStyle().isCupertino) {
      return GetCupertinoApp(
        navigatorKey: Get.key,
        title: title,
        enableLog: kDebugMode,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: getPages,
      );
    }

    return GetMaterialApp(
      navigatorKey: Get.key,
      title: title,
      enableLog: kDebugMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      getPages: getPages,
    );
  }
}
