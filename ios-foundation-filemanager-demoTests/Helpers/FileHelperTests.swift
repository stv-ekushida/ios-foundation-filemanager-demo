//
//  FileHelperTests.swift
//  ios-foundation-filemanager-demoTests
//
//  Created by Eiji Kushida on 2017/04/07.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_foundation_filemanager_demo

class FileHelperTests: XCTestCase {
    
    let helper = FileHelper()
    var imagesPath = ""
    
    override func setUp() {
        super.setUp()
        imagesPath = "\(helper.documentDirPath())/images"
    }
    
    override func tearDown() {
        super.tearDown()
        helper.removeAllDerectoryAtPath(path: helper.documentDirPath())
    }
    
    /// /Documentディレクトリのパスが取得できているか？
    func testDocumentDirPath() {
        
        let dir = helper.documentDirPath().components(separatedBy: "/")
        XCTAssertEqual(dir.last!, "Documents")
    }
    
    /// Library/Cachesディレクトリのパスが取得できているか？
    func testCachesDirPath() {
        let dir = helper.cachesDirPath().components(separatedBy: "/")
        XCTAssertEqual(dir.last!, "Caches")
    }
    
    /// /tmp/ディレクトリのパスが取得できているか？
    func testTmpDirPath() {
        let dir = helper.tmpDirPath().components(separatedBy: "/")
        XCTAssertEqual(dir[dir.count-2], "tmp")
    }
    
    /// 該当のパスが存在するか？
    /// check : 存在しない
    func testFileExistsAtPath() {
        
        XCTAssertFalse(helper.hasExistsAtPath(path: imagesPath))
    }
    
    /// 該当のパスが存在するか？
    /// check : 存在する
    func testCreateDir() {
        
        helper.createDirectoryAtPath(path: imagesPath)
        XCTAssertTrue(helper.hasExistsAtPath(path: imagesPath))
    }
    
    /// 画像ファイルが保存できるか？
    /// check : flower.pngがあるか？
    func testSaveImageFile() {
        
        //setup
        helper.createDirectoryAtPath(path: imagesPath)
        
        if let image = UIImage(named: "flower") {
            let data = UIImagePNGRepresentation(image)
            
            helper.saveToFile(path: imagesPath,
                              fileName: "flower.png",
                              data: data!)
            
            let files = helper.findForFileAtPath(path: imagesPath)
            XCTAssertTrue(files.count == 1)
            XCTAssertEqual(files.first, "flower.png")
        }
    }
    
    /// 画像ファイルがリネームできるか？
    /// check : rename.pngがあるか？
    func testRenameFile() {
        
        //setup
        helper.createDirectoryAtPath(path: imagesPath)
        
        if let image = UIImage(named: "flower") {
            let data = UIImagePNGRepresentation(image)
            
            helper.saveToFile(path: imagesPath,
                              fileName: "flower.png",
                              data: data!)
            
            let fromPath = imagesPath + "/flower.png"
            let toPath = imagesPath + "/rename.png"
            
            helper.moveForFileAtPath(fromPath: fromPath,
                                     toPath: toPath)
            
            let files = helper.findForFileAtPath(path: imagesPath)
            XCTAssertTrue(files.count == 1)
            XCTAssertEqual(files.first, "rename.png")
        }
    }
    
    /// 画像ファイルがコピーできるか？
    /// check : flower.png or copy.pngがあるか？
    func testCopyFile() {
        
        //setup
        helper.createDirectoryAtPath(path: imagesPath)
        
        if let image = UIImage(named: "flower") {
            let data = UIImagePNGRepresentation(image)
            
            helper.saveToFile(path: imagesPath,
                              fileName: "flower.png",
                              data: data!)
            
            let fromPath = imagesPath + "/flower.png"
            let toPath = imagesPath + "/copy.png"
            
            helper.copyForFileAtPath(fromPath: fromPath,
                                     toPath: toPath)
            
            let files = helper.findForFileAtPath(path: imagesPath)
            XCTAssertTrue(files.count == 2)
            XCTAssertTrue(files.contains("flower.png") && files.contains("copy.png"))
        }
    }
}
