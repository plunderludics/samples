function main()
    while true do
		emu.frameadvance()

        -- Disable all buttons except L2
        joypad.set({
            ["○"] = false,
            ["□"] = false,
            ["△"] = false, 
            ["X"] = false, 
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            ["L1"] = false,
            ["R1"] = false,
            --["L2"] = false,
            ["R2"] = false,
            
            ["D-Pad Down"] = false,
            ["D-Pad Up"] = false,
            ["D-Pad Left"] = false,
            ["D-Pad Right"] = false
        }, 1)
		--gui.clearGraphics();
        --gui.drawText(100, 40, tostring(joypad.getimmediate()["P1 △"]));
        -- print("hi");
	end
end

main()

