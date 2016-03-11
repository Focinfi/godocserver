## godocserver

This package aims to build golang html document server.

## Install
```shell
go get github.com/Focinfi/godocserver
```

### Generate Document

Assuming you have been installed ruby.

1. generate document for specific package

```shell
# generate document for pacakage strings
rake generate_document\[strings\]
```

2. generate all golang built-in packages
```shell
rake generate_all_document
```

### Start Server

```shell
go run github.com/Focinfi/godocserver -b :3000
```
Now, open the site localhost:3000/pkg/strings.html and check it out.
