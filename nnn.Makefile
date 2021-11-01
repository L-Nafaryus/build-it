project = nnn

git_repository = https://github.com/jarun/nnn.git
git_branch = master

dependencies = tar ncurses-devel readline-devel unzip zip xdg-utils
os_pm = xbps-install -Su

build_style = make
cmake_flags =
make_flags = O_PCRE=1 O_CTX8=1 O_ICONS=1 O_NERD=1

root_dir = $(abspath ./$(project))
source_dir = $(root_dir)/$(project)-src
build_dir = $(source_dir)


all: do_first do_fetch do_configure do_build 
 
do_first:
	make -f icons-in-terminal.Makefile
	make -f icons-in-terminal.Makefile install

do_fetch:
	sudo $(os_pm) $(dependencies)
	[ -d $(source_dir) ] || mkdir -p $(source_dir)
	[ -d $(source_dir)/.git ] || git clone -b $(git_branch) --depth 1 $(git_repository) $(source_dir)

do_configure: ;

do_build:
	[ -d $(build_dir) ] || mkdir -p $(build_dir)
	make $(make_flags) -C $(build_dir) -I $(source_dir)

install:
	sudo make install -C $(build_dir) -I $(source_dir)

clean:
	make -f icons-in-terminal.Makefile clean
	rm -rf $(root_dir)
