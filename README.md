# QuizMaster

## 実行方法

Docker環境を用意しています。以下のように起動してください。

```
# PostgreSQLのデータディレクトリの作成
mkdir docker/postgres/volumes

docker-compose build
docker-compose run app bin/yarn install
docker-compose run app bin/rails db:setup

docker-compose up
```

`http://localhost:34567` でアプリが起動します。

登録された問題が1問ずつ、ランダムで表示されます。フォームに回答を入力してEnterキーを押すと、正解か不正解かを表示し、次の問題が表示されます。

問題の管理は `http://localhost:34567/admin` から行うことができます。
