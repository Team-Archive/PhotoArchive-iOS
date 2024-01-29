//
//  Dummy.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

public final class SignInUsecase: SignInUsecaseInterface {
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  private init() {
    
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public static func makeObject() -> SignInUsecaseInterface {
    return SignInUsecase()
  }
  
  public func signIn() {
    print("로그인")
  }
  
}
