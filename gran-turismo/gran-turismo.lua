function main()
    client.SetVolume(10);
    while true do
        emu.frameadvance();

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
	end
end

main()

