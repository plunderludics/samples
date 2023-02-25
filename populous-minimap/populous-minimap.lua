cursor_x_addr = 0x164724

map_left  = 14155776
map_right = 20447232

function main()
    while true do
        emu.frameadvance();
        x = memory.read_u32_le(cursor_x_addr)

        -- make the cursor skip horizontally over the minimap
        pressed = joypad.getimmediate()

        if (map_left < x and x < map_right) then
            if (pressed["P1 D-Pad Right"]) then
                -- skip to right edge
                new_x = map_right
            else
                new_x = map_left
            end
            
            memory.write_u32_le(cursor_x_addr, new_x)
        end

        -- Directional only
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
            ["L2"] = false,
            ["R2"] = false
            
        }, 1)

		-- gui.clearGraphics();
        -- gui.drawText(10, 10, map_left.."\n"..x.."\n"..map_right);
        -- print("hi");
	end
end

main()

