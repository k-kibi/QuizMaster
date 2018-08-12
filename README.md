# 実行方法

Docker環境を用意しています。以下のように起動してください。

```
docker-compose build

docker-compose run app bin/rails db:create
docker-compose run app bin/rails db:migrate
docker-compose run app bin/yarn install

docker-compose up -d
```

`http://localhost:34567` でアプリが起動します。

登録された問題がランダムで表示されます。フォームに答えを入力してEnterキーを押すと、正解か不正解を表示し、次の問題が表示されます。

問題の管理は `http://localhost:34567/admin` から行うことができます。
