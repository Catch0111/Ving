import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ving/generated/i18n.dart';
// import 'package:ving/ui/page/change_log_page.dart';
// import 'package:ving/view_model/coin_model.dart';
import 'package:provider/provider.dart';
import 'package:ving/config/resource_mananger.dart';
import 'package:ving/config/router_config.dart';
import 'package:ving/provider/provider_widget.dart';
import 'package:ving/ui/widget/bottom_clipper.dart';
import 'package:ving/view_model/login_model.dart';
import 'package:ving/view_model/theme_model.dart';
import 'package:ving/view_model/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            ProviderWidget<LoginModel>(
                model: LoginModel(Provider.of(context)),
                builder: (context, model, child) => Offstage(
                      offstage: !model.userModel.hasUser,
                      child: IconButton(
                        tooltip: I18n.of(context).logout,
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          model.logout();
                        },
                      ),
                    ))
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 240,
          flexibleSpace: UserHeaderWidget(),
          pinned: false,
        ),
        UserListWidget(),
      ],
    ));
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: BottomClipper(),
        child: Container(
            color: Theme.of(context).primaryColor.withAlpha(200),
            padding: EdgeInsets.only(top: 10),
            child: Consumer<UserModel>(
                builder: (context, model, child) => InkWell(
                    onTap: model.hasUser
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(RouteName.login);
                          },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Hero(
                              tag: 'loginLogo',
                              child: ClipOval(
                                child: Image.asset(
                                    ImageHelper.wrapAssets('user_avatar.png'),
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    color: model.hasUser
                                        ? Theme.of(context)
                                            .accentColor
                                            .withAlpha(200)
                                        : Theme.of(context)
                                            .accentColor
                                            .withAlpha(10),
                                    // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                    colorBlendMode: BlendMode.colorDodge),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(children: <Widget>[
                            Text(
                                model.hasUser
                                    ? model.user.nickname
                                    : I18n.of(context).toSignIn,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(color: Colors.white.withAlpha(200))),
                            SizedBox(
                              height: 10,
                            ),
                            // if (model.hasUser) UserCoin()
                          ])
                        ])))));
  }
}

// class UserCoin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ProviderWidget<CoinModel>(
//         model: CoinModel(),
//         onModelReady: (model) => model.initData(),
//         builder: (context, model, child) {
//           if (model.busy) {
//             return CupertinoActivityIndicator(radius: 8);
//           }
//           var textStyle = Theme.of(context).textTheme.body1.copyWith(
//               color: Colors.white.withAlpha(200),
//               decoration: TextDecoration.underline);
//           return InkWell(
//               onTap: () {
//                 if (model.error) {
//                   model.initData();
//                 } else if (model.idle) {
//                   Navigator.pushNamed(context, RouteName.coinRecordList);
//                 }
//               },
//               child: model.error
//                   ? Text(I18n.of(context).retry, style: textStyle)
//                   : Text('${I18n.of(context).coin}：${model.coin}',
//                       style: textStyle));
//         });
//   }
// }

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
            title: Text(I18n.of(context).favourites),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.favouriteList);
            },
            leading: Icon(
              Icons.favorite_border,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(I18n.of(context).darkMode),
            onTap: () {
              Provider.of<ThemeModel>(context).switchTheme(
                  brightness: Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light);
            },
            leading: Transform.rotate(
              angle: -pi,
              child: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.brightness_2
                    : Icons.brightness_5,
                color: iconColor,
              ),
            ),
            trailing: CupertinoSwitch(
                activeColor: Theme.of(context).accentColor,
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  Provider.of<ThemeModel>(context).switchTheme(
                      brightness: value ? Brightness.dark : Brightness.light);
                }),
          ),
          SettingThemeWidget(),
          ListTile(
            title: Text(I18n.of(context).setting),
            onTap: () {
              Navigator.pushNamed(context, RouteName.setting);
            },
            leading: Icon(
              Icons.settings,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(I18n.of(context).about),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  // builder: (context) => ChangeLogPage(),
                  builder: null,
                  fullscreenDialog: true,
                ),
              );
            },
            leading: Icon(
              Icons.error_outline,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ]),
      ),
    );
  }
}

class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(I18n.of(context).theme),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries.map((color) {
                return Material(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      var model = Provider.of<ThemeModel>(context);
                      var brightness = Theme.of(context).brightness;
                      model.switchTheme(brightness: brightness, color: color);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              }).toList(),
              Material(
                child: InkWell(
                  onTap: () {
                    var model = Provider.of<ThemeModel>(context);
                    var brightness = Theme.of(context).brightness;
                    model.switchRandomTheme(brightness: brightness);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor)),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
