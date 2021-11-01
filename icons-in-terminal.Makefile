project = icons-in-terminal

git_repository = https://github.com/sebastiencs/icons-in-terminal.git
git_branch = master

dependencies =
os_pm =

build_style = custom 
cmake_flags =
make_flags = 

root_dir = $(abspath ./$(project))
source_dir = $(root_dir)/$(project)-src
build_dir = $(source_dir)


all: do_fetch do_configure do_build 

do_fetch:
	[ -d "$(source_dir)" ] || mkdir -p $(source_dir)
	[ -d $(source_dir)/.git ] || git clone -b $(git_branch) --depth 1 $(git_repository) $(source_dir)

do_configure: ;

do_build: ;

install:
	cd $(source_dir) && $(source_dir)/install.sh

clean:
	rm -rf $(root_dir)
