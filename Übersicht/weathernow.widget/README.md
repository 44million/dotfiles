# Weather Now Widget
Made for [Übersicht](http://tracesof.net/uebersicht/)

This widget allows you to see the current temperature and conditions right on
your desktop.

![the widget in action](https://raw.githubusercontent.com/briandconnelly/weathernow-widget/master/screenshot.png)

## Installation

1. Copy `weathernow.widget` to your widgets folder.
2. Edit `index.coffee` within `weathernow.widget` and replace **\<api-key\>** with your own [forecast.io api key](https://developer.forecast.io). Unless you want to see the current weather in Seattle (Spoiler: it's probably raining), you'll also need to enter your latitude and longitude, which you can get from the URL when visiting [forecast.io](https://forecast.io).

## Advanced

### Setting the Refresh Rate

By default, the widget will get new data every 60 seconds. To adjust this, change the value of `refreshFrequency` in `index.coffee`. The value should be in milliseconds, so multiply the number of seconds by 1000. Note that forecast.io has a limit on how frequently you can send requests.


## Credits

This widget was originally forked from [Weather
Widget](https://github.com/felixhageloh/weather-widget). Icons are provided by
Erik Flowers' [Weather Icons](http://erikflowers.github.io/weather-icons/).

## License

See [LICENSE](https://raw.githubusercontent.com/briandconnelly/weathernow-widget/master/screenshot.png)

