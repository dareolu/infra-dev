#!/usr/bin/env bash

provisioning_dir='/opt/infra'

mkdir -p $${provisioning_dir}/bin
aws s3 cp s3://${bucket}/bootstrap/bs $${provisioning_dir}/bin/bs
chmod 755 $${provisioning_dir}/bin/bs

$${provisioning_dir}/bin/bs
