# iOS Coding Challenge – Courses App

This is the submission for the iOS technical challenge. The app displays a list of courses from a local server and allows toggling favorites. It was built using Swift and SwiftUI without any external libraries.

---

## ✅ Requirements Completed

### ✅ Part 1: List of Courses
- [ ] Displays a list of courses showing:
  - Instructor image
  - Instructor name
  - Course title
- [ ] Data is fetched from a local endpoint (`GET /classes`)
- [ ] Built without third-party libraries

### ✅ Part 2: Favorites
- [ ] Fetches favorite slugs from `GET /saved_classes`
- [ ] Tapping a course toggles its favorite status:
  - If **not a favorite** → `POST /classes` with `{ "slug": ... }`
  - If **a favorite** → `DELETE /classes?slug=...`
- [ ] A red indicator appears on the right when a course is marked as favorite

---

## ✨ Nice to Have Features

- [ ] A filter to show only favorite courses
- [ ] Pull-to-refresh to update the list
- [ ] Course list is cached for startup
- [ ] Image caching
- [ ] Animations and visual polish
- [ ] Replacing the red indicator with a favorite icon

---
