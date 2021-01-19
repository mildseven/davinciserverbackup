on zero_pad(value, string_length)
	set string_zeroes to ""
	set digits_to_pad to string_length - (length of (value as string))
	if digits_to_pad > 0 then
		repeat digits_to_pad times
			set string_zeroes to string_zeroes & "0" as string
		end repeat
	end if
	set padded_value to string_zeroes & value as string
	return padded_value
end zero_pad

set now to (current date)

set cDate to (year of now as integer) as string
set cDate to cDate & "-"
set cDate to cDate & zero_pad(month of now as integer, 2)
set cDate to cDate & "-"
set cDate to cDate & zero_pad(day of now as integer, 2)
set cDate to cDate & " "
set cDate to cDate & zero_pad(hours of now as integer, 2)
set cDate to cDate & ":"
set cDate to cDate & zero_pad(minutes of now as integer, 2)
set cDate to cDate & ":"
set cDate to cDate & zero_pad(seconds of now as integer, 2)

activate application "DaVinci Resolve Project Server"
tell application "System Events" to tell process "DaVinci Resolve Project Server"
	click button "Backup" of window "DaVinci Resolve Project Server"
	repeat until (exists window "Backup Database")
		delay 1
	end repeat
	keystroke "G" using {command down, shift down}
	delay 2
	set value of combo box 1 of sheet 1 of window "Backup Database" to "~/Documents/DaVinci Resolve Backup"
	click button "Go" of sheet 1 of window "Backup Database"
	set value of text field 1 of window "Backup Database" to "Resolve_" & cDate
	click button "Save" of window "Backup Database"
	delay 2
	click button "Backup" of window "Message"
	delay 1
	repeat until (exists window "Message")
		delay 1
	end repeat
	click button "OK" of window "Message"
end tell