#!/bin/bash -eux

before_kernel_change_before_seed_change_image_id="5dff05039403" # "5dff05039403"
after_kernel_change_before_seed_change_image_id="791da36b573c" # "791da36b573c"
after_kernel_change_after_seed_change_image_id="f93870221eb8" # "f93870221eb8"

lxd_images_ids=("${before_kernel_change_before_seed_change_image_id}" "${after_kernel_change_before_seed_change_image_id}" "${after_kernel_change_after_seed_change_image_id}")

for lxd_image_id in "${lxd_images_ids[@]}"; do
    mkdir --parents --verbose "${lxd_image_id}"
    pushd "${lxd_image_id}"
    WHAT="vm" RELEASE="mantic" LXD_IMAGE_NAME="${lxd_image_id}" ../metric-server-simple.sh
    popd
done
