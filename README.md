# FileManager

## 概要
FileManagerは、アプリ内のファイルを操作するクラスです。

### ディレクトリについて
| 種類 | 説明 |
|---|---|
|Documents|ユーザー作成のファイル以外のデータ保存用のディレクトリです。 |
|Library/Cache|キャッシュ用途に使用します。|
|tmp|テンポラリーファイル用のディレクトリです。 |

## 主要ヘルパーメソッド

|メソッド|説明|サンプル|
|---|---|---|
| documentDirPath | Documentsディレクトリのパスを取得する | let dir = helper.documentDirPath()| 
| cachesDirPath | Cachesディレクトリのパスを取得する | let dir = helper.cachesDirPath() |
| tmpDirPath | tmpディレクトリのパスを取得する | let dir = helper.tmpDirPath() |
| hasExistsAtPath | 該当ファイルがあるかチェックする | helper.hasExistsAtPath(path: imagesPath) | 
| createDirectoryAtPath | 新規ディレクトリを作成する | helper.createDirectoryAtPath(path: imagesPath) |
| removeDirectoryAtPath | 既存ディレクトリを削除する | helper.removeDirectoryAtPath(path: imagesPath) |
| removeAllDerectoryAtPath | ディレクトリをすべて削除する | helper.removeAllDerectoryAtPath(path: helper.documentDirPath()) |
| saveToFile | 該当ディレクトリにファイルを保存する | helper.saveToFile(path: imagesPath,fileName: "flower.png",data: data!) |
| findForFileAtPath | 該当ディレクトリ内のファイルを検索する | let files = helper.findForFileAtPath(path: imagesPath) |
| moveForFileAtPath | 該当ファイルを移動する or 名前の変更を行う | helper.moveForFileAtPath(fromPath: fromPath,toPath: toPath) |
| copyForFileAtPath | 該当ファイルをコピーする | helper.copyForFileAtPath(fromPath: fromPath, toPath: toPath) |

## フレームワーク
Foundation.framework

## サポートOSバージョン
iOS2.0以上

## 開発環境
|category | Version| 
|---|---|
| Swift | 3.0.2 |
| XCode | 8.3 |
| iOS | 10.2〜 |

## 参考
https://developer.apple.com/reference/foundation/nsfilemanager
