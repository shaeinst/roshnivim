#! /usr/bin/sh

cache="$HOME/.cache"
config="$HOME/.config"
cache_build_path="$cache/build_files"
nvim_plug_path="$HOME/.local/share/nvim"
nvim_conf_path="$HOME/.config/nvim"
nvim_custom_plugin_conf_path="$nvim_conf_path/lua/plugins"

today_date=`date "+%Y-%m-%d_%T"`
current_dir="$PWD"


# create some directories
echo "setting up, wait..."
echo "Creating required directories.."
if [ ! -d "$cache/nvim"  ]; then
  mkdir -p "$cache/nvim" && echo "$cache/nvim"
fi

if [ ! -d "$cache/nvim/swap" ]; then
  mkdir -p "$cache/nvim/swap" && echo "$cache/nvim/swap"
fi

if [ ! -d "$cache/nvim/shada" ]; then
  mkdir -p "$cache/nvim/shada" && echo "$cache/nvim/shada"
fi

if [ ! -d "$cache/nvim/backedUP" ]; then
  mkdir -p "$cache/nvim/backedUP" && echo "$cache/nvim/backedUP"
fi

if [ ! -d "$cache/nvim/undos" ]; then
  mkdir -p "$cache/nvim/undos" && echo "$cache/nvim/undos"
fi

if [ ! -d "$cache_build_path" ]; then
  mkdir -p $cache_build_path && echo "$cache_build_path"
fi

# create directy for custom tools
if [ ! -d "$nvim_plug_path/custom_tools" ]; then
  mkdir -p "$nvim_plug_path/custom_tools" && echo "$nvim_plug_path/custom_tools"
fi



# cloning lazy-builder tool (https://github.com/shaeinst/lazy-builder)
if [ ! -d "$nvim_plug_path/custom_tools/lazy-builder" ]; then
  echo ""
  cd $nvim_plug_path/custom_tools && git clone https://github.com/shaeinst/lazy-builder
  echo ""
fi


# backup neovim config before installing
if [ -d "$nvim_conf_path" ]; then
  cd "$config" && mv nvim "nvim_$today_date"
  cd $current_dir
fi

# copy the roshnivim to ~/.config/ as nvim
if [ "$current_dir" != "$nvim_conf_path" ]; then
  if [ ! -d "$nvim_conf_path" ]; then
	cd $current_dir
	cp ../roshnivim "$nvim_conf_path" -r
	echo -e "\n\nwow! roshnivim is installed"
	echo -e "\ninstalling plugins"
	nvim  --headless -c 'PackerSync'
	echo -e "\n\nGreat, roshnivim is fully installed"
  fi
fi
