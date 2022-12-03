function main()
    while true do
		emu.frameadvance()
		-- tap R every 100 frames or so to stop the game from going into attract mode
		if (math.random() < 0.01) then
			joypad.set({['P1 R'] = true}) 
		end
        
		-- gui.clearGraphics();
        -- gui.drawText(10, 40,x);
        -- print("hi");
	end
end

main()