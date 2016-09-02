#!/bin/bash

cd PygmentsKit/Resources

hg clone -b stable ssh://hg@bitbucket.org/birkenfeld/pygments-main pygments-python

echo "Applying patch to pygments-python/pygments/formatters/other.py"

patch pygments-python/pygments/formatters/other.py other.py.patch
