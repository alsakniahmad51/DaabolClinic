import 'package:flutter/material.dart';

class Moving {
  static void navToPage({required BuildContext context, required Widget page}) {
    Navigator.of(context).push(_createRoute(page));
  }

  static Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // يبدأ من اليمين
        const end = Offset.zero; // ينتهي عند المركز
        const curve = Curves.easeInOut; // تأثير الحركة

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
