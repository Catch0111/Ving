import 'package:ving/provider/view_state_refresh_list_model.dart';
import 'package:ving/provider/view_state_list_model.dart';
import 'package:ving/service/wan_android_repository.dart';

class DiscoverCategoryModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchTreeCategories();
  }
}

class DiscoverListModel extends ViewStateRefreshListModel {
  final int cid;

  DiscoverListModel(this.cid);

  @override
  Future<List> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchVideos(pageNum, cid: cid);
  }
}

/// 网址导航
class NavigationSiteModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchNavigationSite();
  }
}

