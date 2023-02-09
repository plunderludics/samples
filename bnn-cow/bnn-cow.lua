-- for some reason this has to be run twice to work:
-- [anyway, just using bizhawk directly instead of plunderlib for now]
-- package.path = ";../../scripts/?.lua" .. package.path
-- plunder = require("plunderlib")

xpos = {byte = 0x026C58, size = 4}
ypos = {byte = 0x026C60, size = 4}

-- boundaries to clamp the position
x_low = -13000
x_high = 99999
y_low = -9000
y_high = 99999

base = 256
domain = "MainRAM"

function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    while true do
		emu.frameadvance()

        -- Clamp position
        x = memory.read_s32_le(xpos.byte)
		x = clamp(x, x_low, x_high)
        memory.write_s32_le(xpos.byte, x)
		
        y = memory.read_s32_le(ypos.byte)
		y = clamp(y, y_low, y_high)
        memory.write_s32_le(ypos.byte, y)

        -- Disable all buttons except directional, X and Circle
        joypad.set({
            -- ["○"] = false,
            ["□"] = false,
            ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["L2"] = false
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

