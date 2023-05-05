enum AppRoutes {
  dashboard(
    name: 'dashboard',
    path: '/',
  ),
  login(
    name: 'login',
    path: '/login',
  ),
  logout(
    name: 'logout',
    path: '/logout',
  ),
  ;

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  @override
  String toString() => name;
}
