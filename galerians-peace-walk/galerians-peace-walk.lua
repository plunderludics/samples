x_addr  = 0x1C02C0 -- 4B, signed, LE
y_addr  = 0x1C02C8 -- 4B, signed, LE
hp_addr = 0x1C031C -- 4B, signed, LE

y_low  = -9000000
y_high = -6500000

-- TODO move this into a library!
function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    while true do
		emu.frameadvance()

        
        -- Clamp position
        y = memory.read_s32_le(y_addr)
		y = clamp(y, y_low, y_high)
        memory.write_s32_le(y_addr, y)

        -- Disable all buttons except directional, X, L2 and R2
        joypad.set({
            -- ["○"] = false,
            -- ["□"] = false,
           -- ["△"] = false,
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            -- ["L1"] = false,
            ["R1"] = false -- head explode button
        }, 1)
		-- gui.clearGraphics();
        -- gui.drawText(100, 40, x..","..y);
        -- print("hi");
	end
end

main()

