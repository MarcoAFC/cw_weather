# CWeather

## Description and scope

An app built to allow checking the weather in a few different cities around the world.

Since this project has a limited scope, main operability is only offered for the following cities:

- Silverstone, UK
- São Paulo, Brazil
- Melbourne, Australia
- Monte Carlo, Monaco

Using this app users can easily access current weather data and forecast for the next 5 days, facilitating planning for outdoor scenarios.

## First steps

To get the app running a few things will be necessary:

First and foremost an up-to-date Flutter environment, using an SDK higher than 3.1.0. At the time of development, flutter version 3.13.4 was used.

Next, support is given to both Android and iOS platforms, meaning a compatible device running one of those is necessary. Since regular distributions usually follow simpler means,
this documentation won't go in depth on how to properly set up your system.

And last but not least, this app has a simple two-page structure: your home page will quickly show current weather data for supported regions and clicking any of the cards 
will redirect you to a more complete screen showcasing detailed info on current weather and what to expect for the next few days.

Enjoy!

## Technical details

This app was built using the MVVM approach to architecture, separating UI implementations from business logic and data-related code.

On Flutter specific contexts, GetIt was used for dependency injection, Dio for HTTP requests and native ValueNotifier was used for state management.

