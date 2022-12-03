function main()
    while true do
		emu.frameadvance()

		joypad.set({['P1 C Up'] = true}) -- hold down the first-person look button
        
		-- gui.clearGraphics();
        -- gui.drawText(10, 40,x);
        -- print("hi");
	end
end

main()