//
//  Path+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by hanwe on 10/6/24.
//

import ProjectDescription

extension Path {
  
  public static func rootProjectPath(_ directoryName: String) -> Path {
    return .relativeToRoot("Projects/\(directoryName)")
  }
  
  public static func domainProjectPath(_ directoryName: String) -> Path {
    return .relativeToRoot("Projects/Domain/\(directoryName)")
  }
  
  public static func featureProjectPath(_ directoryName: String) -> Path {
    return .relativeToRoot("Projects/Feature/\(directoryName)")
  }
  
}
