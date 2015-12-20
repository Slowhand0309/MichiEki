# MichiEki

`MichiEki`は道の駅情報を提供するAPIです。<br>
APIを呼ぶと結果がJSON返ります。


## データ提供
道の駅データは[道の駅一覧表 for GPS](http://www.seaview.jp/rs/index.html)さん より頂きました。ありがとうございます。

## 事前データ作成

`config.yml`を元に`api/info`で取得する情報や道の駅データを作成します。

```
$ rake all
```

## 起動

```
$ bundle install
$ rackup
```

※ローカルで動作させる場合
```
$ rackup -o 0.0.0.0
```

## API

現在実装済みのAPI一覧

* **ping**

  死活監視用 `echo`にパラメータを設定するとその値がかえる
```
http://localhost:9292/api/ping # => {"ping":"pong"}
http://localhost:9292/api/ping?echo=test # => {"ping":"pong+test"}
```

* **info**

  MichiEkiに関する情報を取得
```
http://localhost:9292/api/info # =>
{
  "version":"0.0.1",
  "methods":["ping","info","list"],
  "link":"https://github.com/Slowhand0309/MichiEki"
}
```

* **list**

  道の駅の以下情報を取得<br>
    1. 道の駅名
    2. 緯度
    3. 軽度
    4. 駐車場の駐車台数
    5. 住所

  またエリアと名前で絞り込みが可能

```
http://localhost:9292/api/list # =>
[{"area":"北海道","２３０ルスツ":{"name":"２３０ルスツ",・・・

http://localhost:9292/api/list?area=大阪 # =>
{"area":"大阪府","愛彩ランド":{"name":"愛彩ランド",・・・

http://localhost:9292/api/list?area=大阪&name=かなん # =>
{"name":"かなん","lat":"34.28.31","lng":"135.37.12","park":"24","address":"大阪府南河内郡河南町神山523-1他"}
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[slowhand0309](https://github.com/Slowhand0309)
