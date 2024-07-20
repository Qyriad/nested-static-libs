#include "libfrob.hpp"

#include <cstdio>

extern "C" unsigned char const *get_hostname();

extern "C" void frobnicate()
{
	printf("frobnicated: %s\n", get_hostname());
}
