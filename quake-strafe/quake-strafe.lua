-- TODO

base = 256
domain = "MainRAM"

function main()
    while true do
		emu.frameadvance()

        -- -- Freeze timer
        -- memory.write_s16_le(timer_addr, 255, domain)

        -- Disable everything except L1 and R1 and directional
        -- joypad.set({
        --     ["○"] = false,
        --     ["□"] = false,
        --     ["△"] = false,
        --     ["X"] = false,
        --     ["Analog"] = false,
        --     ["Start"] = false,
        --     ["Select"] = false
        -- }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

