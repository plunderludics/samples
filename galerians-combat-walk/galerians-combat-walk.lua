x_addr  = 0x1C02C0 -- 4B, signed, LE
y_addr  = 0x1C02C8 -- 4B, signed, LE
hp_addr = 0x1C031C -- 4B, signed, LE

angle = -35*(math.pi/180)

-- bounds in rotated space
x_low  = 2000000
x_high = 6000000
y_low  = 3200000
y_high = 4000000

-- transform coordinate system by theta radians clockwise rotation
function rotate(x, y, theta)
    return (x*math.cos(theta) - y*math.sin(theta)), (x*math.sin(theta) + y*math.cos(theta))
end

-- transform bounds to rotated space
-- x_low, y_low = rotate(x_low, y_low, angle)
-- x_high, y_high = rotate(x_high, y_high, angle)

idle_restart_timer = 60*1 -- Restart after 1 minute of inactivity
savestate_name = "./combat.State"

-- TODO move this into a library!
function clamp(v, low, high)
    if (low < high) then
	    return math.min(math.max(v, low), high)
    else 
	    return math.min(math.max(v, high), low)
    end
end

function main()
    -- lock hp
    hp = memory.read_s32_le(hp_addr)

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
        -- y = memory.read_s32_le(y_addr)
		-- y = clamp(y, y_low, y_high)
        -- memory.write_s32_le(y_addr, y)
        
        -- x = memory.read_s32_le(x_addr)
		-- x = clamp(x, x_low, x_high)
        -- memory.write_s32_le(x_addr, x)

        -- lock hp
        memory.write_s32_le(hp_addr, hp)

        x = memory.read_s32_le(x_addr)
        y = memory.read_s32_le(y_addr)

        -- clamp x & y within rotated rect
        -- first rotate
        x_r, y_r = rotate(x, y, angle)
        -- then clamp
        x_r = clamp(x_r, x_low, x_high)
        y_r = clamp(y_r, y_low, y_high)
        -- then rotate back
        x, y = rotate(x_r, y_r, -angle)
        -- write to memory
        memory.write_s32_le(x_addr, x)
        memory.write_s32_le(y_addr, y)
        
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

		-- gui.clearGraphics();
        -- gui.drawText(10, 10,
        -- "x "..tostring(x)..
        -- "\nx_r "..tostring(x_r)..
        -- "\ny "..tostring(y)..
        -- "\ny_r "..tostring(y_r)..
        -- "\nx_low "..tostring(x_low)..
        -- "\nx_high "..tostring(x_high)..
        -- "\ny_low "..tostring(y_low)..
        -- "\ny_high "..tostring(y_high))

	end
end

main()

