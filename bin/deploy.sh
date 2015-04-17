#!/bin/bash

concourse_version=${concourse_version:-0.45.0}
garden_version=${garden_version:-0.190.0}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..

export PATH=$PATH:$PWD/bin

bosh-init deploy concourse.yml \
  assets/light-bosh-stemcell-2830-aws-xen-ubuntu-trusty-go_agent.tgz \
  assets/bosh-aws-cpi-release-5.tgz \
  assets/concourse-${concourse_version}.tgz \
  assets/garden-linux-release-${garden_version}.tgz
