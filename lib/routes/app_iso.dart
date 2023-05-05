enum AppISO {
  tools(
    name: 'tools',
  ),
  theory(
    name: 'theory',
  ),
  ;

  const AppISO({
    required this.name,
  });

  final String name;

  String p() => '/$name';

  @override
  String toString() => name;
}
