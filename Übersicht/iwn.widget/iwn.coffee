# ------------------------------ CONFIG ------------------------------

# openweathermap.org api key
apiKey: '3788348a79dd1afafdd2be1d97e246e6'

# degree units; 'c' for celsius, 'f' for fahrenheit
unit: 'f'

# refresh every x minutes
refreshFrequency: '3min'

# show Beaufort wind scale; 'yes' or 'no'
windscale: 'yes'

# language; supported languages see https://openweathermap.org/current#multi
language: 'en'

# ---------------------------- END CONFIG ----------------------------

command: "echo {}"

makeCommand: (apiKey, lat, lon, language) ->
	"curl -sS 'https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{apiKey}&lang=#{language}'"

render: (o) -> """
	<article id="content">
		<div id="icon">
		</div>
		<div id="windscale">
		</div>
		<div id="left">
		<div id="temp">
		</div>
		<div id="condition">
		</div></div>
	</article>
"""

afterRender: (domEl) ->
	if @apiKey.length != 32
		domEl.innerHTML = '<a href="https://openweathermap.org/appid" style="color: red">You need an API key!</a>'
		return
	geolocation.getCurrentPosition (e) =>
		coords     = e.position.coords
		[lat, lon] = [coords.latitude, coords.longitude]
		@command   = @makeCommand(@apiKey, "#{lat}", "#{lon}", @language)

		@refresh()

update: (o, dom) ->
	data = JSON.parse(o)

	return unless data.main?
	t = data.main.temp
	c = data.weather[0].description

	if @unit == 'f'
		$(dom).find('#temp').html(Math.round((t - 273.15) * 9 / 5 + 32) + ' °F')
	else
		$(dom).find('#temp').html(Math.round(t - 273.15) + ' °C')

	$(dom).find('#condition').html(c)
	$(dom).find('#icon')[0].innerHTML = @getIcon(data.weather[0])

	if @windscale == 'yes'
		$(dom).find('#windscale')[0].innerHTML = @getWind(data.wind)

style: """
	width 25%
	bottom 1.5em
	left 1%
	font-family Avenir Next LT Pro, Futura
	font-smooth always
	color rgba(255,255,255,0.4)

	@font-face
		font-family Weather
		src url(iwn.widget/icons.svg) format('svg')
	#left
		padding-left 80px
	#temp
		font-size 2em
	#condition
		font-size 0.8em
	#icon
		font-size 3em
	#windscale
		font-size 1.5em
		position fixed
		bottom .5em
	#icon, #windscale
		vertical-align middle
		float left
		font-family Weather
"""

iconMapping:
	"unknown" :"&#xf03e;"
	"01d"     :"&#xf00d;"
	"01n"     :"&#xf02e;"
	"02d"     :"&#xf00c;"
	"02n"     :"&#xf081;"
	"03d"     :"&#xf002;"
	"03n"     :"&#xf031;"
	"04d"     :"&#xf013;"
	"04n"     :"&#xf013;"
	"09d"     :"&#xf01a;"
	"09n"     :"&#xf01a;"
	"10d"     :"&#xf019;"
	"10n"     :"&#xf019;"
	"11d"     :"&#xf01e;"
	"11n"     :"&#xf01e;"
	"13d"     :"&#xf01b;"
	"13n"     :"&#xf01b;"
	"50d"     :"&#xf003;"
	"50n"     :"&#xf04a;"
	"wind3"   :"&#xf0ba;"
	"wind4"   :"&#xf0bb;"
	"wind5"   :"&#xf0bc;"
	"wind6"   :"&#xf0bd;"
	"wind7"   :"&#xf0be;"
	"wind8"   :"&#xf0bf;"
	"wind9"   :"&#xf0c0;"
	"wind10"  :"&#xf0c1;"
	"wind11"  :"&#xf0c2;"
	"wind12"  :"&#xf0c3;"
	"none"    :""

getIcon: (data) ->
		return @iconMapping['unknown'] unless data
		@iconMapping[data.icon]
getWind: (data) ->
		if data.speed > 32.7
			@iconMapping["wind12"]
		else if data.speed > 28.5
			@iconMapping["wind11"]
		else if data.speed > 24.5
			@iconMapping["wind10"]
		else if data.speed > 20.8
			@iconMapping["wind9"]
		else if data.speed > 17.2
			@iconMapping["wind8"]
		else if data.speed > 13.9
			@iconMapping["wind7"]
		else if data.speed > 10.8
			@iconMapping["wind6"]
		else if data.speed > 8
			@iconMapping["wind5"]
		else if data.speed > 5.5
			@iconMapping["wind4"]
		else if data.speed > 3.4
			@iconMapping["wind3"]
		else
			@iconMapping["none"]
