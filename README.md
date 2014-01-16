Dynamic
=======

ios7新特性，动力相关的内容

### Table of Contents
**[一、项目代号](#一、项目代号)**  
**[三、API设计形式](#三、API设计形式)**  
**[二、server端约定](#二、server端约定)**  





## 一、项目代号
芦苇（Reed）

项目列表
   
NO - 章节 - 中文名称 - NAME - 请求时机 - 请求示例  - 返回结果示例

1 - 4.2 - 取得启动大图 - welcome - ？？？ - http://www.host.cn/reed/v1/345jga7a/welcome -
 
{ ”picList":
[ 
{“picUrl”:“http://www.baidu.com”,“title”:“标题1”}, {“picUrl”:“http://www.baidu.com”,“title”:“标题1”} ] 
}

*777：增加和返回均请求增加ver字段，用于识别是否需要更新
（web端，修改对应配置信息的时候，ver字段自动递增）

【菜单部分】（web端对于选择不同菜单形式的用户提供相应的管理页面）

2 - 4.3 - 资讯模板（同*777）

*778：其中上半部分轮播图片，作为广告形式，打开后，跳转到对应的模板。需要包含图片，打开单页模板ID，对应内容url或者id。（即分类页面需要的contentList，或者单页的contentId）

下半部为功能列表入口，小图，标题，内容，跳转到的模板，对应内容url或者id

3 - 4.11 - 宫格模板（同*777）

***779：每个项目包含，图标，名称，跳转到的模板（模板可能为分类或者单页），内容的url或者id
（即分类页面需要的contentList，或者单页的contentId）

如果包含9宫格和16宫格切换，还需要考虑增加该字段

4 - 4.12 - 组图模板（同*777，*778）

上半部分参照*778
下半部分参照*779，图片大小和展示方式不同而已

5 - 4.13 - 组合模板（同*777，*778）

上半部分参照*778
下半部分参照*779，展示数量不同而已


分类页部分


详情页部分



## 二、server端约定
* 需要有良好的扩展性，在进行大版本改动后可以向下兼容。
* **是否需要考虑安全性：不允许任何主机都可以访问芦苇项目的rest API。**

## 三、API设计形式

[这个地方肯定还要扩充或者不对的地方]

设计形式：`http://www.host.cn/[项目代号]/[版本]/[appid]/[api方法名]`

例如 `http://www.host.cn/reed/v1/345jga7a/welcome`

说明：比如我们为两个公司开发了两个不同的app，但是都用到了A方法和B方法，但是A和B方法在不同app下要返回不同的内容，所以使用一个`[appid]`来区分。

* 考虑到server端服务的功能升级，加上`[版本]`
* 我们为每一个客户做的app都有自己的一个`[appid]`

## 四、API说明
以软件的流程来说明

### 4.1 loading图+icon
这个图是固定的，不需要服务器数据。

### 4.2 启动大图
**<p style="background-color:#E8F0E8">API说明</p>**
这个图是可以变的，可以向服务器查询以获取最新数据。至于终端在什么时候向服务器取这个数据，就不需要服务器关心了。
**<p style="background-color:#E8F0E8">API方法名</p>**

welcome

**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
{
	image : [path/image1, path/image2]
}

```

**<p style="background-color:#E8F0E8">json字段说明</p>**

```
image: 启动大图，值是一个数组，数组里是每个image的路径。路径是相对appid的。
```

### 4.3 资讯模版
**<p style="background-color:#E8F0E8">API说明</p>**
对于资讯类这种常更新API，带一个时间戳`time`，如果time小于服务器记录时间，就说明有更新，需要返回json数据。json数据只包含晚于时间戮的图片信息和资讯信息



**<p style="background-color:#E8F0E8">API方法名</p>**
query?time=5344235645

* 参数time:时间戮

**<p style="background-color:#E8F0E8">API返回值</p>**
<font color=red>json数据只包含晚于时间戮的图片信息和资讯信息</font>

json数据

```
{
	"images": [{"imageDescript" : "descript", "imageurl" : "url", "contentid" : "contentid"},
				{"imageDescript" : "descript", "imageurl" : "url", "contentid" : "contentid"}],
	"list": [{"icon" : "url", "title" : "title", "content" : "conten", "contentid" : "contentid"},
				{"icon" : "url", "title" : "title", "content" : "conten", "contentid" : "contentid"}]
}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**

```
image 用于横幅展示的图片
imageDescript 图片的简短描述
imageurl 图片URI
list 下文的资讯列表
icon 每条资讯的缩略图
title 每条资讯的标题
content 每条资讯的简要内容
contentid 在进入详细而时依靠contentid确定要显示的详细内容
```

### 4.4 分类列表
**<p style="background-color:#E8F0E8">API说明</p>**
对于这列表新闻通过时间检查更新，通过编号返回数据；

**<p style="background-color:#E8F0E8">API方法名</p>**
content?contentList=123&time=5344235645

* 参数列表编号：contentList；
* 参数时间点：time；

**<p style="background-color:#E8F0E8">API返回值</p>**
json数据

```
{
”contentList":[ 
{“classId”:“1001”,“contentId”:“1002”,“picUrl”:“http://www.baidu.com”,“title”:“标题1”,“abstract”:“摘要1”,“type”:“b”, “second”:”123","contentUrl":"http://www.baidu.com"}, 
{"classId":"1001","contentId":"1002","picUrl":"http://www.baidu.com","title":"标题2","abstract":"摘要2","type":"b”, "second":”","contentUrl":"http://www.baidu.com"}, 
]
}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**
返回格式: 类别id、内容id、缩略图url、标题、摘要、类型、二级id(不是特殊类型的返回"")、内容url


### 4.5 二级分类列表
**<p style="background-color:#E8F0E8">API说明</p>**
对于这列表新闻通过时间检查更新，通过编号返回数据；

**<p style="background-color:#E8F0E8">API方法名</p>**
content?contentList=123&second=111111&time=5344235645

* 参数列表编号：contentList；
* 二级分类列表编号：second；
* 参数时间点：time；

**<p style="background-color:#E8F0E8">API返回值</p>**
json数据

```
{
”contentList":[ 
{“classId”:“1001”,“contentId”:“1002”,“picUrl”:“http://www.baidu.com”,“title”:“标题1”,“abstract”:“摘要1”,"contentUrl":"http://www.baidu.com"}, 
{"classId":"1001","contentId":"1002","picUrl":"http://www.baidu.com","title":"标题2","abstract":"摘要2","contentUrl":"http://www.baidu.com"}, 
]
}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**
返回格式: 类别id、内容id、缩略图url、标题、摘要、内容url

### 4.6 资讯详细页
**<p style="background-color:#E8F0E8">API说明</p>**
详细资讯页三中表现形式通过一个api展示；

**<p style="background-color:#E8F0E8">API方法名</p>**
totalcontent?contentId=123

* 参数资讯编号：contentId；

**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
{“detailed”:[
“contentId”:“1001”, “picUrl”:“http://www.baidu.com”,“title”:“标题”,“textContent”:“内容”, “tele”:“13000000000”,“address”:“地址”, 
“detailContent":"<html><body><table><tr><td><p>你好啊啊啊啊</p><p>这个是内容</p></td><td cosplan='3'><img src='http://123/a.jpg' /></td></tr></table></body></html>"}
]}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**
返回格式：内容id， 图片地址，标题，文字内容，电话，地址，详细的html页面；

### 4.7 检查更新
**<p style="background-color:#E8F0E8">API说明</p>**
检查更新；

**<p style="background-color:#E8F0E8">API方法名</p>**
whetherUpdates


**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
{”updates“:[{”ifupdate“:YES, ”picUrl“:http://www.baidu.com}, ”TITLE”:”标题”, ”content“:内容]} 
{”updates":[{”ifupdate":NO}]} 
```


### 4.8 更多
**<p style="background-color:#E8F0E8">API说明</p>**
更多，包括企业信息，电话，版本

**<p style="background-color:#E8F0E8">API方法名</p>**
others


**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
{”others“:[{”companyMessage“:” http://www.baidu.com”, ”tele“:”130000000”}, ” version”:”2.1.0”]} 
```


### 4.9 意见反馈
**<p style="background-color:#E8F0E8">API说明</p>**
意见反馈，提交反馈的内容和电话；

**<p style="background-color:#E8F0E8">API方法名</p>**
userFeedback

请求数据：json

```
{"dishesList":[ 
{“message”:“1001”,“tele”:“13011111111”}, 
]}
```
**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
{"ifSuccess":”true”}
```


### 4.10 地图
**<p style="background-color:#E8F0E8">API说明</p>**
不需要服务器数据。

### 4.11 宫格模版

**<p style="background-color:#E8F0E8">API说明</p>**
终端请求该URI以获得最新的功能变化，终端解析json里的数据，以对宫格模版中的内容进行添加或者删除

**<p style="background-color:#E8F0E8">API方法名</p>**

gridmodel

**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
	{	
		"item": [{"icon" : "url", "title" : "title"}, 
					{"icon" : "url", "title" : "title"}]
	}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**

```
item 宫格模版中所涉及的每一个菜单项
icon 每一个菜单项图片url
title 每一个菜单项的标题
```

### 4.12组图模版

**<p style="background-color:#E8F0E8">API说明</p>**
终端请求该URL以获得最新的功能变化，终端解析json里的数据，以对组图模版中的内容进行显示与修改


**<p style="background-color:#E8F0E8">API方法名</p>**

imageSetModel

**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
	{	
		"images":[{"imageDescript" : "descript", "imageurl" : "url", "contentid" : "contentid"}],
		"magnetStick":[{"icon" : "url", "title" : "title", "index" : "0", "contentid" : "contentid"}]
	}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**

```
image 用于横幅展示的图片
imageDescript 图片的简短描述
imageurl 图片URI
contentid 在进入详细而时依靠contentid确定要显示的详细内容
magnetStick 下文的每个磁帖项
icon 每个磁帖的图片
title 每个磁帖的标题
index 该磁帖的位置
```


### 4.12组合模版

**<p style="background-color:#E8F0E8">API说明</p>**
终端请求该URL以获得最新的功能变化，终端解析json里的数据，以对组合模版中的内容进行显示与修改


**<p style="background-color:#E8F0E8">API方法名</p>**

messupmodel

**<p style="background-color:#E8F0E8">API返回值</p>**

json数据

```
	{	
		"images":[{"imageDescript" : "descript", "imageurl" : "url", "contentid" : "contentid"}],
		"item": [{"icon" : "url", "title" : "title", "contentid" : "contentid"}, 
					{"icon" : "url", "title" : "title", "contentid" : "contentid"}]
	}
```

**<p style="background-color:#E8F0E8">json字段说明</p>**

```
image 用于横幅展示的图片
imageDescript 图片的简短描述
imageurl 图片URI
item 宫格模版中所涉及的每一个菜单项
icon 每一个菜单项图片url
title 每一个菜单项的标题
contentid 在进入详细而时依靠contentid确定要显示的详细内容
```
