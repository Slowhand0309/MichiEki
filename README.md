# MichiEki

[![Build Status](https://travis-ci.org/Slowhand0309/MichiEki.svg?branch=master)](https://travis-ci.org/Slowhand0309/MichiEki)

`MichiEki`は道の駅情報を提供するAPIです。<br>
APIを呼ぶと結果がJSONで返ります。


## データ提供
道の駅データは[道の駅一覧表 for GPS](http://www.seaview.jp/rs/index.html)さん より頂きました。ありがとうございます。

## 事前準備

gemのインストール

```sh
$ bundle install
```

`config.yml`を元に`api/info`で取得する情報や道の駅データを以下で作成します。

```sh
$ rake all
```

## 起動

```sh
$ rackup
```

※ローカルで動作させる場合
```sh
$ rackup -o 0.0.0.0
```

## API

現在実装済みのAPI一覧

* **ping**

  死活監視用 `echo`にパラメータを設定するとその値がかえる
```sh
http://localhost:9292/api/ping # => {"ping":"pong"}
http://localhost:9292/api/ping?echo=test # => {"ping":"pong+test"}
```

* **info**

  MichiEkiに関する情報を取得
```sh
http://localhost:9292/api/info # =>
{
   "version":"0.0.1",
   "methods":["ping","info","list","search"],
   "link":"https://github.com/Slowhand0309/MichiEki"
}
```

* **search**

  指定された位置(緯度・経度)から範囲内の道の駅を配列で取得<br>
  ※デフォルトでは指定された位置から周囲**30km**の道の駅を検索
```sh
http://localhost:9292/api/search?lat=35.68&lng=139.69 # =>
[
   {
     "name":"川口・あんぎょう",
     "lat":"35.50.41",
     "lng":"139.46.10",
     "park":"150",
     "address":"埼玉県川口市安行領家844-2"
   },
   {
     "name":"庄和",
     "lat":"35.59.37",
     "lng":"139.47.54",
     "park":"162",
     "address":"埼玉県春日部市上柳995"
   }
]
```

  検索範囲を指定 `scope`にkmで指定する
```sh
  http://localhost:9292/api/search?lat=35.41&lng=139.20&scope=10 # =>
  [
    {
      "name":"八王子滝山",
      "lat":"35.41.00",
      "lng":"139.20.42",
      "park":"62",
      "address":"東京都八王子市滝山町1丁目592-2"
    }
  ]
```

* **list**

  道の駅の以下情報を取得<br>
    1. 道の駅名
    2. 緯度
    3. 軽度
    4. 駐車場の駐車台数
    5. 住所

  またエリアと名前で絞り込みが可能

```sh
http://localhost:9292/api/list # =>
{"北海道":{"２３０ルスツ":{"name":"２３０ルスツ"・・・

http://localhost:9292/api/list?area=大阪 # =>
{"愛彩ランド":{"name":"愛彩ランド",・・・

http://localhost:9292/api/list?area=大阪&name=かなん # =>
{"name":"かなん","lat":"34.28.31","lng":"135.37.12","park":"24","address":"大阪府南河内郡河南町神山523-1他"}
```


## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[slowhand0309](https://github.com/Slowhand0309)
