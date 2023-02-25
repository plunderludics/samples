x_addr  = 0x1C02C0 -- 4B, signed, LE
y_addr  = 0x1C02C8 -- 4B, signed, LE
hp_addr = 0x1C031C -- 4B, signed, LE

y_low  = -9000000
y_high = -7800000
x_low  = -9000000
x_high = 4000000

idle_restart_timer = 60*1 -- Restart after 1 minute of inactivity
savestate_name = "./save.State"

-- TODO move this into a library!
function clamp(v, low, high)
	return math.min(math.max(v, low), high)
end

function main()
    -- lock hp
    h = memory.read_s32_le(hp_addr)

    last_input_time = os.clock()

    while true do
		emu.frameadvance()

        -- Idle restart timer
        if (os.clock() - last_input_time > idle_restart_timer) then
            -- Restart
            --print("Restart game")
            last_input_time = os.clock()
            savestate.load(savestate_name)
        end

        input = joypad.getimmediate()
        is_receiving_input = false
        --print(input)
        for _,v in pairs(input) do
            -- print(_, v)
            if v == true then
                is_receiving_input = true
                break
            end
        end
        if is_receiving_input then
            -- received input, reset idle timer
            --print("Reset timer")
            last_input_time = os.clock()
        end

        
        -- Clamp position
        y = memory.read_s32_le(y_addr)
		y = clamp(y, y_low, y_high)
        memory.write_s32_le(y_addr, y)
        
        x = memory.read_s32_le(x_addr)
		x = clamp(x, x_low, x_high)
        memory.write_s32_le(x_addr, x)

        -- lock hp
        memory.write_s32_le(hp_addr,   h)

        pressed = joypad.getimmediate()
        -- Disable all buttons except directional, X, L2 and R2
        joypad.set({
            ["○"] = false, -- minimap
            ["□"] = false, -- ?
           -- ["△"] = false, -- magic wand
            ["Start"] = false,
            ["Select"] = false,
            ["Analog"] = false,
            -- ["L1"] = false,
            -- ["R1"] = false -- head explode button
        }, 1)
		--gui.clearGraphics();
        --gui.drawText(100, 40, tostring(joypad.getimmediate()["P1 △"]));
        -- print("hi");
	end
end

main()

