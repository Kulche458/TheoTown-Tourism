
function script:nextDay()
	att_park = City.countBuildingsOfType("park") * 1
	att_public = City.countBuildingsOfType("public") * 10
	att_award = City.countBuildingsOfType("award") * 25
	att_landmark = City.countBuildingsOfType("landmark") * 100

	city_attractiveness = math.floor((att_park + att_public + att_award + att_landmark) / (City.getPeople() / 100))

	if City.getPeople() == 0 then
		city_attractiveness = 0
	end
	if city_attractiveness >= 100 then
		city_attractiveness = 100
	end
	if city_attractiveness <= 0 then
		city_attractiveness = 0
	end
end
