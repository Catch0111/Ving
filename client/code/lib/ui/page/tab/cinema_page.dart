import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:ving/model/article.dart';
import 'package:ving/ui/helper/refresh_helper.dart';
import 'package:ving/ui/widget/article_list_Item.dart';
import 'package:ving/ui/widget/article_skeleton.dart';
import 'package:ving/ui/widget/skeleton.dart';
import 'package:ving/view_model/cinema_model.dart';
import 'package:provider/provider.dart';
import 'package:ving/model/tree.dart';
import 'package:ving/provider/provider_widget.dart';

import 'package:ving/provider/view_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'message_page.dart';

class CinemaPage extends StatefulWidget {
  @override
  _CinemaPageState createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CinameCategoryModel>(
        model: CinameCategoryModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.busy) {
            return Center(child: CircularProgressIndicator());
          } else if (model.error) {
            return ViewStateWidget(onPressed: model.initData);
          }

          List<Tree> treeList = model.list;
          var primaryColor = Theme.of(context).primaryColor;

          return ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
              length: model.list.length,
              initialIndex: valueNotifier.value,
              child: Builder(
                builder: (context) {
                  if (tabController == null) {
                    tabController = DefaultTabController.of(context);
                    tabController.addListener(() {
                      valueNotifier.value = tabController.index;
                    });
                  }
                  return Scaffold(
                    appBar: AppBar(
                      title: Stack(
                        children: [
                          CategoryDropdownWidget(
                              Provider.of<CinameCategoryModel>(context)),
                          Container(
                            margin: const EdgeInsets.only(right: 25),
                            color: primaryColor.withOpacity(1),
                            child: TabBar(
                                isScrollable: true,
                                tabs: List.generate(
                                    treeList.length,
                                    (index) => Tab(
                                          text: treeList[index].name,
                                        ))),
                          )
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: List.generate(treeList.length,
                          (index) => CinameList(treeList[index].id)),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

/// 微信公众号 文章列表
class CinameList extends StatefulWidget {
  final int id;

  CinameList(this.id);

  @override
  _CinameListState createState() => _CinameListState();
}

class _CinameListState extends State<CinameList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<CinameListModel>(
      model: CinameListModel(widget.id),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.busy) {
          return SkeletonList(
            builder: (context, index) => ArticleSkeletonItem(),
          );
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.initData);
        } else if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            footer: RefresherFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  Article item = model.list[index];
                  return ArticleItemWidget(item);
                }));
      },
    );
  }
}
