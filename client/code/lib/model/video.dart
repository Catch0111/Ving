import 'package:ving/utils/string_utils.dart';

class Video {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  String prefix;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<TagsBean> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;



  static Video fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Video videoBean = Video();
    videoBean.apkLink = map['apkLink'];
    videoBean.author = map['author'];
    videoBean.chapterId = map['chapterId'];
//    videoBean.chapterName = map['chapterName'];
    videoBean.chapterName = StringUtils.urlDecoder(map["chapterName"]);
    videoBean.collect = map['collect'];
    videoBean.courseId = map['courseId'];
//    videoBean.desc = map['desc'];
    videoBean.desc = StringUtils.urlDecoder(map["desc"]);
    videoBean.envelopePic = map['envelopePic'];
    videoBean.fresh = map['fresh'];
    videoBean.id = map['id'];
    videoBean.link = map['link'];
    videoBean.niceDate = map['niceDate'];
    videoBean.origin = map['origin'];
    videoBean.originId = map['originId'];
    videoBean.prefix = map['prefix'];
    videoBean.projectLink = map['projectLink'];
    videoBean.publishTime = map['publishTime'];
    videoBean.superChapterId = map['superChapterId'];
//    videoBean.superChapterName = map['superChapterName'];
    videoBean.superChapterName = StringUtils.urlDecoder(map["superChapterName"]);
    videoBean.tags = List()
      ..addAll((map['tags'] as List ?? []).map((o) => TagsBean.fromMap(o)));
    videoBean.title = StringUtils.urlDecoder(map["title"]);
    videoBean.type = map['type'];
    videoBean.userId = map['userId'];
    videoBean.visible = map['visible'];
    videoBean.zan = map['zan'];
    return videoBean;
  }

  Map toJson() => {
        "apkLink": apkLink,
        "author": author,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": desc,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "origin": origin,
        "originId": originId,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": tags,
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
      };
}

class TagsBean {
  String name;
  String url;

  static TagsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TagsBean tagsBean = TagsBean();
    tagsBean.name = map['name'];
    tagsBean.url = map['url'];
    return tagsBean;
  }

  Map toJson() => {
        "name": name,
        "url": url,
      };
}
