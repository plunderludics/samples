
function main()

    while true do
		emu.frameadvance()

		joypad.set({['P1 C Up'] = true}) -- hold down the first-person look button
        
		-- gui.clearGraphics();
        -- gui.drawText(10, 40,x);
        -- print("hi");
		--print(windows)
		-- if (window ~= nil) then
		-- 	window:set_text("Knife")
		-- end
	end
end

main()