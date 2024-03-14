import 'package:fluent_ui/fluent_ui.dart';
import '../routes/app_routes.dart';

/*
class RoutesScreen extends StatelessWidget {
  const RoutesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: const Text('Routes App'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  leading: Icon(
                    menuOptions[index].icon,
                  ),
                  title: Text(menuOptions[index].name),
                  onTap: () {
                    /*final route = MaterialPageRoute(
                        builder: (context) => const FirstScreen());
                    Navigator.push(context, route);*/
                    //.push: te habilita el retoceso
                    //.pushReplacement: elimina el retroceso a la pantalla anterior
                    Navigator.pushNamed(context, menuOptions[index].route);
                  },
                ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: menuOptions.length));
  }
}
*/
class RoutesScreen extends StatefulWidget {
  const RoutesScreen({Key? key}) : super(key: key);

  @override
  State<RoutesScreen> createState() => _RoutesAppState();
}

class _RoutesAppState extends State<RoutesScreen> {
  final AppRoutes appRoutes = AppRoutes();
  int itemIndex = 0;
  Widget titleItem = const Text('Bienvenido');
  @override
  Widget build(BuildContext context) {
    List<dynamic> paneTitle = appRoutes.getAppPane();
    List<NavigationPaneItem> paneItems = appRoutes.getAppPane();
    return NavigationView(
      appBar: NavigationAppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: titleItem,
          ),
        ),
        leading: Center(
          child: Image.asset(
            'assets/logo_circulo.png',
          ),
        ),
      ),
      pane: NavigationPane(
        header: const Padding(
            padding: EdgeInsets.only(left: 8), child: Text('Planeaciones')),
        items: paneItems,
        selected: itemIndex,
        displayMode: PaneDisplayMode.compact,
        onChanged: (value) {
          titleItem = paneTitle[value].title;
          setState(() {
            itemIndex = value;
            titleItem = paneTitle[value].title;
          });
        },
      ),
    );
  }
}
