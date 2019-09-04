import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:ving/generated/i18n.dart';
import 'package:ving/ui/helper/favourite_helper.dart';
import 'package:ving/config/router_config.dart';
import 'package:ving/model/article.dart';
import 'package:ving/provider/provider_widget.dart';
import 'package:ving/view_model/favourite_model.dart';

import 'Image.dart';
import 'animated_provider.dart';
import 'article_tag.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  /// 隐藏收藏按钮
  final bool hideFavourite;

  ArticleItemWidget(this.article,
      {this.index, this.onTap, this.top: false, this.hideFavourite: false})
      : super(key: ValueKey(article.id));

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      children: <Widget>[
        Material(
          color: top
              ? Theme.of(context).accentColor.withAlpha(10)
              : backgroundColor,
          child: InkWell(
            onTap: onTap ??
                () {
                  Navigator.of(context)
                      .pushNamed(RouteName.articleDetail, arguments: article);
                },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                bottom: Divider.createBorderSide(context, width: 0.7),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: WrapperImage(
                          imageType: ImageType.random,
                          url: article.author,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          article.author,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Text(article.niceDate,
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  if (article.envelopePic.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: ArticleTitleWidget(article.title),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ArticleTitleWidget(article.title),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                article.desc,
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        WrapperImage(
                          url: article.envelopePic,
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      if (top) ArticleTag(I18n.of(context).article_tag_top),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (article.superChapterName != null
                                  ? article.superChapterName + ' · '
                                  : '') +
                              (article.chapterName ?? ''),
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: hideFavourite
              ? SizedBox.shrink()
              : ArticleFavouriteWidget(article),
        )
      ],
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return new Container();
    // return Html(
    //   padding: EdgeInsets.symmetric(vertical: 5),
    //   useRichText: false,
    //   data: title,
    //   defaultTextStyle: Theme.of(context).textTheme.subtitle,
    // );
  }
}

/// 收藏按钮
class ArticleFavouriteWidget extends StatelessWidget {
  final Article article;

  ArticleFavouriteWidget(this.article);

  @override
  Widget build(BuildContext context) {
    ///位移动画的tag
    var uniqueKey = UniqueKey();
    return ProviderWidget<FavouriteModel>(
      model: FavouriteModel(),
      builder: (_, model, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque, //否则padding的区域点击无效
          onTap: () async {
            if (!model.busy) {
              addFavourites(context,
                  article: article, model: model, tag: uniqueKey);
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Hero(
              tag: uniqueKey,
              child: ScaleAnimatedSwitcher(
                child: model.busy
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CupertinoActivityIndicator(radius: 5),
                      )
                    : Icon(
                        article.collect
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent[100]),
              ),
            ),
          ),
        );
      },
    );
  }
}
