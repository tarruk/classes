//
//  ClassRow.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//


import SwiftUI

struct CourseRow: View {
  private let imageSize: CGFloat = 60
  var course: Course
  
  var imageURL: URL? {
    URL(string: course.imageURL)
  }
  
  var body: some View {
    HStack(alignment: .top) {
      if let imageURL {
        ZStack {
          Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: imageSize, height: imageSize)

          AsyncImage(url: imageURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            Image(systemName: "person.fill")
              .resizable()
              .scaledToFit()
              .padding(15)
              .foregroundColor(.white)
          }
          .frame(width: imageSize, height: imageSize)
          .clipShape(Circle())
        }
      }
      VStack(alignment: .leading) {
        Text(course.title)
          .font(.headline)
        Text(course.slug)
          .font(.caption)
      }
      Spacer()
      if course.favorite {
        Image(systemName: "star.fill")
          .foregroundStyle(.blue)
      }
    }
    .contentShape(Rectangle())
    .animation(.easeInOut(duration: 0.3), value: course.favorite)
  }
}

#Preview {
  CourseRow(course: Course.mock)
}


