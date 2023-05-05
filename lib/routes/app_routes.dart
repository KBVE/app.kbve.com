enum AppRoutes {
  dashboard(
    name: 'dashboard',
    path: '/',
  ),
  asset(
    name: 'asset',
    path: '/asset',
  ),
  login(
    name: 'login',
    path: '/login',
  ),
  logout(
    name: 'logout',
    path: '/logout',
  ),
  tools(
    name: 'tools',
    path: '/tools',
  ),
  application(
    name: 'application',
    path: '/application',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => name;
}
