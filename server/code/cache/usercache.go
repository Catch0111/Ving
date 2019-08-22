package cache

import (
	"github.com/bluele/gcache"
)

// User cache.
var User = &userCache{
	idHolder: gcache.New(1024 * 10).LRU().Build(),
}

type userCache struct {
	idHolder gcache.Cache
}

// func (cache *userCache) Put(user *model.User) {
// 	if err := cache.idHolder.Set(user.ID, user); nil != err {
// 		logger.Errorf("put user [id=%d] into cache failed: %s", user.ID, err)
// 	}
// }

// func (cache *userCache) Get(id uint64) *model.User {
// 	ret, err := cache.idHolder.Get(id)
// 	if nil != err && gcache.KeyNotFoundError != err {
// 		logger.Errorf("get user [id=%d] from cache failed: %s", id, err)

// 		return nil
// 	}
// 	if nil == ret {
// 		return nil
// 	}

// 	return ret.(*model.User)
// }
