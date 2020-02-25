#!/bin/bash -e

# Install dependencies

pip install pyinstaller
pip install git+https://github.com/angr/archinfo.git#egg=archinfo
pip install git+https://github.com/angr/pyvex.git#egg=pyvex
pip install git+https://github.com/angr/cle.git#egg=cle
pip install git+https://github.com/angr/claripy.git#egg=claripy
pip install git+https://github.com/angr/ailment.git#egg=ailment
pip install git+https://github.com/angr/angr.git#egg=angr
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    pip install keystone-engine
    pip install git+https://github.com/angr/archr.git#egg=archr
fi

# Install angr-mangement
pip install -e .

# Bundle!
python bundle.py

# macOS apps are folders...
if [[ "$OSTYPE" == "darwin"* ]]; then
    hdiutil create /tmp/angr-management-macOS.dmg -volname "angr-management nightly" -srcfolder dist
    rm -rf dist/*
    mv /tmp/angr-management-macOS.dmg dist/
else
    mv dist/angr-management dist/angr-management-ubuntu
fi
# Binary is currently at dist/start
