
## >>>>>>>>>> STRUCTURE >>>>>>>>>>
SOURCES_DIRECTORY=src
OBJECTS_DIRECTORY=obj
TESTS_DIRECTORY=tests
LIBS_DIRECTORY=lib
## <<<<<<<<<< STUCTURE <<<<<<<<<<




## >>>>>>>>>> COMPILERS >>>>>>>>>>
# C compiler
CC=gcc
C_COMMON_FLAGS=-pedantic -Wall -Wextra -Werror
C_PROJECT_FLAGS=$(C_COMMON_FLAGS) -ansi -nolibc -nostdlib -fno-builtin
C_TESTS_FLAGS=$(C_COMMON_FLAGS)

# Assembler
AC=nasm
AFLAGS=-f elf64

# Linker
_PROJECT_LIBRARIES=$(shell ls $(LIBS_DIRECTORY))
_PROJECT_LIBRARY_NAMES=$(patsubst lib%.so,%,$(_PROJECT_LIBRARIES))
_PROJECT_LIBRARY_LINKS=$(addprefix -l,$(_PROJECT_LIBRARY_NAMES))
LDFLAGS=-lcriterion -L$(LIBS_DIRECTORY) $(_PROJECT_LIBRARY_LINKS)
## <<<<<<<<<< COMPILERS <<<<<<<<<<




## >>>>>>>>>> SOURCES >>>>>>>>>>
ASM_SOURCES=$(shell find $(SOURCES_DIRECTORY) -type f -name '*.nasm')
ASM_OBJECTS=$(subst $(SOURCES_DIRECTORY),$(OBJECTS_DIRECTORY),$(ASM_SOURCES:.nasm=.nasm.o))
## <<<<<<<<<< SOURCES <<<<<<<<<<




## >>>>>>>>>> OBJECTS >>>>>>>>>>
objects: $(ASM_OBJECTS)

$(OBJECTS_DIRECTORY)/%.nasm.o: $(SOURCES_DIRECTORY)/%.nasm
	$(AC) $(AFLAGS) $^ -o $(subst $(SOURCES_DIRECTORY),$(OBJECTS_DIRECTORY),$@) && strip --discard-all $(subst $(SOURCES_DIRECTORY),$(OBJECTS_DIRECTORY),$@)

.PHONY: clean-objects
clean-objects:
	find $(OBJECTS_DIRECTORY)/ -type f -name '*.o' | xargs rm 2>/dev/null; true
## <<<<<<<<<< OBJECTS <<<<<<<<<<




## >>>>>>>>>> LIBRARIES >>>>>>>>>>
lib-string: $(LIBS_DIRECTORY)/libstring.so
$(LIBS_DIRECTORY)/libstring.so: $(filter obj/asm/string/%,$(ASM_OBJECTS))
	$(CC) $(C_COMMON_FLAGS) -fPIC -shared $^ -o $@

lib-linux64-system: $(LIBS_DIRECTORY)/liblinux64-system.so
$(LIBS_DIRECTORY)/liblinux64-system.so: $(filter obj/asm/linux64/system/%,$(ASM_OBJECTS))
	$(CC) -fPIC -shared $^ -o $@

libraries: lib-string lib-linux64-system

.PHONY: clean-libraries
clean-libraries:
	rm $(LIBS_DIRECTORY)/* 2>/dev/null; true
## <<<<<<<<<< LIBRARIES <<<<<<<<<<




## >>>>>>>>>> TESTS >>>>>>>>>>
TEST_SOURCES=$(shell find $(TESTS_DIRECTORY)/ -type f -name "*.c")
TEST_BINARY=unit-tests

$(TESTS_DIRECTORY)/$(TEST_BINARY): $(TEST_SOURCES) libraries
	$(CC) $(LDFLAGS) $(C_TESTS_FLAGS) $(TEST_SOURCES) -o $(TESTS_DIRECTORY)/$(TEST_BINARY)

run-tests: $(TESTS_DIRECTORY)/$(TEST_BINARY)
#	export LD_LIBRARY_PATH=$(LIBS_DIRECTORY):$$LD_LIBRARY_PATH && ./$(TESTS_DIRECTORY)/$(TEST_BINARY) --verbose
	export LD_LIBRARY_PATH=$(LIBS_DIRECTORY):$$LD_LIBRARY_PATH && ./$(TESTS_DIRECTORY)/$(TEST_BINARY)

.PHONY: clean-tests
clean-tests:
	rm $(TESTS_DIRECTORY)/$(TEST_BINARY) 2>/dev/null; true

#.PHONY: clean-tests
#clean-tests:
#	rm $(shell find $(TESTS_DIRECTORY) -type f -executable) 2>/dev/null; true
## <<<<<<<<<< TESTS <<<<<<<<<<




.PHONY: clean-all
clean-all: clean-objects clean-libraries clean-tests
