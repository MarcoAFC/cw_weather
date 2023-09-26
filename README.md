# CWeather

## Description and scope

An app built to allow checking the weather in a few different cities around the world.

This app uses a starting set composed of these cities:

- Silverstone, UK
- São Paulo, Brazil
- Melbourne, Australia
- Monte Carlo, Monaco

Using this app users can easily access current weather data and forecast for the next 5 days, facilitating planning for outdoor scenarios.

Searching for other cities is available when connected to the internet and opening a new city will also save it for easier future access. 

## First steps

To get the app running a few things will be necessary:

First and foremost an up-to-date Flutter environment, using an SDK higher than 3.1.0. At the time of development, flutter version 3.13.4 was used.

Next, support is given to both Android and iOS platforms, meaning a compatible device running one of those is necessary. Since regular distributions usually follow simpler means,
this documentation won't go in depth on how to properly set up your system.

Further info on how to install and setup flutter is available [here](https://docs.flutter.dev/get-started/install).

And last but not least, this app has a simple two-page structure: your home page will quickly show available cities, and the search icon allows you to find any available place, and clicking a card will redirect you to a more detailed page containing current weather and forecast for the next 5 days.

Enjoy!

## Environment variables

Environment variables, such as API_KEY and BASE_URL were set using a dotenv file, placed in the root folder of this project, and can be edited as necessary.

Usually this kind of constant, specially the key, should not be made available and would be checked out of version managemente by means of .gitignore. In this case, this set of constants was left available for ease of use of this project app, and in a more definite setting would be placed through use of a proper CI.

## Running
### App
To run the app, consider all that was said above, and with a running Android device or emulator, execute in your terminal

```
flutter pub get
flutter run
```


### Tests
Again, considering a valid structure is available, execute in your terminal:

```
flutter pub get
flutter test
```

## Technical details
### Architecture
This app was built using an approach similar to the [Very Good Architecture](https://verygood.ventures/blog/very-good-flutter-architecture), while using ViewModels instead of Blocs in order to control operations in the UI. 

To sum up, the app is built in 3 layers:

- Data

    Contains logic related to getting data (from API or local storage) and processing it to pass along to other pieces of the app.

- Domain

    Serves as a bridge between layers, containing pure entities and repository interfaces, makes it so that both the data and view layers don't depend on each other.

- View

    Contains a ViewModel approach set of controllers and pages. UI is built on pages with as little logic as possible, depending on streams that are controlled by the viewmodel and that
    are fed by data coming from other sections of the app.

Comparing this approach to Clean Dart, the main diference would be the removal of the infrastructure layer and usecases in domain.

Considering the scope and size of this project, opting for a simpler architecture in this case allow for more agility without having to sacrifice much in terms of organization.

### Other elements
- Dependecy injection was built using GetIt.

- State Management was made using ValueNotifier as streams.

- Mocktail was used for mocking dependencies in unit tests.

- Flutter_dotenv was used for picking up environment variables.
