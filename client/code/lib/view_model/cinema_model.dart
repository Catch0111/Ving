import 'package:ving/model/article.dart';
import 'package:ving/model/tree.dart';
import 'package:ving/provider/view_state_refresh_list_model.dart';
import 'package:ving/provider/view_state_list_model.dart';
import 'package:ving/service/wan_android_repository.dart';

/// 微信公众号
class CinameCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchWechatAccounts();
  }
}

/// 微信公众号文章
class CinameListModel extends ViewStateRefreshListModel<Article> {
  /// 公众号id
  final int id;

  CinameListModel(this.id);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchWechatAccountArticles(pageNum, id);
  }
}
