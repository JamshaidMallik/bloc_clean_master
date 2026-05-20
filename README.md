# Flutter Clean Architecture & bloc Masterclass

Welcome! This is a public repository designed to showcase a production-ready **Flutter** application utilizing **Clean Architecture** paired with **bloc** for robust state management. 

Whether you are a newcomer to Flutter or an experienced developer looking to understand Clean Architecture principles, this repository serves as a fantastic starting point and learning resource.

---

## 🎯 What You Will Learn

By exploring this codebase, newcomers will learn how to:

1. **Implement Clean Architecture:** Understand how to decouple your business logic, state management, and UI from external data sources by dividing your codebase into independent layers.
2. **Master bloc:** See practical, real-world examples of using `flutter_bloc` to manage application state securely and efficiently, utilizing reactive caching and data-binding.
3. **Handle Errors Functionally:** Learn how to use the `dartz` package to apply functional programming concepts (specifically the `Either` monad) to gracefully handle failures and exceptions without throwing errors across layers.
4. **Build Network Clients with Dio:** See how to configure and utilize the `dio` HTTP client to fetch data from remote REST APIs (using JSONPlaceholder in this example).
5. **Utilize Code Generation:** Learn how to enforce immutability and speed up development by using `freezed` and `json_serializable` for data classes, state unions, and API models.
6. **Write Unit Tests:** Get insights into writing clean tests for your layers by using the `mocktail` package.

---

## 📦 Tech Stack & Packages Used

This project makes use of the following industry-standard packages, tailored for robust enterprise apps:

| Package                                                                                                                              | Purpose |
|--------------------------------------------------------------------------------------------------------------------------------------| ------ |
| **[flutter_bloc](https://pub.dev/packages/flutter_riverpod)**                                                                        | State management, dependency injection, and reactive caching framework. |
| **[dio](https://pub.dev/packages/dio)**                                                                                              | Powerful HTTP client for interacting with RESTful APIs. |
| **[dartz](https://pub.dev/packages/dartz)**                                                                                          | Functional programming for Dart (providing `Either` for error handling). |
| **[freezed](https://pub.dev/packages/freezed)** / **[freezed_annotation](https://pub.dev/packages/freezed_annotation)**              | Code generation for unions/pattern-matching and immutable data classes. |
| **[json_serializable](https://pub.dev/packages/json_serializable)** / **[json_annotation](https://pub.dev/packages/json_annotation)** | Automated JSON serialization and deserialization helpers. |
| **[mocktail](https://pub.dev/packages/mocktail)**                                                                                    | A mock library optimized for Dart and used for robust unit testing. |
| **[build_runner](https://pub.dev/packages/build_runner)**                                                                            | The Dart code generation execution tool. |

---

## 🏗️ What's Inside The Code (Architecture)

This application adheres to **Feature-Based Clean Architecture**. The codebase is cleanly separated into high-level groupings:

### `lib/core/`
Contains the shared building blocks of the application that can be utilized across different features:
- **`error/`**: Houses global exceptions and failure classes.
- **`network/`**: Base networking configurations (e.g., API client providers, interceptors).
- **`utils/`**: Reusable helpers and constants.

### `lib/features/`
This is where the actual features of the app live. Currently, this project implements a `posts` feature (fetching posts from JSONPlaceholder). Each feature is strictly divided into three layers:

#### 1. Data Layer (`lib/features/posts/data/`)
The data layer is responsible for retrieving and manipulating data from external sources (APIs, Local storage) and transforming it for the domain layer.
- **DataSources**: Remote or local interfaces connecting to endpoints (`Dio`).
- **Models**: The raw data structures tied specifically to external endpoints (`json_serializable`).
- **Repositories (Impl)**: Implements the domain layer's repository contracts.

#### 2. Domain Layer (`lib/features/posts/domain/`)
The innermost, purest part of the architecture. It has no dependencies on external packages, UI, or frameworks.
- **Entities**: Core business logic objects.
- **Repositories**: Contracts (Abstract Classes) defining the operations that can be performed.
- **UseCases**: Application-specific business rules defining exactly what the feature does.

#### 3. Presentation Layer (`lib/features/posts/presentation/`)
The user interface interface and state management logic.
- **Providers / Notifiers**: Classes representing the current state of the UI bridging via `Riverpod`.
- **UI (Pages & Widgets)**: The visual Flutter components built securely using data exposed by the state providers.

---

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd bloc_clean_master
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation:**
   Because this project uses `freezed` and `json_serializable`, you must generate the boilerplate code before running the app.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App:**
   ```bash
   flutter run
   ```

Enjoy exploring the architecture! If you have any questions or find any bugs, feel free to open an issue or submit a pull request.
