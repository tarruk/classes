# iOS Coding Challenge – Courses App

This is the submission for the iOS technical challenge. The app displays a list of courses from a local server and allows toggling favorites. It was built using Swift and SwiftUI without any external libraries.

---

## ✅ Requirements Completed

### ✅ Part 1: List of Courses
- [x] Displays a list of courses showing:
  - Instructor image
  - Instructor name
  - Course title
- [x] Data is fetched from a local endpoint (`GET /classes`)
- [x] Built without third-party libraries

### ✅ Part 2: Favorites
- [x] Fetches favorite slugs from `GET /saved_classes`
- [x] Tapping a course toggles its favorite status:
  - If **not a favorite** → `POST /classes` with `{ "slug": ... }`
  - If **a favorite** → `DELETE /classes?slug=...`
- [x] A red indicator appears on the right when a course is marked as favorite

---

## ✨ Nice to Have Features

- [x] A filter to show only favorite courses
- [x] Pull-to-refresh to update the list
- [x] Course list is cached for startup
- [ ] Image caching
- [x] Animations and visual polish
- [x] Replacing the red indicator with a favorite icon

---
