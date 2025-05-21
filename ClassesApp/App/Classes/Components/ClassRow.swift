//
//  ClassRow.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//


import SwiftUI

struct CourseRow: View {
  // TODO: Consider standardizing sizes for better visual consistency across the app
  private let imageSize: CGFloat = 60
  
  var course: Course
  
  var imageURL: URL? {
    URL(string: course.imageURL)
  }
  
  var favoriteImage: some View {
    if course.favorite {
      Image.favoriteOn
        .foregroundStyle(.favorite)
    } else {
      Image.favoriteOff
        .foregroundStyle(.favorite)
    }
  }
  
  var body: some View {
    HStack(alignment: .top) {
      if let imageURL {
        ZStack {
          Circle()
            // TODO: Can be replaced with a color from the design system for consistency
            .fill(Color.gray.opacity(0.2))
            .frame(width: imageSize, height: imageSize)

          // TODO: Consider caching the image or using a library like Kingfisher for smoother loading and caching
          AsyncImage(url: imageURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            Image.userPlaceholder
              .resizable()
              .scaledToFit()
              .padding(Padding.m)
              .foregroundColor(.white)
          }
          .frame(width: imageSize, height: imageSize)
          .clipShape(Circle())
        }
      }
      VStack(alignment: .leading) {
        // TODO: Replace with a font defined in a shared Typography file or DesignSystem
        Text(course.title)
          .font(.headline)
        Text(course.slug)
          .font(.caption)
      }
      Spacer()
      favoriteImage
    }
    .contentShape(Rectangle())
    .animation(.easeInOut(duration: 0.3), value: course.favorite)
    // TODO: Animation timing can also be standardized for better consistency across the app
    
  }
}

#Preview {
  CourseRow(course: Course.mock)
}


