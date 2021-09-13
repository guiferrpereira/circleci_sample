#!/bin/sh

# get version values
VERSION=$(git describe)
SERVICE=$(git rev-parse --show-toplevel | awk -F '/' '{ print $NF }')
BRANCH=$(git rev-parse --abbrev-ref HEAD)
SHA=$(git rev-parse HEAD)
# create a JSON string with version values
BUILD_VERSION="{ \"version\": \"$VERSION\", \"service\": \"$SERVICE\", \"branch\": \"$BRANCH\", \"sha\": \"$SHA\" }"

# create and write contents of .build-version file
touch .build-version && echo ${BUILD_VERSION} > .build-version
# print contents for debugging purposes
echo ${BUILD_VERSION}
