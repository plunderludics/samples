function main()
    while true do
        emu.frameadvance();

        -- Directional only
        joypad.set({
            ["○"] = false,
            ["□"] = false,
            ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            ["L1"] = false,
            ["R1"] = false,
            ["L2"] = false,
            ["R2"] = false
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

