## godocserver

This package aims to build simple golang html document server.

`godoc -html strings` can build a html document for package strings, so that we can build some static files for reading documents offline.

`godocserver` uses ruby to do most work like running shell script, finding packages, writing files, and using golang to start a static server.

Although `godocserver` doesn't has many features like golang.org/pkg, with the power of vue.js and some changes of style.css, it is competent for providing well formatted golang document and package navigation.

### Screenshots
Index 
![show.png](http://7xj8s4.com1.z0.glb.clouddn.com/QQ20160312-1%402x.png)

Package navigation
![nav.png](http://7xj8s4.com1.z0.glb.clouddn.com/QQ20160312-0%402x.png)

### Install

```shell
go get github.com/Focinfi/godocserver
```

### Change Directory To godocserver

```shell
cd $GOPATH/src/github.com/Focinfi/godocserver
```

### Generate Document

Assuming you have been installed ruby.

generate document for specific package

```shell
# generate document for pacakage strings
rake generate_document\[strings\]
```

generate all golang built-in packages
```shell
rake generate_all_document
```

### Start Server

```shell
go run main.go -b :3000
```
Now, open the site localhost:3000/pkg/strings.html and check it out.

### Dependency

1. jQuery v1.8.2
2. [jquery.treeview.css](https://github.com/jzaefferer/jquery-treeview/blob/master/jquery.treeview.css)
3. [jquery-plugin-treeview](http://docs.jquery.com/Plugins/Treeview)
4. [jquery.treeview.edit.js](https://github.com/jzaefferer/jquery-treeview/blob/master/jquery.treeview.edit.js)
5. Vue.js v1.0.17
6. css and js file in golang.org/pkg
7. [negroni](https://github.com/codegangsta/negroni)

