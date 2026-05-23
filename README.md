# AvirocAssignment
# Smart Product Explorer

A modern iOS application built using **SwiftUI**, **MVVM**, and **Combine** that allows users to browse, search, filter, and sort products fetched from a public API.

---

# Features

## Core Features

- Product listing screen
- Product detail screen
- Search products with debounce
- Sort products by:
  - Price (Low → High)
  - Price (High → Low)
  - Rating
- Filter products by category
- Loading state handling
- Empty state handling
- Error state handling

## Optional Enhancements Implemented

- Infinite scrolling / Pagination
- Clean reusable networking layer
- Modular architecture
- Unit testing with mocks


# Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture pattern with clear separation of concerns.

## Project Structure

```bash
SmartProductExplorer/
│
├── Core/
│   ├── Networking/
│   ├── Extensions/
│   ├── Utilities/
│   └── Enums/
│
├── Features/
│   ├── ProductList/
│   ├── ProductDetail/
│   └── Shared/
│
├── Models/
│
├── Services/
│
├── Resources/
│
└── Tests/
```

---

# Technologies Used

- SwiftUI
- Combine
- MVVM Architecture
- URLSession
- XCTest

---

# API

Products are fetched from:

```bash
https://dummyjson.com/products
```

---

# Key Technical Decisions

## SwiftUI

SwiftUI was used to build a declarative and maintainable user interface.

## MVVM

MVVM helps separate:
- Business logic
- UI logic
- Networking

This improves:
- Testability
- Scalability
- Maintainability

## Combine

Combine is used for:
- API response handling
- Search debounce
- Reactive data flow

## Pagination

Pagination is implemented using:
- Page-based API requests
- Infinite scrolling
- Duplicate request prevention
- Last page detection

## Networking Layer

A reusable generic networking layer was created to:
- Avoid duplicate code
- Improve scalability
- Simplify request handling

---

# Search Debounce

Search uses Combine debounce to avoid unnecessary filtering/API calls.

```swift
.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
```

---

# Error Handling

The app gracefully handles:
- Invalid URLs
- Network failures
- Decoding failures
- Empty states

Using a centralized `APIError` enum.

---

# Unit Testing

Unit tests are written for:

- ProductListViewModel
- Sorting logic
- Filtering logic
- Search functionality
- Pagination behavior

Mocks and stubs are used for testing services.

---

# Running the Project

## Requirements

- Xcode 16+
- iOS 17+

## Steps

1. Clone the repository

```bash
git clone https://github.com/ashubaghel007/AvirocAssignment.git
```

2. Open the project in Xcode

```bash
open SmartProductExplorer.xcodeproj
```

3. Run the app using simulator or device

---

# Assumptions

- API responses are stable
- Internet connection is available
- Pagination limit is fixed to 10 items per request

---

# Author

Ashish Baghel
