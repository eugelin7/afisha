import 'package:afisha/ui/screens/event_screen/event_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:afisha/ui/screens/main_screen/main_screen.dart';

final List<GoRoute> kAppRoutes = [
  GoRoute(
    name: 'main',
    path: '/',
    builder: (_, state) => const MainScreen(),
  ),
  GoRoute(
    name: EventScreen.name,
    path: EventScreen.path,
    builder: (_, state) => EventScreen(id: state.pathParameters['id']!),
  ),
];
