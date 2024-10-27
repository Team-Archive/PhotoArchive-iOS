//
//  ServiceSignInDelegator.swift
//  AppRoute
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ArchiveFoundation
import DomainInterface

public protocol ServiceSignInDelegator where Self: View {
  
  init(oauthSignInData: OAuthSignInData, completeAction: @escaping (SignInToken) -> Void, closeAction: @escaping () -> Void)
  
}
