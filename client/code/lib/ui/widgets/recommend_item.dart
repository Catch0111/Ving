import 'package:flutter/material.dart';
import 'package:code/common/component_index.dart';

class RecommendItem extends StatelessWidget {
  const RecommendItem(
    this.model, {
    this.labelId,
    Key key,
    this.isHome,
  }) : super(key: key);
  final String labelId;
  final VideoInfoModel model;
  final bool isHome;

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
                    
                    new InkWell(
                      onTap: () {
                        
                      },
                      child: new Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ),
                ],),
              ),
              new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.0),
                child: new CachedNetworkImage(
                  height: 200,
                  fit: BoxFit.fill,
                  imageUrl: "https://titanjun.oss-cn-hangzhou.aliyuncs.com/flutter/row_column.png",//model.envelopePic,
                  placeholder: (BuildContext context, String url){
                    return new ProgressView();
                  },
                  errorWidget: (BuildContext context, String url, Object error) {
                    return new Icon(Icons.error);
                  },
                ),
              ),
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
}
