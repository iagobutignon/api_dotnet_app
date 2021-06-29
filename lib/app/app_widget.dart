import 'package:api_dotnet_app/app/views/customers/customers_view.dart';
import 'package:api_dotnet_app/shared/themes/default_theme.dart';
import 'package:api_dotnet_app/shared/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'controllers/user_controller.dart';
import 'views/login/login_view.dart';
import 'views/register/register_view.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: Builder(builder: (context) {
        UserController userController =
            Provider.of<UserController>(context, listen: true);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TZ Vendas',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('pt', 'BR')],
          theme: defaultTheme,
          home: userController.user.id == '' ? LoginView() : CustomersView(),
          locale: Locale('pt', 'BR'),
          routes: {
            Routes.register: (ctx) => RegisterView(),
          },
        );
      }),
    );
  }
}
