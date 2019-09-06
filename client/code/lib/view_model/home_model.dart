import 'package:ving/model/video.dart';
import 'package:ving/model/banner.dart';
import 'package:ving/provider/view_state_refresh_list_model.dart';
import 'package:ving/service/wan_android_repository.dart';

class HomeModel extends ViewStateRefreshListModel {
  List<Banner> _banners;
  List<Video> _topArticles;

  List<Banner> get banners => _banners;

  List<Video> get topArticles => _topArticles;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    } else {
      return result[0];
    }

//    if (pageNum == BaseListModel.pageNumFirst) {
//      _banners = await WanAndroidRepository.fetchBanners();
//      _topArticles = await WanAndroidRepository.fetchTopArticles();
//    }
//    return await WanAndroidRepository.fetchArticles(pageNum);
  }
}
