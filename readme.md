# WeatherApp

WeatherApp is a simple command-line application written in Lua that provides weather forecasts using data from the OpenWeatherMap API. The application allows users to get weather forecasts by city name, ZIP code, or coordinates, as well as manage a list of favorite cities.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Libraries Used](#libraries-used)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Installation

To run the WeatherApp, follow these steps:

1. Install Lua on your machine. You can download it from [here](https://www.lua.org/download.html).

2. Clone this repository to your local machine.

    ```bash
    git clone https://github.com/your-username/WeatherApp.git
    ```

3. Navigate to the project directory.

    ```bash
    cd WeatherApp
    ```

4. Run the main.lua file.

    ```bash
    lua src/main.lua
    ```

## Usage

The WeatherApp provides a simple command-line interface. After running the application, follow the on-screen instructions to get weather forecasts and manage your favorite cities.

## Features

- Get weather forecast by city name.
- Get weather forecast by ZIP code.
- Get weather forecast by coordinates.
- View weather forecasts for favorite cities.
- Add new cities to the list of favorites.
- Delete cities from the list of favorites.

## Libraries Used

The WeatherApp project utilizes the following external libraries:

- **lua-http**
  - A powerful library for making HTTP requests in Lua, used for fetching weather data from the OpenWeatherMap API.
  - [GitHub Repository](https://github.com/daurnimator/lua-http)
  - [Documentation](https://daurnimator.github.io/lua-http/)

- **cjson.safe**
  - A JSON encoding/decoding library for Lua, used for processing JSON responses from the OpenWeatherMap API.
  - [GitHub Repository](https://github.com/mpx/lua-cjson)
  - [Documentation](http://www.kyne.com.au/~mark/software/lua-cjson.php)

- **lsqlite3**
  - A SQLite database binding for Lua, used for database operations in the project.
  - [GitHub Repository](https://github.com/tomasguisasola/lsqlite3)
  - [Documentation](https://www.sqlite.org/lsqlite3.html)

- **socket.url**
  - A Lua library for URL parsing, used for formatting and escaping URLs.
  - [GitHub Repository](https://github.com/diegonehab/luasocket)
  - [Documentation](http://w3.impa.br/~diego/software/luasocket/url.html)

- **env_utils**
  - An in-house utility module for reading environment variables, used for loading API keys and other configuration parameters.
  - [Project File](utils/env_utils.lua)

## Project Structure

The project structure is organized as follows:

- **config/**
  - Configuration file for API keys and other settings.
- **db/**
  - Database-related files, including the SQLite database and database API.
- **modules/**
  - Modules handling input, output, and API requests.
- **src/**
  - The main Lua script to run the WeatherApp.
- **utils/**
  - Utility functions, including environment variable reading.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
