import Plot

//<div class="card" style="width: 18rem;">
//  <img src="..." class="card-img-top" alt="...">
//  <div class="card-body">
//    <h5 class="card-title">Card title</h5>
//    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
//    <a href="#" class="btn btn-primary">Go somewhere</a>
//  </div>
//</div>

import Plot
import Publish

public struct BlogCard<Site: Website>: Component {
    let blogPostData: BlogPostExtraData
    let item: Item<Site>
    let site: Site
    let isDemo: Bool
    
    public init(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site, isDemo: Bool = false) {
        self.blogPostData = blogPostData
        self.item = item
        self.site = site
        self.isDemo = isDemo
    }
    
    public var body: Component {
        Div {
            Div {
                H2(item.title).class("card-title")
                Paragraph(item.description).class("card-text")
                Div {
                    
                }.class("row")
            }.class("card-body")
        }.class("card blog-card")
    }
    
    func buildBlogHeader() -> Component {
        Div {
            Div {
                Div {
                    Div {
                        buildBlogPostTagList(isDemo: isDemo)
                    }.class("blog-tags")
                    Div {
                        Text(blogPostData.length)
                    }.id("blog-post-reading-time")
                }.class("d-flex").id("blog-time-tags")
            }.id("blog-time-tag-container")
            H1(item.title).class("mb-4 mt-4")
            Div {
                Text(item.description)
            }.class("mb-4").id("blog-description")
            Div {
                Div {
                    Image(url: blogPostData.author.imageURL, description: blogPostData.author.name).id("blog-post-author-image").class("me-2")
                    Div {
                        Div {
                            Text(blogPostData.author.name)
                        }.id("blog-post-author-name")
                        Div {
                            Text(blogPostData.publishedDate)
                        }.id("blog-post-publish-date")
                    }.id("blog-post-author-date-container")
                }.id("blog-post-author").class("d-flex col-lg-6")
                
                Div {
                    buildBlogPostShareList()
                }.id("blog-top-share").class("ms-auto blog-share col-lg-6 mt-4 mt-lg-0")
            }.class("row")
        }.class("blog-post-header")
    }
    
    func blogPostDivider() -> Component {
        Node.hr().class("blog-post-divider")
    }
    
    func buildBlogPostContent() -> Component {
        Div {
            item.content.body
        }.class("blog-content")
    }
    
    func buildBlogPostBottom() -> Component {
        Div {
            Div {
                buildBlogPostTagList(isDemo: isDemo)
            }.id("blog-bottom-tags").class("blog-tags col-lg-6")
            Div {
                buildBlogPostShareList()
            }.class("ms-auto blog-share col-lg-6").id("blog-bottom-share")
        }.id("blog-post-bottom").class("row align-items-center")
    }
    
    func buildBlogPostTagList(isDemo: Bool) -> Component {
        List {
            for (index, tag) in item.tags.enumerated() {
                if index == 0 {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }.class("ms-auto")
                } else if index == item.tags.count - 1 {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }.class("me-auto")
                } else {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }
                }
            }
        }
    }
    
    func buildBlogPostShareList() -> Component {
        List {
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-copy-06 me-2")
                    Text("Copy Link")
                }.class("btn btn-secondary btn-small d-flex").onclick("Vapor.copyURLToClipboard(); return false;")
            }.class("ms-auto")
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-twitter-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex twitter-share-button")
            }
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-reddit-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex reddit-share-button")
            }
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-mastodon-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex mastodon-share-button")
            }.class("me-auto")
        }
    }
}
