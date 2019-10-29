import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:ving/model/video.dart';
import 'package:ving/ui/widget/widgets.dart';
import 'package:ving/utils/log_util.dart';

import 'image.dart';

class VideoItem extends StatefulWidget {

  const VideoItem(
    {Key key, this.index, this.videoInfo})
    : super(key: key);

  final int index;
  final Video videoInfo;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  IjkMediaController controller;

  @override
  void initState() {
    super.initState();
    controller = IjkMediaController();
    controller.setDataSource(
      // DataSource.network(widget.videoInfo.link)
      DataSource.network("https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")

    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  
  Widget _buildControllerWidget(IjkMediaController controller) {
    return DefaultIJKControllerWidget(
      controller: controller,
      verticalGesture: false,
      playWillPauseOther: true,
      horizontalGesture: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.e("build ------------------------ ");
    LogUtil.e(widget.videoInfo.desc);
    return new InkWell(
      onTap: () {
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
                          child: WrapperImage(
                            imageType: ImageType.random,
                            url: 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        new Text(
                          widget.videoInfo.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // style: TextStyles.listTitle,
                          style: new TextStyle(fontSize: 15.0, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    
                    new PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      // onSelected: (value) => NavigatorUtil.pushPage(context, VideoItem()),
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
                  child: AspectRatio(
                    aspectRatio: 1280 / 720,
                    child: IjkPlayer(
                      mediaController: controller,
                      controllerWidgetBuilder: _buildControllerWidget,
                    ),
                  ),
              ),
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  new OptItem(
                    id: widget.videoInfo.id,
                    isOpted: true,
                    curNum: 5555,
                    iconData: Icons.thumb_up,
                  ),
                  new OptItem(
                    id: widget.videoInfo.id,
                    isOpted: false,
                    curNum: 1230,
                    iconData: Icons.thumb_down,
                  ),
                  new OptItem(
                    id: widget.videoInfo.id,
                    isOpted: true,
                    curNum: 233,
                    iconData: Icons.comment,
                  ),
                  new OptItem(
                    id: widget.videoInfo.id,
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
                      new BorderSide(width: 0.5, color: Colors.green)))),
    );
  }
}
