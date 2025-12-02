.PHONY: xx

all:
	if [ -d "build" ]; then \
		cd build && make -j4; \
	else \
		mkdir build; \
		cd build && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DCMAKE_PREFIX_PATH=/opt/homebrew/opt/mysql-client \
  		-DCMAKE_CXX_COMPILER:FILEPATH=$(shell which g++) \
		-DCMAKE_C_COMPILER:FILEPATH=$(shell which gcc) ..; \
	fi

clean:
	rm -rf build

%:
	if [ -d "build" ]; then \
		cd build && make $@; \
	else \
		mkdir build; \
		cd build && cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DCMAKE_PREFIX_PATH=/opt/homebrew/opt/mysql-client \
		-DCMAKE_CXX_COMPILER:FILEPATH=$(shell which g++) \
		-DCMAKE_C_COMPILER:FILEPATH=$(shell which gcc) $@ ..; \
	fi
