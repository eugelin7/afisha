import 'package:go_router/go_router.dart';
import 'package:afisha/ui/screens/main_screen/main_screen.dart';

final List<GoRoute> kAppRoutes = [
  GoRoute(
    name: 'main',
    path: '/',
    builder: (_, state) => const MainScreen(),
  ),
];
