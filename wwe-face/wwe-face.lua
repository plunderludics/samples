-- for some reason this has to be run twice to work:
-- [anyway, just using bizhawk directly instead of plunderlib for now]
-- package.path = ";../../scripts/?.lua" .. package.path
-- plunder = require("plunderlib")

function string.fromBytes(t)
    local bytearr = {}
    for _, v in ipairs(t) do
       local utf8byte = v < 0 and (0xff + v + 1) or v
       table.insert(bytearr, string.char(utf8byte))
    end
    return table.concat(bytearr)
 end

function main()
    while true do
		emu.frameadvance()

        pressed = joypad.getimmediate()

        -- Disable all buttons except directional, X, L2 and R2
        -- Remap Circle and Square to Left and Right (rotates character)
        joypad.set({
            ["○"] = pressed["P1 D-Pad Left"],
            ["□"] = pressed["P1 D-Pad Right"],
            ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            ["L1"] = false,
            ["R1"] = false
        }, 1)
		gui.clearGraphics();
        --gui.drawText(100, 40, tostring(pressed["P1 D-Pad Left"]));
	end
end

main()

