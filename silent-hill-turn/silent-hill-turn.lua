x_addr = 0x0BA024
y_addr = 0x0BA02C

function main()
    emu.frameadvance()
    x = memory.read_s32_le(x_addr)
    y = memory.read_s32_le(y_addr)

    while true do
		emu.frameadvance()

        memory.write_s32_le(x_addr, x)
        memory.write_s32_le(y_addr, y)

        -- Disable all buttons except L2
        joypad.set({
            ["○"] = false,
            ["□"] = false,
            ["△"] = false, 
            ["X"] = false, 
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            ["L1"] = false,
            ["R1"] = false,
            ["L2"] = true, --  Force L2 for nicer camera behavior
            ["R2"] = false,
            
            -- ["D-Pad Down"] = false,
            -- ["D-Pad Up"] = false,
            -- ["D-Pad Left"] = false,
            -- ["D-Pad Right"] = false
        }, 1)
		--gui.clearGraphics();
        --gui.drawText(100, 40, tostring(joypad.getimmediate()["P1 △"]));
        -- print("hi");
	end
end

main()

