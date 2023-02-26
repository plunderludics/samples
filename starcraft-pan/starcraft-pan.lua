cursor_x_addr = {byte = 0x0AFE18, size = 4}
cursor_y_addr = {byte = 0x0AFE1A, size = 4}

base = 256
domain = "RDRAM"

function main()
    while true do
        x = memory.read_s16_be(cursor_x_addr.byte, domain)
        y = memory.read_s16_be(cursor_y_addr.byte, domain)
		emu.frameadvance()

        -- -- Freeze cursor
        memory.write_s16_be(cursor_x_addr.byte, x, domain)
        memory.write_s16_be(cursor_y_addr.byte, y, domain)

        -- Disable all buttons except directional
        joypad.set({
            ["A"] = false,
            ["B"] = false,
            ["L"] = false,
            ["R"] = false,
            ["Z"] = false,
            ["DPad U"] = false,
            ["DPad D"] = false,
            ["DPad L"] = false,
            ["DPad R"] = false,
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

