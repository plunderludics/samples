-- freeze xpos and ypos at initial values
-- freeze hp at initial values

xpos = {byte = 0x1C02C0, size = 4}
ypos = {byte = 0x1C02C8, size = 4}
hp =   {byte = 0x1C031C, size = 4}

function main()
    emu.frameadvance()
    x = memory.read_s32_le(xpos.byte)
    y = memory.read_s32_le(ypos.byte)
    h = memory.read_s32_le(hp.byte)

    while true do
		emu.frameadvance()

        memory.write_s32_le(xpos.byte, x)
        memory.write_s32_le(ypos.byte, x)
        memory.write_s32_le(hp.byte,   h)

        -- Disable all buttons except directional, X, L2 and R2
        joypad.set({
            -- ["○"] = false,
            -- ["□"] = false,
           -- ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            -- ["L1"] = false,
            ["R1"] = false -- psy power button
        }, 1)
		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

