//
//  ClassesView.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import SwiftUI

struct ClassesView: View {
  @StateObject var viewModel = ClassesViewModel()
  
  var body: some View {
    ZStack(alignment: .center) {
        if viewModel.allCourses.isEmpty {
          //TODO: Show empty state
        } else {
          VStack {
            Toggle("Show only favorites", isOn: $viewModel.showFavoritesOnly)
              .padding(.horizontal)
              .onChange(of: viewModel.showFavoritesOnly) { _ in
                viewModel.applyFilter()
              }
            List(viewModel.coursesToShow) { course in
              CourseRow(course: course)
                .onTapGesture {
                  Task {
                    await viewModel.onRowTapped(course)
                  }
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .refreshable {
              await viewModel.fetchCourses()
            }
          }
        }
      if viewModel.isLoading {
        ProgressView()
      }
    }
    .task {
      await viewModel.fetchCourses()
    }
  }
}

#Preview {
  ClassesView(viewModel: {
    let vm = ClassesViewModel()
    vm.coursesToShow = [
      Course.mock,
      Course.mock,
    ]
    return vm
  }())
}
