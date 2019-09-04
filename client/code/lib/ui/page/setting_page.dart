import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ving/config/storage_manager.dart';
import 'package:ving/generated/i18n.dart';
import 'package:ving/provider/provider_widget.dart';
import 'package:ving/view_model/locale_model.dart';
import 'package:ving/view_model/setting_model.dart';
import 'package:launch_review/launch_review.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:ving/view_model/theme_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).setting),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ProviderWidget<UseWebViewPluginModel>(
                  model: UseWebViewPluginModel(),
                  builder: (context, model, child) => ListTile(
                    title: Text('WebViewPlugin'),
                    onTap: model.switchValue,
                    leading: Icon(
                      Icons.language,
                      color: iconColor,
                    ),
                    trailing: CupertinoSwitch(
                        activeColor: Theme.of(context).accentColor,
                        value: model.value,
                        onChanged: (value) {
                          model.switchValue();
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(I18n.of(context).settingFont),
                      Text(
                        ThemeModel.fontName(
                            Provider.of<ThemeModel>(context).fontIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: ThemeModel.fontValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchFont(index);
                            },
                            groupValue: model.fontIndex,
                            title: Text(ThemeModel.fontName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        I18n.of(context).settingLanguage,
                        style: TextStyle(),
                      ),
                      Text(
                        LocaleModel.localeName(
                            Provider.of<LocaleModel>(context).localeIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: LocaleModel.localeValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<LocaleModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchLocale(index);
                            },
                            groupValue: model.localeIndex,
                            title: Text(LocaleModel.localeName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(I18n.of(context).rate),
                  onTap: () async {
                    LaunchReview.launch(
                        androidAppId: "cn.phoenixsky.funandroid",
                        iOSAppId: "1477299503");
                  },
                  leading: Icon(
                    Icons.star,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(I18n.of(context).feedback),
                  onTap: () async {
                    var url =
                        'mailto:moran.fc@gmail.com?subject=FunAndroid%20Feedback&body=feedback';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      showToast(I18n.of(context).githubIssue);
                      await Future.delayed(Duration(seconds: 1));
                      launch(
                          'https://github.com/phoenixsky/ving/_flutter',
                          forceSafariVC: false);
                    }
                  },
                  leading: Icon(
                    Icons.feedback,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
