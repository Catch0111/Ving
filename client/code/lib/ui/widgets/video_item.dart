import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class VideoItem extends StatefulWidget {

  const VideoItem(
    {Key key, this.videoUrl})
    : super(key: key);

  final String videoUrl;

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
      DataSource.network(widget.videoUrl)
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1920 / 1080,
            child: IjkPlayer(
              mediaController: controller,
            ),
          ),
        ],
      );
  }
}
