
# RecipeApp

RecipeApp is a SwiftUI iOS application built fully programmatically with Core Data and UserDefaults. The app allows users to log in, browse recipes, filter by category, mark recipes as favorites, view recipe details, add or edit recipes, and switch between metric and imperial measurement systems.

## Features

### Authentication

* Login screen shown on app launch
* Hardcoded login support
* User registration for new local accounts
* Password fields support show and hide
* Login status and username stored in UserDefaults

### Home Screen

* Welcome message using the saved username
* Horizontally scrollable recipe categories loaded from Core Data
* Multi-category filtering using AND logic
* Visual selection state for chosen categories
* Vertically scrollable recipe list
* Recipe cards show image, title, favorite button, and category tags
* Sorting toggle for ascending and descending recipe names

### Recipe Detail Screen

* Scrollable layout
* Recipe image
* Recipe title
* Favorite toggle
* Category tags
* Description
* Ingredients section with servings dropdown
* Ingredient quantities update based on selected servings
* Instructions section
* Edit button to update recipe
* Delete button to remove recipe

### Add/Edit Recipe Screen

* Add new recipes
* Edit existing recipes
* Recipe name validation, maximum 50 characters
* Description validation, maximum 250 characters
* Select existing categories from Core Data
* Add new categories directly in the form
* Add ingredients dynamically

### Settings

* Toggle between metric and imperial units
* Preference saved in UserDefaults
* Logout support

## Tech Stack

* Swift
* SwiftUI
* Core Data
* UserDefaults
* MVVM

## Data Persistence

### UserDefaults

Used for:

* Login status
* Logged in username
* Measurement system preference
* Locally registered user accounts

### Core Data

Used for:

* Recipes
* Categories
* Ingredients

## Core Data Model

### Recipe

Attributes:

* id: UUID
* name: String
* recipeDescription: String
* instructions: String
* imageName: String
* isFavorite: Bool
* baseServings: Int16

Relationships:

* categories: To Many -> Category
* ingredients: To Many -> Ingredient

### Category

Attributes:

* id: UUID
* name: String

Relationships:

* recipes: To Many -> Recipe

### Ingredient

Attributes:

* id: UUID
* name: String
* quantity: Double
* unit: String
* type: String

Relationships:

* recipe: To One -> Recipe

## Project Structure

```text
RecipeApp
├── App
│   ├── RecipeAppApp.swift
│   ├── RootView.swift
│   └── MainTabView.swift
├── Persistence
│   ├── PersistenceController.swift
│   ├── SeedDataService.swift
│   └── UserDefaultsManager.swift
├── Models
│   ├── AppUser.swift
│   ├── IngredientFormModel.swift
│   └── MeasurementSystem.swift
├── Helpers
│   └── UnitConverter.swift
├── ViewModels
│   ├── AuthViewModel.swift
│   ├── HomeViewModel.swift
│   ├── AddEditRecipeViewModel.swift
│   └── SettingsViewModel.swift
├── Views
│   ├── LoginView.swift
│   ├── RegisterView.swift
│   ├── HomeView.swift
│   ├── RecipeDetailView.swift
│   ├── AddEditRecipeView.swift
│   └── SettingsView.swift
└── Views/Components
    ├── PasswordFieldView.swift
    ├── CategoryTagView.swift
    ├── RecipeCardView.swift
    ├── IngredientRowView.swift
    └── FlexibleCategoryList.swift
```

## How to Run

1. Open the project in Xcode.
2. Make sure the project is configured as a SwiftUI app with Core Data enabled.
3. Open the `.xcdatamodeld` file and confirm the entities and relationships are set up correctly.
4. Build and run the app on the simulator.

## Default Login

Use the hardcoded credentials below:

* Username: `admin`
* Password: `1234`

You can also create a new account from the registration screen.

## Measurement Conversion

The app supports conversion between:

* ounces and grams
* tablespoons and milliliters

Ingredient quantities are also adjusted when the selected serving count changes.

## Sample Data

The app seeds starter recipe data into Core Data the first time it launches. This includes:

* multiple recipe categories
* 3 to 4 hardcoded recipes
* related ingredients for each recipe

## Architecture

This project uses a simple MVVM structure:

* Views handle UI rendering
* ViewModels handle screen logic and state
* Core Data manages persistent recipe data
* UserDefaults manages lightweight app settings

## Future Improvements

* Add image picking for custom recipe images
* Add stronger validation for registration and recipes
* Add recipe search
* Add favorite-only filtering
* Improve category layout wrapping
* Add unit tests and UI tests

## Author

Tony Cao
