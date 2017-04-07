//
//  FileHelper.swift
//  ios-foundation-filemanager-demo
//
//  Created by Eiji Kushida on 2017/04/07.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

final class FileHelper {
    
    let fileManager = FileManager.default
    
    /// Documents（ユーザデータ）ディレクトリのパスを取得する
    ///
    /// - Returns: /Documentsディレクトリのパス
    func documentDirPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask,
                                                        true)
        return paths.first ?? "unwap document path"
    }
    
    /// Cachesディレクトリのパスを取得する
    ///
    /// - Returns: /Library/Cachesディレクトリのパス
    func cachesDirPath() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                        .userDomainMask,
                                                        true)
        return paths.first ?? "unwap caches path"
    }
    
    /// tmpディレクトリのパスを取得する
    ///
    /// - Returns: tmpディレクトリのパス
    func tmpDirPath() -> String {
        return NSTemporaryDirectory()
    }
    
    /// 該当ファイルがあるか？
    ///
    /// - Parameter path: ファイルのパス
    /// - Returns: ファイルがあるか
    func hasExistsAtPath(path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    /// 新規ディレクトリを作成する
    ///
    /// - Parameter path: ディレクトリのパス
    func createDirectoryAtPath(path: String) {
        
        do {
            try fileManager.createDirectory(atPath: path,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
        } catch let error {
            fatalError("ディレクトリ作成失敗 : \(error.localizedDescription)")
        }
    }
    
    /// 既存ディレクトリを削除する
    ///
    /// - Parameter path: ディレクトリのパス
    func removeDirectoryAtPath(path: String) {
        
        do {
            if hasExistsAtPath(path: path) {
                try fileManager.removeItem(atPath: path)
            } else {
                print("ディレクトリが存在しない")
            }
        } catch let error {
            fatalError("ディレクトリ削除失敗 : \(error.localizedDescription)")
        }
    }
    
    /// ディレクトリをすべて削除する
    ///
    /// - Parameter path: ディレクトリのパス
    func removeAllDerectoryAtPath(path: String) {
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            
            _ = files.map {
                removeDirectoryAtPath(path: "\(path)/\($0)")
            }
            
        } catch let error {
            fatalError("ディレクトリ削除失敗 : \(error.localizedDescription)")
        }
    }
    
    /// 該当ディレクトリにファイルを保存する
    ///
    /// - Parameters:
    ///   - path: 保存先ディレクトリのパス
    ///   - fileName: ファイル名
    ///   - data: 保存データ
    func saveToFile(path: String, fileName: String, data: Data) {
        
        do {
            if let url = URL(string: "file://\(path)/\(fileName)") {
                try data.write(to: url, options: .atomicWrite)
            }
        } catch let error{
            fatalError("ファイルの保存に失敗: \(error.localizedDescription)")
        }
    }
    
    /// 該当ディレクトリ内のファイルを検索する
    ///
    /// - Parameter path: 保存先ディレクトリのパス
    /// - Returns: ファイル一覧
    func findForFileAtPath(path: String) -> [String] {
        
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch let error {
            fatalError("ファイル検索失敗 : \(error.localizedDescription)")
        }
    }
    
    /// 該当ファイルを移動する or 名前の変更を行う
    ///
    /// - Parameters:
    ///   - fromPath: 元のファイルパス
    ///   - toPath: 移動後のファイルパス
    func moveForFileAtPath(fromPath: String, toPath: String) {
        
        do {
            try fileManager.moveItem(atPath: fromPath, toPath: toPath)
            
        } catch let error {
            fatalError("ファイル移動/リネイム失敗 : \(error.localizedDescription)")
        }
    }
    
    /// 該当ファイルをコピーする
    ///
    /// - Parameters:
    ///   - fromPath: 元のファイルパス
    ///   - toPath: コピー後のファイルパス
    func copyForFileAtPath(fromPath: String, toPath: String) {
        
        do {
            try fileManager.copyItem(atPath: fromPath, toPath: toPath)
            
        } catch let error {
            fatalError("ファイル移動/リネイム失敗 : \(error.localizedDescription)")
        }
    }
}
