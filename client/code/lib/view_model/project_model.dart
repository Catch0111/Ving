import 'package:ving/model/article.dart';
import 'package:ving/model/tree.dart';
import 'package:ving/provider/view_state_refresh_list_model.dart';
import 'package:ving/provider/view_state_list_model.dart';
import 'package:ving/service/wan_android_repository.dart';

class ProjectCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchProjectCategories();
  }
}

class ProjectListModel extends ViewStateRefreshListModel<Article> {
  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: 294);
  }
}
