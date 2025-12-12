import 'package:go_router/go_router.dart';
import 'screens/dashboard_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/create_plan_screen.dart';
import 'screens/plan_detail_screen.dart';
import 'screens/workout_session_screen.dart';
import 'screens/edit_plan_screen.dart';
import 'main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: <RouteBase>[
        GoRoute(path: '/home', builder: (context, state) => const DashboardScreen()),
        GoRoute(path: '/schedule', builder: (context, state) => const ScheduleScreen()),
        GoRoute(path: '/explore', builder: (context, state) => const ExploreScreen()),
        GoRoute(path: '/progress', builder: (context, state) => const ProgressScreen()),
      ],
    ),
    GoRoute(
      path: '/create-plan',
      builder: (context, state) => const CreatePlanScreen(),
    ),
    GoRoute(
      path: '/plan/:planId',
      builder: (context, state) {
        final planId = int.parse(state.pathParameters['planId']!);
        final planName = state.extra as String;
        return PlanDetailScreen(planId: planId, planName: planName);
      },
    ),
    GoRoute(
      path: '/session/:planId',
      builder: (context, state) {
        final planId = int.parse(state.pathParameters['planId']!);
        final planName = state.extra as String;
        return WorkoutSessionScreen(planId: planId, planName: planName);
      },
    ),
    GoRoute(
      path: '/edit-plan/:planId',
      builder: (context, state) {
        final planId = int.parse(state.pathParameters['planId']!);
        return EditPlanScreen(planId: planId);
      },
    ),
  ],
);