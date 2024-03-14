import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:planeaciones/models/objects.dart';
import 'package:planeaciones/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'nueva_planeacion',
        name: 'Nueva Planeación',
        title: const Text('Nueva Planeación'),
        screen: const Planning(),
        icon: const Icon(FluentIcons.page_add)),
    MenuOption(
        route: 'enviadas',
        name: 'Nueva Planeación',
        title: const Text('Editar Planeación'),
        screen: const AlertScreen(),
        icon: const Icon(FluentIcons.page_edit)),
    MenuOption(
        route: 'alert',
        name: 'Reimprimir Planeación',
        title: const Text('Reimprimir Planeación'),
        screen: const AlertScreen(),
        icon: const Icon(FluentIcons.print)),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (BuildContext context) => const RoutesScreen()});
    for (final options in menuOptions) {
      appRoutes
          .addAll({options.route: (BuildContext context) => options.screen});
    }
    return appRoutes;
  }

  List<NavigationPaneItem> getAppPane() {
    List<NavigationPaneItem> appPane = [];
    for (final options in menuOptions) {
      appPane.add(PaneItem(
        key: GlobalKey(),
        icon: options.icon,
        body: options.screen,
        title: options.title,
      ));
    }
    return appPane;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
