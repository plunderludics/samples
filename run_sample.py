# Usage: python3 run_sample.py <sample_dir>

# TODO:
#  - nice way of patching in a piece of config (e.g. controls) without having to copy the whole config file
#  - possibility to pass in a custom rom directory

from sys import argv
import subprocess
import glob
import os
import logging
import argparse

DEFAULT_CONFIG_FILE = r"../scripts/config2.ini"
BIZHAWK_EXE = r"../BizHawk-src/output/EmuHawk.exe"
ROMPATH_FILE = "rompath.txt"

parser = argparse.ArgumentParser()
parser.add_argument('sample_dir')           # positional argument
parser.add_argument('--rom')                # option that takes a value

# TODO: other args (title, save_file, lua_file, config_file)
# TODO: sample_dir should be optional as long as you specify a rom.

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

def run_sample(args):
	sample_dir = args.sample_dir
	if not sample_dir:
		logging.error("sample_dir argument must be defined")

	if not os.path.isdir(sample_dir):
		logging.error(f"Not a directory: {sample_dir}")

	if not args.rom:
		# Fill in from the rompath.txt file in sample_dir
		rompath_file = os.path.join(sample_dir, ROMPATH_FILE)

		# Assume rom path is in a file called "rompath.txt"
		if not os.path.isfile(rompath_file):
			logging.error(f"Expected rom path in {rompath_file} (or provide --rom argument)")
			return

		with open(rompath_file) as f:
			args.rom = f.readline()
	
	print(f"Reading rom at {args.rom}")
	if not os.path.isfile(args.rom):
		logging.error(f"No file at {args.rom}")
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
	run_sample_files(args.rom, title, save_file, lua_file, config_file)

if __name__ == "__main__":
	args = parser.parse_args()
	run_sample(args)