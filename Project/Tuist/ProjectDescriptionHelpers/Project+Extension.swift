//
//  ProjectUtil.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription
import Foundation

extension Project {
  
  public static func currentDirectory() -> String {
    let fileManager = FileManager.default
    let currentPath = fileManager.currentDirectoryPath
    return currentPath
  }
  
  public static func subDirectoryNameList(path: String) -> [String] {
    let fileManager = FileManager.default
    let currentPath = path
    
    do {
      let contents = try fileManager.contentsOfDirectory(atPath: currentPath)
      var subdirectories: [String] = []
      
      for item in contents {
        var isDirectory: ObjCBool = false
        let itemPath = (currentPath as NSString).appendingPathComponent(item)
        
        if fileManager.fileExists(atPath: itemPath, isDirectory: &isDirectory) && isDirectory.boolValue {
          subdirectories.append(item)
        }
      }
      
      return subdirectories
    } catch {
      print("디렉토리 내용을 읽어오는 데 실패했습니다: \(error)")
      return []
    }
  }
  
  public static func domainSubDirectoryNameList() -> [String] {
    let currentPath = Project.currentDirectory()
    return Project.subDirectoryNameList(path: currentPath + "/Projects/Domain")
      .filter { !$0.contains("Derived") }
      .filter { !$0.contains(".xcodeproj") }
  }
  
}
