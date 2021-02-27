
function script:nextDay()

	hotel_park = 0 --all need
	hotel_culture = 0 --all boost
	hotel_sport = 0 -- all boost
	hotel_pollution = 0 --all decrease

	local hotel_00_count = City.countBuildings(pluc_hotel_00)
	local hotel_01_count = City.countBuildings(pluc_hotel_01)
	local hotel_02_count = City.countBuildings(pluc_hotel_02)
	local hotel_03_count = City.countBuildings(pluc_hotel_03)
	hotel_count = hotel_00_count + hotel_01_count + hotel_02_count + hotel_03_count

	hotels = Array{pluc_hotel_00, pluc_hotel_01, pluc_hotel_02, pluc_hotel_03}

	for i=1,#hotels do
		local hotel = hotels[i]
		local ctr = City.countBuildings(hotel)
		for j=1,ctr do

			local x,y = City.getBuilding(j, hotel)

			hotel_park_collect = Tile.getInfluence(Tile.INFLUENCE_PARK, x, y)
			hotel_park = hotel_park + hotel_park_collect

			hotel_culture_collect = Tile.getInfluence(Tile.INFLUENCE_CULTURE, x, y)
			hotel_culture = hotel_culture + hotel_culture_collect

			hotel_sport_collect = Tile.getInfluence(Tile.INFLUENCE_SPORT, x, y)
			hotel_sport = hotel_sport + hotel_sport_collect

			hotel_pollution_collect = Tile.getInfluence(Tile.INFLUENCE_POLLUTION, x, y)
			hotel_pollution = hotel_pollution + hotel_pollution_collect

			hotel_park_influence_factor = (hotel_park / hotel_count) * 0.75 * 100
			hotel_culture_influence_factor = (hotel_culture / hotel_count) * 0.5 * 100
			hotel_sport_influence_factor = (hotel_sport / hotel_count) * 0.25 * 100
			hotel_pollution_influence_factor = (hotel_pollution / hotel_count) * 1.5 * 100

			overall_hotel_happiness_notrounded = hotel_park_influence_factor + hotel_culture_influence_factor + hotel_sport_influence_factor - hotel_pollution_influence_factor
			overall_hotel_happiness = math.floor(((overall_hotel_happiness_notrounded * 10^2) + 0.5) / (10^2))
			if overall_hotel_happiness < 0 then
				overall_hotel_happiness = 0
			end
		end

		local hotel_00_capacity = hotel_00_count * 12
		local hotel_01_capacity = hotel_01_count * 259
		local hotel_02_capacity = hotel_02_count * 42
		local hotel_03_capacity = hotel_03_count * 8

		tourist_capacity = hotel_00_capacity + hotel_01_capacity + hotel_02_capacity + hotel_03_capacity
	end
end

function script:init()
	pluc_hotel_00 = Draft.getDraft('$kulche_hotel_00')
	pluc_hotel_01 = Draft.getDraft('$kulche_hotel_01')
	pluc_hotel_02 = Draft.getDraft('$kulche_hotel_02')
	pluc_hotel_03 = Draft.getDraft('$kulche_hotel_03')
end

function script:update()
	Drawing.drawText(hotel_park_influence_factor, 100, 140)
	Drawing.drawText(hotel_culture_influence_factor, 100, 160)
	Drawing.drawText(hotel_sport_influence_factor, 100, 180)
	Drawing.drawText(hotel_pollution_influence_factor, 100, 200)
	Drawing.drawText(overall_hotel_happiness, 140, 220)
	Drawing.drawText(city_attractiveness, 200, 140)
	Drawing.drawText(tourist_capacity, 240, 140)
end

--i want to die so bad