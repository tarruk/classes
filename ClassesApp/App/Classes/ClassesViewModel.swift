//
//  ClassesViewModel.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

@MainActor
final class ClassesViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var showFavoritesOnly: Bool = false
  @Published var errorMessage: String?
  @Published var coursesToShow: [Course] = []
  
  private(set) var allCourses: [Course] = []
  private(set) var favCourses: [Course] = []
  
  func fetchCourses() async {
    isLoading = true
    do {
      let courses = try await APIClient.shared.request(Classes.GetAll())
      let favSlugs = try await APIClient.shared.request(Classes.GetFavs())
      isLoading = false
      self.allCourses = courses.map { course in
        var updated = course
        updated.favorite = favSlugs.contains(course.slug)
        return updated
      }

      applyFilter()
    } catch let error as APIError {
      errorMessage = error.message
    } catch {
      errorMessage = error.localizedDescription
    }
  }
  
  func applyFilter() {
    let filtered = showFavoritesOnly
      ? allCourses.filter { $0.favorite }
      : allCourses
    coursesToShow = filtered
  }
  
  func onRowTapped(_ course: Course) async {
    if let index = allCourses.firstIndex(where: { $0.slug == course.slug }) {
      allCourses[index].favorite.toggle()
      
      do {
        if allCourses[index].favorite {
          _ = try await APIClient.shared.request(Classes.AddToFavorites(slug: course.slug))
        } else {
          _ = try await APIClient.shared.request(Classes.DeleteFromFavorites(slug: course.slug))
        }
        await fetchCourses()
      } catch let error as APIError {
        print(error.localizedDescription)
        errorMessage = error.message
      } catch {
        print(error.localizedDescription)
        errorMessage = error.localizedDescription
      }
    }
  }
}

