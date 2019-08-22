

package util

import (
	"strings"
)

// Path prefixes.
const (
	PathRoot           = "/"
	PathInit           = "/start"
	PathSearch         = "/search"
	PathOpensearch     = "/opensearch.xml"
	PathBlogs          = "/blogs"
	PathConsoleDist    = "/console/dist"
	PathAdmin          = "/admin"
	PathAPI            = "/api"
	PathFavicon        = "/favicon.ico"
	PathTheme          = "/theme"
	PathActivities     = "/activities"
	PathArchives       = "/archives"
	PathArticles       = "/articles"
	PathAuthors        = "/authors"
	PathCategories     = "/categories"
	PathTags           = "/tags"
	PathComments       = "/comments"
	PathAtom           = "/atom"
	PathRSS            = "/rss"
	PathSitemap        = "/sitemap.xml"
	PathChangelogs     = "/changelogs"
	PathRobots         = "/robots.txt"
	PathAPIsSymArticle = "/apis/symphony/article"
	PathAPIsSymComment = "/apis/symphony/comment"
	PathPlatInfo       = "/plat/info"
	PathManifest       = "/manifest.json"
)

var reservedPaths = []string{
	PathSearch, PathOpensearch, PathBlogs, PathConsoleDist, PathAdmin, PathAPI, PathFavicon, PathTheme,
	PathActivities, PathArchives, PathAuthors, PathCategories, PathTags, PathComments, PathAtom, PathRSS,
	PathSitemap, PathChangelogs, PathRobots, PathAPIsSymArticle,
	PathAPIsSymComment, PathPlatInfo,
}

// IsReservedPath checks the specified path is a reserved path or not.
func IsReservedPath(path string) bool {
	path = strings.TrimSpace(path)
	if PathRoot == path {
		return true
	}

	for _, reservedPath := range reservedPaths {
		if strings.HasPrefix(path, reservedPath) {
			return true
		}
	}

	return false
}
