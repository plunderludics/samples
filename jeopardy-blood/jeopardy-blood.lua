timer_addr = 0x1F0A34

base = 256
domain = "MainRAM"

function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    while true do
		emu.frameadvance()

        -- -- Freeze timer
        memory.write_s16_le(timer_addr, 255, domain)

        -- Disable some buttons
        joypad.set({
            ["△"] = false,
            ["Start"] = false,
            ["Select"] = false
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

