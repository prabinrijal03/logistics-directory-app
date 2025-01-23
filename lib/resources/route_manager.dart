import 'package:flutter/material.dart';
import 'package:logistics_directory_app/presentation/pages/authentication/register.dart';

import '../presentation/pages/authentication/login.dart';
import '../presentation/pages/dashboard/admin_dashboard_page.dart';
import '../presentation/pages/home/home_page.dart';

enum AppRoute {
  homePage('/home', HomePage()),
  dashboardPage('/dashboard', AdminDashboardPage()),
  register('/register', Register()),
  login('/login', Login());

  final String path;
  final Widget page;
  const AppRoute(this.path, this.page);
  static AppRoute get initialRoute => AppRoute.homePage;
  static final _routeNameMap = AppRoute.values.asNameMap();
  static final _routePathMap = Map.fromEntries(
    _routeNameMap.entries.map(
      (entry) => MapEntry(entry.value.path, entry.value),
    ),
  );
  static AppRoute? fromName(String? name) => _routePathMap[name];

  static Widget _getWidget(
    RouteSettings routeSettings,
  ) {
    final routeSettingsName = routeSettings.name;
    return AppRoute.fromName(routeSettingsName)?.page ?? Container();
  }

  static Route<dynamic> getRoute(
    RouteSettings routeSettings,
  ) {
    final isInitialRoute = routeSettings.name == AppRoute.initialRoute.path;

    return MaterialPageRoute(
      builder: (context) {
        final widget = _getWidget(routeSettings);
        if (isInitialRoute) {
          return PopScope(
            canPop: false,
            child: widget,
          );
        }
        return widget;
      },
    );
  }
}
