timer_addr = 0x1F0A34

base = 256
domain = "MainRAM"

function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    while true do
		emu.frameadvance()
        
        pressed = joypad.getimmediate()


        -- [Remap L1 and R1 to X and O respectively, disable everything else]
        joypad.set({
            -- ["L1"] = pressed["P1 ○"],
            -- ["R1"] = sq_pressed,
            ["○"] = false,
            ["□"] = false,
            ["△"] = false,
            ["X"] = false,
            ["Analog"] = false,
            ["Start"] = false,
            ["Select"] = false
        }, 1)

        
		-- gui.clearGraphics();
        -- gui.drawText(100, 40, tostring(pressed["P1 □"]).. tostring(sq_pressed));

        -- print("hi");
	end
end

main()

