FROM golang:1.13-alpine as builder

RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

#다단계 빌드 때문에 작성
FROM scratch

#앞의 builder라는 from 절에 있는 내용을 현재 디렉토리로 복사
COPY --from=builder /usr/src/app .

#main을 실행
CMD ["/main"]
