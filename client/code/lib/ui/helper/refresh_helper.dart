import 'package:flutter/material.dart';
import 'package:ving/generated/i18n.dart';
// import 'package:ving/ui/page/tab/home_second_floor_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 首页列表的header
class HomeRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      idleText: I18n.of(context).refreshIdle,
      releaseText: I18n.of(context).refreshRefreshWhenRelease,
      refreshingText: I18n.of(context).refreshing,
      completeText: I18n.of(context).refreshComplete,
      canTwoLevelText: I18n.of(context).refreshTwoLevel,
      textStyle: TextStyle(color: Colors.white),
      // outerBuilder: (child) => HomeSecondFloorOuter(child),
      twoLevelView: Container(),
    );
  }
}

/// 通用的footer
///
/// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: I18n.of(context).loadMoreFailed,
      idleText: I18n.of(context).loadMoreIdle,
      loadingText: I18n.of(context).loadMoreLoading,
      noDataText: I18n.of(context).loadMoreNoData,
    );
  }
}
