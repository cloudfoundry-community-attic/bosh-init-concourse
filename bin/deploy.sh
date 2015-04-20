#!/bin/bash

# concourse_version=${concourse_version:-0.45.0}
concourse_version=${concourse_version:-0.45.0+dev.1}
garden_version=${garden_version:-0.190.0}
aws_cpi_version=${aws_cpi_version:-7}
stemcell_version=${stemcell_version:-2830}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..

export PATH=$PATH:$PWD/bin

bosh-init deploy concourse.yml \
  assets/light-bosh-stemcell-${stemcell_version}-aws-xen-ubuntu-trusty-go_agent.tgz \
  assets/bosh-aws-cpi-release-${aws_cpi_version}.tgz \
  assets/concourse-${concourse_version}.tgz \
  assets/garden-linux-release-${garden_version}.tgz
