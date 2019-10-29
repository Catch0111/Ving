import 'package:flutter/foundation.dart';
import 'package:ving/model/video.dart';
import 'package:ving/model/banner.dart';
import 'package:ving/provider/view_state_refresh_list_model.dart';
import 'package:ving/service/wan_android_repository.dart';
import 'package:ving/utils/log_util.dart';

class HomeModel extends ViewStateRefreshListModel {
  List<Banner> _banners;
  List<Video> _videos;

  List<Banner> get banners => _banners;

  List<Video> get videos => _videos;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopVideos());
    }
    futures.add(WanAndroidRepository.fetchVideos(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      _videos = result[1];
      LogUtil.e("videos ----- ");
      LogUtil.e(_videos);
      return result[2];
    } else {
      return result[0];
    }

//    if (pageNum == BaseListModel.pageNumFirst) {
//      _banners = await WanAndroidRepository.fetchBanners();
//      _videos = await WanAndroidRepository.fetchTopArticles();
//    }
//    return await WanAndroidRepository.fetchVideos(pageNum);
  }
}
