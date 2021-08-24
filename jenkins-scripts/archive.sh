#!/bin/bash

# get the branch name (without 'origin/')
IFS='/' read -r -a BRANCH_NAME <<< "$GIT_BRANCH"
# create a directory named after this build
mkdir "${JOB_BASE_NAME}-${BRANCH_NAME[1]}-build-${BUILD_ID}"

# move staging and production ito the newly created directory
mv "build-${BUILD_ID}-staging" "${JOB_BASE_NAME}-${BRANCH_NAME[1]}-build-${BUILD_ID}/build-${BUILD_ID}-staging"
mv "build-${BUILD_ID}-production" "${JOB_BASE_NAME}-${BRANCH_NAME[1]}-build-${BUILD_ID}/build-${BUILD_ID}-production"

# compress the build directory
tar -czvf "${JOB_BASE_NAME}-${BRANCH_NAME[1]}-build-${BUILD_ID}.tar.gz" "${JOB_BASE_NAME}-${BRANCH_NAME[1]}-build-${BUILD_ID}" 