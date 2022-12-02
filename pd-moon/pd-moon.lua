ammo = {byte = 0x206EF8, size = 4}
domainToCheck = "RDRAM"
function main()
    while true do
		emu.frameadvance()
        x = getValue(ammo);
        setValue(ammo, 2^33); -- 1677721600 => 100 in swapped endianness
        -- this is fucked i think because of endianness issues but whatever, it gets the job done
        -- 

        
		-- gui.clearGraphics();
        -- gui.drawText(10, 40,x);
        -- print("hi");
	end
end

-- TODO these should be in a library...

function getValue(address, base)
    -- todo add big/little endian flag
	local byte = address["byte"]
	local size = address["size"]
	local kind = address["kind"] or "INT"
	local base = base or 256

	local acc = 0
	if kind == "FLOAT" then
		acc = memory.readfloat(byte, true, domainToCheck)
	else
		local mult = 1
		for i = 1, size do
			local read = memory.readbyte(byte, domainToCheck)
			acc = acc + (read * mult)
			mult = mult * base
		end
	end

	return acc
end

function setValue(address, value, base)
	local byte = address["byte"]
	local size = address["size"]
	local kind = address["kind"] or "INT"
	local base = base or 256

	if kind == "FLOAT" then
		memory.writefloat(byte, value, true, domainToCheck)
	else
		-- write biggest byte last
		for i = 1, size do
			byte_value = math.floor(value/(base^i))%base;
			memory.writebyte(byte, byte_value, domainToCheck)
		end
	end
end

main()

