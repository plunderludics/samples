-- for some reason this has to be run twice to work:
-- [anyway, just using bizhawk directly instead of plunderlib for now]
-- package.path = ";../../scripts/?.lua" .. package.path
-- plunder = require("plunderlib")

function main()
    while true do
		emu.frameadvance()

        -- Disable all buttons except directional, X, L2 and R2
        joypad.set({
            -- ["○"] = false,
            -- ["□"] = false,
            ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["L1"] = false,
            ["R1"] = false
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

