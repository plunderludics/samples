-- for some reason this has to be run twice to work:
-- [anyway, just using bizhawk directly instead of plunderlib for now]
-- package.path = ";../../scripts/?.lua" .. package.path
-- plunder = require("plunderlib")

cam_x_addr = {byte = 0xA2EE8, size = 4}
cam_y_addr = {byte = 0xA2EEC, size = 4}

base = 256
domain = "RDRAM"

function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    -- emu.frameadvance()

    while true do
        camx = memory.read_s32_be(cam_x_addr.byte, domain)
        camy = memory.read_s32_be(cam_y_addr.byte, domain)
		emu.frameadvance()

        -- -- Freeze camera
        memory.write_s32_be(cam_x_addr.byte, camx, domain)
        memory.write_s32_be(cam_y_addr.byte, camy, domain)

        -- Disable all buttons except directional, A and B
        joypad.set({
            ["L"] = false,
            ["R"] = false,
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

