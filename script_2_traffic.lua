
function script:enterCity()
	city_size = City.getWidth()
end

function script:nextDay()
	for i=1,city_size do
		if Tile.hasRoad(0, i) then
			uwu = Tile.getRoadFrame(0, i)
		end
	end
	Debug.toast(uwu)
end
