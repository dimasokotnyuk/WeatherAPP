This is a weather forecast application built with **SwiftUI**. It fetches and displays current weather, as well as hourly and 10-day forecasts, from the WeatherAPI. The app features a modern, clean interface with a custom skeleton loading state and smooth animations.

***

### Core Technologies & Patterns

* **UI Framework**: SwiftUI
* **Architecture**: MVVM (Model-View-ViewModel)
* **Concurrency**: Swift Concurrency (`async`/`await`) for network requests and UI updates (`@MainActor`)
* **Networking**: `URLSession` for making API calls and `URLComponents` for building requests
* **Data Parsing**: `Codable` and `JSONDecoder` for parsing JSON responses from the weather API
* **State Management**: `@StateObject`, `@Published`, and `@Environment` for managing view state and lifecycle

***

### Key Features

* **Real-time Weather Data**: Fetches current, hourly, and 10-day forecast data from a remote API.
* **Dynamic UI**: The interface updates automatically based on the fetched data.
* **Custom Skeleton Loader**: Displays a custom-built, animated skeleton screen using `.redacted` placeholders and a shimmering effect while data is loading, providing an excellent user experience.
* **Smooth Transitions**: Uses SwiftUI's `.animation` and `.transition` modifiers for a seamless fade-in/fade-out effect when data appears.
* **Data Formatting**: Includes extensions on `String` and computed properties on models to correctly parse and format dates and times for display.
* **Automatic Refresh**: The app automatically refreshes weather data when it becomes active.
* **Reusable Components**: The UI is broken down into small, reusable views like `WeatherLocationView`, `WeatherDaysView`, and `Weather10DaysView` for a clean and maintainable codebase.

![](https://github.com/dimasokotnyuk/WeatherAPP/blob/main/screen%20recording.gif?raw=true)
