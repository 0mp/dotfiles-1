#!/usr/bin/env bash
set -euxo pipefail

BUILD_DIR=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ST_DIR=$DIR/../st
CONFIG=$ST_DIR/config.h

source $DIR/common.sh

NAME=st
VERSION=0.8.2
SRC_FILENAME="st-$VERSION.tar.gz"
SRC_DIR="st-$VERSION"
SRC_URL="https://dl.suckless.org/st/$SRC_FILENAME"
SRC_CHECKSUM="aeb74e10aa11ed364e1bcc635a81a523119093e63befd2f231f8b0705b15bf35"

BOLD_IS_NOT_BRIGHT_FILENAME="bold-is-not-bright.diff"
BOLD_IS_NOT_BRIGHT_URL="https://st.suckless.org/patches/bold-is-not-bright/st-bold-is-not-bright-20190127-3be4cf1.diff"
BOLD_IS_NOT_BRIGHT_CHECKSUM="329169acac7ceaf901995d6e0897913089b799d8cd150c7f04c902f4a5b8eab2"

SCROLLBACK_FILENAME="scrollback.diff"
SCROLLBACK_URL="https://st.suckless.org/patches/scrollback/st-scrollback-$VERSION.diff"
SCROLLBACK_CHECKSUM="9c5aedce2ff191437bdb78aa70894c3c91a47e1be48465286f42d046677fd166"

SCROLLBACK_MOUSE_FILENAME="scrollback-mouse.diff"
SCROLLBACK_MOUSE_URL="https://st.suckless.org/patches/scrollback/st-scrollback-mouse-$VERSION.diff"
SCROLLBACK_MOUSE_CHECKSUM="6103a650f62b5d07672eee9e01e3f4062525083da6ba063e139ca7d9fd58a1ba"

SCROLLBACK_MOUSE_ALTSCREEN_FILENAME="scrollback-mouse-altscreen.diff"
SCROLLBACK_MOUSE_ALTSCREEN_URL="https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-0.8.diff"
SCROLLBACK_MOUSE_ALTSCREEN_CHECKSUM="bcfc106089d9eb75aa014d4915ed3e6842f1df54edd8b75597154096333df6fa"

mkdir -p $BUILD_DIR

echo "Working in $BUILD_DIR"
pushd $BUILD_DIR

curl $SRC_URL --output $SRC_FILENAME
checksum $SRC_CHECKSUM $SRC_FILENAME

curl $BOLD_IS_NOT_BRIGHT_URL --output $BOLD_IS_NOT_BRIGHT_FILENAME
checksum $BOLD_IS_NOT_BRIGHT_CHECKSUM $BOLD_IS_NOT_BRIGHT_FILENAME

curl $SCROLLBACK_URL --output $SCROLLBACK_FILENAME
checksum $SCROLLBACK_CHECKSUM $SCROLLBACK_FILENAME

curl $SCROLLBACK_MOUSE_URL --output $SCROLLBACK_MOUSE_FILENAME
checksum $SCROLLBACK_MOUSE_CHECKSUM $SCROLLBACK_MOUSE_FILENAME

curl $SCROLLBACK_MOUSE_ALTSCREEN_URL --output $SCROLLBACK_MOUSE_ALTSCREEN_FILENAME
checksum $SCROLLBACK_MOUSE_ALTSCREEN_CHECKSUM $SCROLLBACK_MOUSE_ALTSCREEN_FILENAME

tar xvzf $SRC_FILENAME
patch -d $SRC_DIR -p1 < $BOLD_IS_NOT_BRIGHT_FILENAME
patch -d $SRC_DIR -p1 < $SCROLLBACK_FILENAME
patch -d $SRC_DIR -p1 < $SCROLLBACK_MOUSE_FILENAME
patch -d $SRC_DIR -p1 < $SCROLLBACK_MOUSE_ALTSCREEN_FILENAME
patch -d $SRC_DIR -p1 < $ST_DIR/usercflags.diff
patch -d $SRC_DIR -p1 < $ST_DIR/local.diff
ln -sf $CONFIG $(pwd)/$SRC_DIR
