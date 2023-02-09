# Usage: python3 run_sample.py <sample_dir>

# TODO:
#  - nice way of patching in a piece of config (e.g. controls) without having to copy the whole config file
#  - possibility to pass in a custom rom directory

from sys import argv
import subprocess
import glob
import os
import logging

DEFAULT_CONFIG_FILE = r"../scripts/config2.ini"
BIZHAWK_EXE = r"../BizHawk-src/output/EmuHawk.exe"
ROMPATH_FILE = "rompath.txt"

def run_sample_dir(sample_dir):
	if not os.path.isdir(sample_dir):
		logging.error(f"Not a directory: {sample_dir}")

	rompath_file = os.path.join(sample_dir, ROMPATH_FILE)

	# Assume rom path is in a file called "rompath.txt"
	if not os.path.isfile(rompath_file):
		logging.error(f"Expected rom path in {rompath_file}")
		return
	with open(rompath_file) as f:
		rom_path = f.readline()
		print(f"Reading rom at {rom_path}")
		if not os.path.isfile(rom_path):
			logging.error(f"No file at {rom_path}")
			return

	# Look in the directory for save, lua or config files
	save_files = glob.glob(os.path.join(sample_dir, "*.State"))
	lua_files = glob.glob(os.path.join(sample_dir, "*.lua"))
	config_files = glob.glob(os.path.join(sample_dir, "*.ini"))

	if len(save_files) == 0:
		print("No save state found, will begin from start")
	elif len(save_files) > 1:
		logging.warning(f"Multiple save states found, will use only: {save_files[0]}")

	if len(config_files) == 0:
		print(f"No config file found, will use default config from {DEFAULT_CONFIG_FILE}")
	elif len(config_files) > 1:
		logging.warning(f"Multiple config files found, will use only: {config_files[0]}")

	if len(lua_files) == 0:
		print("No lua file found")
	elif len(lua_files) > 1:
		logging.warning(f"Multiple lua files found, will use only: {lua_files[0]}")

	save_file = save_files[0] if len(save_files) else None
	config_file = config_files[0] if len(config_files) else None
	lua_file = lua_files[0] if len(lua_files) else None

	title = sample_dir.strip("/\\")
	run_sample_files(rom_path, title, save_file, lua_file, config_file)

def run_sample_files(rom_path, title = None, save_file = None, lua_file = None, config_file = None):
	#print((rom_path, title, save_file, lua_file, config_file))

	if config_file is None:
		config_file = DEFAULT_CONFIG_FILE
	
	cmd  = [BIZHAWK_EXE]
	cmd += [f"--config={config_file}"] if config_file else []
	cmd += [f"--load-state={save_file}"] if save_file else []
	cmd += [f"--lua={lua_file}"] if lua_file else []
	cmd += [f"--windowtitle={title}"] if title else []
	cmd += [f'{rom_path}']
	print(" ".join(cmd))
	process = subprocess.Popen(cmd)

if __name__ == "__main__":
	sample_dir = argv[1]
	# TODO also allow specifying individual files directly
	run_sample_dir(sample_dir)