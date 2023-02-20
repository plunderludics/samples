function main()
    while true do
        emu.frameadvance()
        -- TODO: disable everything except dpad and L/R (?)
        joypad.set({
            ["A"] = false,
            ["B"] = false,
            -- ["L"] = false,
            -- ["R"] = false,
            ["Z"] = false,
            ["C Up"] = false,
            ["C Down"] = false,
            ["C Left"] = false,
            ["C Right"] = false,
            ["Start"] = false,
            ["Select"] = false
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

