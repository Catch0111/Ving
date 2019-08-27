import 'package:flutter/material.dart';
import 'package:code/common/component_index.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class RecommendItem extends StatelessWidget {
  const RecommendItem(
    this.model, {
    this.labelId,
    Key key,
    this.isHome,
    this.controller,
  }) : super(key: key);
  final String labelId;
  final VideoInfoModel model;
  final bool isHome;
  final IjkMediaController controller;
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(context,
            title: model.title, url: model.link, isHome: isHome);
      },
      child: new Container(
          height: 300.0,
          padding: EdgeInsets.only(left: 5, top: 16, right: 16, bottom: 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(
                            'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gaps.hGap5,
                        new Text(
                          model.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.listTitle,
                        ),
                      ],
                    ),
                    
                    new PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      onSelected: (value) => NavigatorUtil.pushPage(context, VideoItem()),
                      icon: Icon(Icons.keyboard_arrow_down),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Preview',
                          child: ListTile(
                            leading: Icon(Icons.visibility),
                            title: Text('Preview'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Share',
                          child: ListTile(
                            leading: Icon(Icons.person_add),
                            title: Text('Share'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Get Link',
                          child: ListTile(
                            leading: Icon(Icons.link),
                            title: Text('Get link'),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'Remove',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Remove'),
                          ),
                        ),
                      ],
                    ),
                ],),
              ),
              new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.0),
                child: VideoItem(videoUrl: 'http://1254070582.vod2.myqcloud.com/3fc671cbvodsh1254070582/2014/2016/07/04/a0f7fdb2be90e5bc-sd.mp4'),
              ),
              // new VideoItem(),
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  new OptItem(
                    labelId: labelId,
                    id: model.originId ?? model.id,
                    isOpted: true,
                    curNum: 5555,
                    iconData: Icons.thumb_up,
                  ),
                  new OptItem(
                    labelId: labelId,
                    id: model.originId ?? model.id,
                    isOpted: false,
                    curNum: 1230,
                    iconData: Icons.thumb_down,
                  ),
                  new OptItem(
                    labelId: labelId,
                    id: model.originId ?? model.id,
                    isOpted: true,
                    curNum: 233,
                    iconData: Icons.comment,
                  ),
                  new OptItem(
                    labelId: labelId,
                    id: model.originId ?? model.id,
                    isOpted: false,
                    curNum: 1111,
                    iconData: Icons.send,
                  ),
                ],),
              ),
            ],
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom:
                      new BorderSide(width: 0.5, color: Colours.text_normal)))),
    );
  }

  void showMenuSelection(String value) {
    LogUtil.e("showMenuSelection value -- " + value);
    // NavigatorUtil.pushPage(context, RecHotPage(title: model.content),pageName: model.content);
  }
}
