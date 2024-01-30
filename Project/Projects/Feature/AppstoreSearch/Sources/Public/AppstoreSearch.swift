//
//  AppstoreSearch.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Domain
import Data
import Combine

public struct AppstoreSearch: View {
  public var body: some View {
    ContentView()
  }
  
  public init() {
    
  }
  
  struct ContentView: View {
    
    @State private var responseText = ""
    private var cancellables: Set<AnyCancellable> = []
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
      Button("테스트") {
        viewModel.fetchData()
      }
      .padding()
      
      Text(viewModel.responseText)
        .padding()
    }
  }
    
}

class ViewModel: ObservableObject {
  @Published var responseText = ""
  private var cancellables: Set<AnyCancellable> = []
  
  let appstoreSearchUsecase: AppstoreSearchUsecaseInterface = AppstoreSearchUsecase.makeObject(repository: AppstoreSearchRepositoryImplement())
  func fetchData() {
    appstoreSearchUsecase.search(keyword: "game")
      .receive(on: DispatchQueue.main)
      .map { list in
        print("list")
        return list[0].name
      }
      .replaceError(with: "--")
      .assign(to: \.responseText, on: self)
      .store(in: &cancellables)
  }
}

#Preview {
  AppstoreSearch()
}
