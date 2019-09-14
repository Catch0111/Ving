package model

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

// The User holds
type Video struct {
	ID         primitive.ObjectID `bson:"_id" json:"id"`                //视频id
	UserID     primitive.ObjectID `bson:"userid" json:"userid"`         //用户id
	UserName   string             `bson:"username" json:"username"`     //用户昵称
	Desc       string             `bson:"desc" json:"desc"`             //视频描述
	VideoURL   string             `bson:"videourl" json:"videourl"`     //视频地址
	Tag        string             `bson:"tag" json:"tag"`               //视频分类标签
	Praises    int64              `bson:"praises" json:"praises"`       //👍点赞数量
	Treads     int64              `bson:"treads" json:"treads"`         //👎踩数量
	Comments   int64              `bson:"comments" json:"comments"`     //📄评论数量
	Transmits  int64              `bson:"transmits" json:"transmits"`   //🥠转发数量
	UpdateTime time.Time          `bson:"updatetime" json:"updatetime"` //上传时间
	Duration   int32              `bson:"duration" json:"duration"`     //视频时长
}

// New is
func (u *Video) New() *Video {
	return &Video{
		ID:         primitive.NewObjectID(),
		UserID:     u.UserID,
		UserName:   u.UserName,
		Desc:       u.Desc,
		VideoURL:   u.VideoURL,
		Tag:        u.Tag,
		Praises:    u.Praises,
		Treads:     u.Treads,
		Comments:   u.Comments,
		Transmits:  u.Transmits,
		UpdateTime: u.UpdateTime,
		Duration:   u.Duration,
	}
}
