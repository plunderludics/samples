-- for some reason this has to be run twice to work:
-- [anyway, just using bizhawk directly instead of plunderlib for now]
-- package.path = ";../../scripts/?.lua" .. package.path
-- plunder = require("plunderlib")

cursor_x = {byte = 0x0DB518, size = 4}
cursor_y = {byte = 0x0DB51C, size = 4}

-- boundaries to clamp the cursor
x_low = 70
x_high = 250
y_low = 70
y_high = 170

base = 256
domain = "MainRAM"

function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    while true do
		emu.frameadvance()
		
        -- clamp cursor pos, which prevents camera from scrolling
        x = memory.read_u32_le(cursor_x.byte)
		x = clamp(x, x_low, x_high)
        memory.write_u32_le(cursor_x.byte, x)
		
        y = memory.read_u32_le(cursor_y.byte)
		y = clamp(y, y_low, y_high)
        memory.write_u32_le(cursor_y.byte, y)

        -- Disable all buttons except directional and X
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

