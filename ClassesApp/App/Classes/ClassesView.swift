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
      if viewModel.allCourses.isEmpty && !viewModel.isLoading {
        EmptyStateView(title: "no_courses_available".localized)
      } else {
        VStack {
          Picker("filter".localized, selection: $viewModel.filter) {
            ForEach(CourseFilter.allCases) { filter in
              Text(filter.title).tag(filter)
            }
          }
          .pickerStyle(.segmented)
          .padding()

          courseListView
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

  @ViewBuilder
  private var courseListView: some View {
    switch viewModel.filter {
    case .all:
      courseList(viewModel.allCourses)

    case .favorites:
      if viewModel.favCourses.isEmpty {
        EmptyStateView(title: "no_favorites_yet".localized)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .multilineTextAlignment(.center)
      } else {
        courseList(viewModel.favCourses)
      }
    }
  }

  private func courseList(_ courses: [Course]) -> some View {
    List(courses) { course in
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

#Preview {
  ClassesView(viewModel: {
    let vm = ClassesViewModel()
    vm.allCourses = [
      Course.mock,
      Course.mock
    ]
    return vm
  }())
}
