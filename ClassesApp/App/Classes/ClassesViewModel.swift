//
//  ClassesViewModel.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

@MainActor
final class ClassesViewModel: ObservableObject {
  // TODO: This key could be moved to a dedicated constants file for better organization
  private let classesStorageKey = "classes_storage_key"
  
  @Published var filter: CourseFilter = .all
  @Published var isLoading = false
  
  // TODO: This could be improved by showing an error card or any kind of UI when this message appears
  @Published var errorMessage: String?

  @Published var allCourses: [Course] = []
  @Published var favCourses: [Course] = []
  
  func fetchCourses() async {
    if let cachedCourses = StorageManager.load([Course].self, forKey: classesStorageKey) {
      self.allCourses = cachedCourses
    }
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
      favCourses = allCourses.filter { $0.favorite }

      StorageManager.save(courses, forKey: classesStorageKey)
    } catch let error as APIError {
      errorMessage = error.message
    } catch {
      errorMessage = error.localizedDescription
    }
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

