import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ving/config/ui_adapter_config.dart';
import 'package:ving/config/storage_manager.dart';
import 'package:ving/ui/page/splash.dart';

import 'config/provider_manager.dart';
import 'config/router_config.dart';
import 'generated/i18n.dart';
import 'view_model/locale_model.dart';
import 'view_model/theme_model.dart';


void main() async {
  IjkConfig.isLog = true;
  Provider.debugCheckInvalidValueType = null;

  /// 全局屏幕适配方案
  InnerWidgetsFlutterBinding.ensureInitialized()
    ..attachRootWidget(App(future: StorageManager.init()))
    ..scheduleWarmUpFrame();

  await IjkManager.initIJKPlayer();
}

class App extends StatelessWidget {
  final Future future;

  const App({this.future});

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SplashImage();
        }
        return OKToast(
            child: MultiProvider(
              providers: providers,
              child: Consumer2<ThemeModel, LocaleModel>(
                  builder: (context, themeModel, localeModel, child) {
                return RefreshConfiguration(
                  hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: themeModel.themeData,
                    darkTheme: themeModel.darkTheme,
                    locale: localeModel.locale,
                    localizationsDelegates: [
                      i18n,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: I18n.delegate.supportedLocales,
                    onGenerateRoute: Router.generateRoute,
                    localeResolutionCallback: i18n.resolution(fallback: new Locale("en", "US")),
                    initialRoute: RouteName.splash,
                  ),
                );
              })));
      },
    );
  }
}
