project = oce

git_repository = https://github.com/tpaviot/oce.git
git_branch = v6.2.2105

dependencies = libXmu libXmu-devel glu glu-devel glew glew-devel glfw glfw-devel patch openmpi openmpi-devel lapack lapack-devel ffmpeg ffmpeg-devel python3 python3-mpi4py
os_pm = xbps-install -Su

build_style = cmake
cmake_flags = -DUSE_OCC=ON -DUSE_MPI=ON -DUSE_JPEG=ON -DUSE_MPEG=ON
make_flags = -j4

root_dir = $(abspath ./$(project))
source_dir = $(root_dir)/$(project)-src
build_dir = $(root_dir)/$(project)-build


all: do_first do_fetch do_configure do_build 
 
do_first: 
	make -f oce.Makefile
	sudo make -f oce.Makefile install

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
