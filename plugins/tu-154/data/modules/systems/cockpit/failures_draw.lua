-- this script draws table of failures

size = {100, 100}


local text_font = loadBitmapFont('basic_font.fnt')



defineProperty("drawTable") -- table of failures
defineProperty("maxDraw") -- table of failures

function draw()
	
	local tbl = get(drawTable)

	local pos = 0
	
	local count = get(maxDraw)
	
	for k, v in ipairs(tbl) do
		
		if pos < count / 2 then
			drawBitmapText(text_font, 0, -pos * 30, v, TEXT_ALIGN_LEFT, {0, 0, 0, 1})
		elseif pos < get(maxDraw) then
			drawBitmapText(text_font, 500, -(pos - count / 2) * 30, v, TEXT_ALIGN_LEFT, {0, 0, 0, 1})
		end
		
		pos = pos + 1
	
	end
	

end
