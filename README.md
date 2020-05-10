# QR Tickets application

This application allows to create user accounts, sign in, and generate QR codes.

Application uses:

* Go - for backend code
* PostgreSql - as database
* JWT - for authentication

Backend dependencies:
```
go get github.com/badoux/checkmail
go get github.com/jinzhu/gorm
go get golang.org/x/crypto/bcrypt
go get github.com/dgrijalva/jwt-go
go get github.com/gorilla/mux
go get github.com/jinzhu/gorm/dialects/mysql" //mysql
go get github.com/jinzhu/gorm/dialects/postgres //postgres
go get github.com/joho/godotenv
go get github.com/skip2/go-qrcode
```

You can run server using comand:
```
go run main.go
```