extends PanelContainer

var hourly_rate = 0
var hours_per_day = 0

func _process(delta):
	if $VBoxContainer/VBoxContainer2/WHPD.value == 1:		# If work hours per day > 1, show "hour"
		$VBoxContainer/VBoxContainer2/WHPD.suffix = "hour"
	else:
		$VBoxContainer/VBoxContainer2/WHPD.suffix = "hours" # Else "hours"
		


func _on_hourly_rate_edit_focus_entered():
	# Do a smooth transition.
	var tw = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tw.tween_property($VBoxContainer/VBoxContainer/HBoxContainer/PanelContainer, "self_modulate", Color(0, 0.5, 1, 1), .4)
	tw.play()
	
func _on_hourly_rate_edit_focus_exited():
	# Do a smooth transition.
	var tw = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tw.tween_property($VBoxContainer/VBoxContainer/HBoxContainer/PanelContainer, "self_modulate", Color8(88, 88, 88, 255), .4)
	tw.play()
	
	# Let's make sure hourly rate is always an integer.
	$VBoxContainer/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/HourlyRateEdit.text = str(int(hourly_rate))


# Set the work hours per day value.
func _on_whpd_value_changed(value):
	hours_per_day = value
	do_calc()

# Set the hourly rate value.
func _on_hourly_rate_edit_text_changed(new_text):
	hourly_rate = int(new_text)
	do_calc()

# Method to calculate values
func do_calc():
	var per_day = hourly_rate * hours_per_day	# How much per day?
	var per_week = per_day * 5					# How much per weeK?
	var per_month = per_week * 4				# How much per month?
	var per_year = per_month * 12				# How much per year?
	$VBoxContainer/VBoxContainer3/PerDay.set_text("$"+add_comma_to_int(per_day)+" per day")
	$VBoxContainer/VBoxContainer3/PerWeek.set_text("$"+add_comma_to_int(per_week)+" per week")
	$VBoxContainer/VBoxContainer3/PerMonth.set_text("$"+add_comma_to_int(per_month)+" per month")
	$VBoxContainer/VBoxContainer3/PerYear.set_text("$"+add_comma_to_int(per_year)+" per year")


# Method to add commas to thousands.
func add_comma_to_int(integer):
	var number_string = str(integer)
	var result = ""
	var count = 0
	
	for i in range(number_string.length() - 1, -1, -1):
		result = number_string[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	
	return result



