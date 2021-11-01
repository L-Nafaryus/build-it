project = oce

git_repository = https://github.com/tpaviot/oce.git
git_branch = master

dependencies = tcl tcl-devel tk tk-devel
os_pm = xbps-install -Su

build_style = cmake
cmake_flags =
make_flags = -j4

root_dir = $(abspath ./$(project))
source_dir = $(root_dir)/$(project)-src
build_dir = $(root_dir)/$(project)-build


all: do_first do_fetch do_configure do_build 
 
do_first: ;

do_fetch:
	sudo $(os_pm) $(dependencies)
	[ -d $(source_dir) ] || mkdir -p $(source_dir)
	[ -d $(source_dir)/.git ] || git clone -b $(git_branch) --depth 1 $(git_repository) $(source_dir)

do_configure: 
	cmake $(cmake_flags) -S $(source_dir) -B $(build_dir)

do_build:
	[ -d $(build_dir) ] || mkdir -p $(build_dir)
	make $(make_flags) -C $(build_dir) -I $(build_dir)

install:
	sudo make install -C $(build_dir) -I $(build_dir)

clean:
	rm -rf $(root_dir)
