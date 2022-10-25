#mysql8的总结使用

## docker安装mysql8

`
docker run --name mysql8 -e MYSQL_ROOT_PASSWORD=123456 -v /install/mysql8/logs:/logs -v /install/mysql8/data:/var/lib/mysql -p 50007:3306 -d --restart=always  mysql:8
`

## utf8mb4和utf8的区别

 尽量能utf8mb4就用这个，因为她不光具有utf8的所有能力，还支持插入表情等数据