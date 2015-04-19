bosh-init deploy concourse
==========================

The new [bosh-init](https://github.com/cloudfoundry/bosh-init) CLI can do more than just deploy Micro BOSH.

This project will deploy a single server/VM/instance on AWS EC2 us-east-1 region running [Concourse](http://concourse.ci) server.[![concourse-example](http://cl.ly/image/0W090F1H0a0y/concourse-example.png)](http://concourse.ci)

It is using the new `bosh-init` CLI to deploy concourse's BOSH release.

Usage
-----

First, fetch the required assets, including the `bosh-init` CLI:

```
./bin/fetch_assets.sh
```

Then create the `concourse.yml` manifest:

```
EIP=23.23.23.23 \
ACCESS_KEY_ID=xxx SECRET_ACCESS_KEY=xxx \
KEY_NAME=xxx PRIVATE_KEY_PATH=xxx \
SECURITY_GROUP=xxx \
./bin/make_manifest.sh
```

Finally, run the `bosh-init deploy` command (via helpful wrapper):

```
./bin/deploy.sh
```

The output will look similar to:

```
Deployment manifest: '/Users/drnic/Projects/bosh-deployments/experiments/bosh-init-concourse/concourse.yml'
Deployment state: 'deployment.json'

Started validating
  Validating stemcell... Finished (00:00:00)
  Validating releases... Finished (00:00:01)
  Validating deployment manifest... Finished (00:00:00)
  Validating cpi release... Finished (00:00:00)
Finished validating (00:00:01)

Started installing CPI
  Compiling package 'ruby_aws_cpi/052a28b8976e6d9ad14d3eaec6d3dd237973d800'... Finished (00:00:00)
  Compiling package 'bosh_aws_cpi/deabbf731a4fedc9285324d85af6456cfa74c10c'... Finished (00:00:00)
  Rendering job templates... Finished (00:00:00)
  Installing packages... Finished (00:00:03)
  Installing job 'cpi'... Finished (00:00:00)
Finished installing CPI (00:00:03)

Starting registry... Finished (00:00:00)
Uploading stemcell 'bosh-aws-xen-ubuntu-trusty-go_agent/2830'... Skipped [Stemcell already uploaded] (00:00:00)

Started deploying
  Waiting for the agent on VM 'i-e1e1691c'... Finished (00:00:00)
  Stopping jobs on instance 'unknown/0'... Finished (00:00:00)
  Unmounting disk 'vol-5877034e'... Finished (00:00:00)
  Deleting VM 'i-e1e1691c'... Finished (00:00:45)
  Creating VM for instance 'concourse/0' from stemcell 'ami-94c187fc light'... Finished (00:00:44)
  Waiting for the agent on VM 'i-1a8a02e7' to be ready... Finished (00:02:07)
  Attaching disk 'vol-5877034e' to VM 'i-1a8a02e7'... Finished (00:00:20)
  Rendering job templates... Finished (00:00:02)
  Compiling package 'git_resource/307081e19475aa38d97b994a953b06edcb8f6629'... Finished (00:00:51)
  Compiling package 's3_resource/cf2608190a1fc0fc20fe052a748b958121b08e9d'... Finished (00:00:44)
  Compiling package 'bosh_io_stemcell_resource/27625ff4c39126a3286d4657abcde5955f1e6f94'... Finished (00:00:42)
  Compiling package 'pid_utils/cabae2f94be9125fc7f444e2331fe714c079ee1e'... Finished (00:00:00)
  Compiling package 'archive_resource/bc7ff96aa16e972303917b2e6ea4e66aab5a9190'... Finished (00:00:15)
  Compiling package 'time_resource/62013ba59dabc6f0f3ca66a1dc18d4b91b4631aa'... Finished (00:00:19)
  Compiling package 'vagrant_cloud_resource/158236da0390451b2ad4fba64ac7fffe04b0b328'... Finished (00:00:43)
  Compiling package 'golang_1.3/e4b65bcb478d9bea1f9c92042346539713551a4a'... Finished (00:04:19)
  Compiling package 'generated_worker_key/00b5b02050bc6588cdfe9e523b2ba24a6c9de3c7'... Finished (00:00:01)
  Compiling package 'cf_resource/ac5db9d4fe9321bc86b3c72bde0215abda7c3a12'... Finished (00:01:12)
  Compiling package 'docker_image_resource/2f3685be1e2775ca8ca8d2bede194129da908c9b'... Finished (00:00:43)
  Compiling package 'bosh_deployment_resource/86c173a276e78a3f8b7458ed275bd53596b313ac'... Finished (00:01:58)
  Compiling package 'bosh_io_release_resource/963ee9cd703fbf35302278c789d3311799d9617a'... Finished (00:00:43)
  Compiling package 'postgresql_9.3/f30f3a88010d8a158a23a3927be0b339f36caec0'... Finished (00:05:48)
  Compiling package 'iptables/7226d311e90f49b05287e79f339581a1de9ea82e'... Finished (00:00:34)
  Compiling package 'busybox/1593c41beb57c12d7f2b82dff61b47d4d119913d'... Finished (00:00:08)
  Compiling package 'generated_tsa_host_key/00b5b02050bc6588cdfe9e523b2ba24a6c9de3c7'... Finished (00:00:01)
  Compiling package 'semver_resource/1707ec45b97a8b9044ba24ca661f6d4fb89dcc16'... Finished (00:00:46)
  Compiling package 'shadow/ffd1741bd9e0a176e67c61ef70cd0ed76b0ec285'... Finished (00:01:01)
  Compiling package 'golang/25b17958ab3f23231ddfe6bc2d15a8d20a96dcab'... Finished (00:03:07)
  Compiling package 'github_release_resource/be1cd5002e9c6a89f674692af322637133b94ac6'... Finished (00:00:47)
  Compiling package 'tracker_resource/7f6425c98c8bd70f58b114389d1b1713fa8acb4a'... Finished (00:00:51)
  Compiling package 'fly/825f3dff803b483000e3e1aaa4393769e58a3b38'... Finished (00:00:33)
  Compiling package 'tsa/8227aec6190cd772ff1fa89379591f756008b10d'... Finished (00:00:08)
  Compiling package 'jettison/4a817196be08812069696aaef01afb0620a6f7f3'... Finished (00:00:06)
  Compiling package 'atc/56e43783669796147d37343ae0f3aaf9523aed6a'... Finished (00:00:20)
  Compiling package 'garden-linux/8d2d9a739460b07ca7d21c5a46407ffc0bedaf81'... Finished (00:00:24)
  Updating instance 'concourse/0'... Finished (00:00:19)
  Waiting for instance 'concourse/0' to be running... Finished (00:00:05)
Finished deploying (00:31:55)
```

Security Group
--------------

The security group must open the following ports to the machine running `./bin/deploy.sh` or `bosh-init deploy`:

-	22
-	6868

The security group must open the following port for the `fly` client and web browser to access the ATC service:

-	8080

Dependencies
------------

On Ubuntu, the following packages are required in order for the `bosh-aws-cpi` to compile Ruby successfully:

```
sudo apt-get install -y build-essential zlibc zlib1g-dev \
  openssl libxslt-dev libxml2-dev libssl-dev \
  libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3
```

I don't know what the matching requirements are for OS X anymore. That would require buying a new Mac. Wait... let me ask my wife.
