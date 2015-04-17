#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/..

if [[
"${EIP}X" == "X" ||
"${ACCESS_KEY_ID}X" == "X" ||
"${SECRET_ACCESS_KEY}X" == "X" ||
"${KEY_NAME}X" == "X" ||
"${PRIVATE_KEY_PATH}X" == "X" ||
"${SECURITY_GROUP}X" == "X" ]]; then
  echo "USAGE: EIP=xxx ACCESS_KEY_ID=xxx SECRET_ACCESS_KEY=xxx KEY_NAME=xxx PRIVATE_KEY_PATH=xxx SECURITY_GROUP=xxx ./bin/make_manifest.sh"
  exit 1
fi

POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-"secret-postgres-password"}

cat >concourse.yml <<YAML
---
name: concourse

resource_pools:
- name: default
  network: default
  cloud_properties:
    instance_type: m3.medium

jobs:
- name: concourse
  instances: 1
  templates:
  - {release: concourse, name: consul-agent}
  - {release: concourse, name: atc}
  - {release: concourse, name: tsa}
  - {release: concourse, name: postgresql}
  - {release: garden-linux, name: garden}
  - {release: concourse, name: groundcrew}
  networks:
  - name: vip
    static_ips: [$EIP]
  - name: default

  properties:
    atc:
      development_mode: true
      postgresql:
        database: atc
        role:
          name: atc
          password: ${POSTGRES_PASSWORD}
    postgresql:
      databases: [{name: atc}]
      roles:
      - role:
        name: atc
        password: ${POSTGRES_PASSWORD}

    consul:
      agent:
        servers: {lan: [$EIP]}
    garden:
      # cannot enforce quotas in bosh-lite
      disk_quota_enabled: false

      listen_network: tcp
      listen_address: 0.0.0.0:7777

      allow_host_access: true

networks:
- name: default
  type: dynamic
- name: vip
  type: vip

cloud_provider:
  template: {name: cpi, release: bosh-aws-cpi}

  ssh_tunnel:
    host: $EIP
    port: 22
    user: vcap
    private_key: $PRIVATE_KEY_PATH

  registry: &registry
    username: admin
    password: admin
    port: 6901
    host: localhost

  # Tells bosh-micro how to contact remote agent
  mbus: https://nats:nats@$EIP:6868

  properties:
    aws:
      access_key_id: $ACCESS_KEY_ID
      secret_access_key: $SECRET_ACCESS_KEY
      default_key_name: $KEY_NAME
      default_security_groups: [$SECURITY_GROUP]
      region: us-east-1

    # Tells CPI how agent should listen for requests
    agent: {mbus: "https://nats:nats@0.0.0.0:6868"}

    registry: *registry

    blobstore:
      provider: local
      path: /var/vcap/micro_bosh/data/cache

    ntp: [0.north-america.pool.ntp.org]
YAML
