#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -e

# Setting up $HOME
cp /root/.bashrc $HOME/.bashrc
ln -sf /root/.rustup ~/.rustup
ln -sf /root/.cargo ~/.cargo

## workaround permission issue
git config --global --add safe.directory /__w/incubator-teaclave/incubator-teaclave

# Build
. /opt/sgxsdk/environment && . ~/.cargo/env && \
mkdir -p build && pushd build && \
cmake -DCMAKE_BUILD_TYPE=Debug -DSGX_SIM_MODE=ON -DTEST_MODE=ON .. && \
VERBOSE=1 make -j && rm -rf target
