//
//  EmptyStateView.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import SwiftUI

struct EmptyStateView: View {
  
  var title: String
  
  private let imageSize: CGFloat = 80
  var body: some View {
    VStack {
      Image.exclamation
        .resizable()
        .frame(
          width: imageSize,
          height: imageSize
        )
        .padding()
      Text(title)
        .fontWeight(.medium)
        .font(.headline)
    }.padding()
  }
}
