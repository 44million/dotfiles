use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set batteryPercent to word 6 of paragraph 2 of (do shell script "pmset -g batt")

if batteryPercent ² 100 then
	tell application "GeekTool Helper"
		tell its image geeklet "Battery"
			set the image url to "file:///Users/dill/geektools/assets/Full.png"
		end tell
	end tell
end if

if batteryPercent ³ 75 then
	tell application "GeekTool Helper"
		tell its image geeklet "Battery"
			set the image url to "file:///Users/dill/geektools/assets/Not.png"
		end tell
	end tell
end if

if batteryPercent < 50 then
	tell application "GeekTool Helper"
		tell its image geeklet "Battery"
			set the image url to "file:///Users/dill/geektools/assets/Half.png"
		end tell
	end tell
end if

if batteryPercent <= 25 then
	tell application "GeekTool Helper"
		tell its image geeklet "Battery"
			set the image url to "file:///Users/dill/geektools/assets/Dead.png"
		end tell
	end tell
end if