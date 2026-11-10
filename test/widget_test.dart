import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:humo_kids/app.dart';
import 'package:humo_kids/features/auth/screens/login_screen.dart';
import 'package:humo_kids/features/auth/screens/otp_screen.dart';
import 'package:humo_kids/features/security/screens/create_pin_screen.dart';
import 'package:humo_kids/features/security/screens/confirm_pin_screen.dart';
import 'package:humo_kids/features/security/screens/pin_login_screen.dart';
import 'package:humo_kids/features/home/screens/main_shell_screen.dart';
import 'package:humo_kids/features/home/screens/activities_schedule_screen.dart';
import 'package:humo_kids/features/home/screens/daily_report_screen.dart';
import 'package:humo_kids/features/home/screens/food_details_screen.dart';
import 'package:humo_kids/features/home/screens/moments_gallery_screen.dart';
import 'package:humo_kids/features/payments/screens/payments_screen.dart';
import 'package:humo_kids/core/theme/app_theme.dart';
import 'package:humo_kids/features/payments/screens/my_cards_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_receipt_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_error_screen.dart';
import 'package:humo_kids/features/payments/screens/card_empty_screen.dart';
import 'package:humo_kids/features/messages/screens/messages_screen.dart';
import 'package:humo_kids/features/messages/screens/chat_screen.dart';
import 'package:humo_kids/features/notifications/screens/notifications_screen.dart';
import 'package:humo_kids/features/profile/screens/profile_screen.dart';

Widget createTestWidget(Widget child) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    home: Scaffold(
      body: child,
    ),
  );
}

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HumoKidsApp());
    expect(find.byType(HumoKidsApp), findsOneWidget);
  });

  testWidgets('LoginScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const LoginScreen()));
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('OtpScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const OtpScreen(phone: '+998901234567')));
    expect(find.byType(OtpScreen), findsOneWidget);
  });

  testWidgets('Security screens smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const CreatePinScreen()));
    expect(find.byType(CreatePinScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const ConfirmPinScreen(pin: '1234')));
    expect(find.byType(ConfirmPinScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const PinLoginScreen()));
    expect(find.byType(PinLoginScreen), findsOneWidget);
  });

  testWidgets('MainShellScreen and Home features smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const MainShellScreen()));
    expect(find.byType(MainShellScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const ActivitiesScheduleScreen()));
    expect(find.byType(ActivitiesScheduleScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const DailyReportScreen()));
    expect(find.byType(DailyReportScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const FoodDetailsScreen()));
    expect(find.byType(FoodDetailsScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const MomentsGalleryScreen()));
    expect(find.byType(MomentsGalleryScreen), findsOneWidget);
  });

  testWidgets('Payments screens smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const PaymentsScreen()));
    expect(find.byType(PaymentsScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const MyCardsScreen()));
    expect(find.byType(MyCardsScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const PaymentReceiptScreen()));
    expect(find.byType(PaymentReceiptScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const PaymentErrorScreen()));
    expect(find.byType(PaymentErrorScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const CardEmptyScreen()));
    expect(find.byType(CardEmptyScreen), findsOneWidget);
  });

  testWidgets('Messages and Chat smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const MessagesScreen()));
    expect(find.byType(MessagesScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const ChatScreen()));
    expect(find.byType(ChatScreen), findsOneWidget);
  });

  testWidgets('Notifications and Profile smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const NotificationsScreen()));
    expect(find.byType(NotificationsScreen), findsOneWidget);

    await tester.pumpWidget(createTestWidget(const Scaffold(body: ProfileScreen())));
    expect(find.byType(ProfileScreen), findsOneWidget);
  });
}
