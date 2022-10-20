# Nginx反向代理location与proxy_pass配置规则总结
参考 `https://blog.csdn.net/qq_36528215/article/details/123570962`
## 一、location配置规则

### 1.匹配模式及顺序举例

location = /uri 	= 开头表示精确匹配，只有完全匹配上才能生效

location ^~ /uri 	^~ 开头对 URL 路径进行前缀匹配，并且在正则之前

location ~ pattern	~ 开头表示区分大小写的正则匹配

location /uri	不带任何修饰符，也表示前缀匹配，但是在正则匹配之后，如果没有正则命中，命中最长的规则

location /	通用匹配，任何未匹配到其它 location 的请求都会匹配到，相当于 switch 中的 default

### 2.location 是否以“／”结尾
 在 ngnix 中 location 进行的是模糊匹配
没有“/”结尾时，location /abc/def 可以匹配 /abc/defghi 请求，也可以匹配 /abc/def/ghi 等
而有“/”结尾时，location /abc/def/ 不能匹配 /abc/defghi 请求，只能匹配 /abc/def/anything 这样的请求


## proxy_pass配置规则

（1）配置 proxy_pass 时，当在后面的 url 加上了 /，相当于是绝对路径，则 Nginx 不会把 location 中匹配的路径部分加入代理 uri。

（2）如果配置 proxy_pass 时，后面没有 /，Nginx 则会把匹配的路径部分加入代理 uri。
​```
多行代码
​```
~~~~
~~~~