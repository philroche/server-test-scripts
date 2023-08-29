#!/bin/bash -eux

before_kernel_change_before_seed_change="5dff05039403" # "20230618-before-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-5dff05039403"
after_kernel_change_before_seed_change="791da36b573c" # "20230824-after-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-791da36b573c"
after_kernel_change_after_seed_change="f93870221eb8" # "20230821.1-after-kernel-change-after-seed-change-mantic-minimal-cloudimg-amd64-data-f93870221eb8"

stats_directories=("${before_kernel_change_before_seed_change}" "${after_kernel_change_before_seed_change}" "${after_kernel_change_after_seed_change}")
# for each of the stats directories we want to create process only lists to make it easier to diff
for stats_directory in "${stats_directories[@]}"; do
    # From the list of files in the stats directory we want file that starts with string "results-processcount" and ends with string "early" using regex
    processcount_early_filename=$(ls -1 --all ${stats_directory} | grep --regexp="^results-processcount.*-early.txt")
    # Extract the process names from the file and sort them
    awk '{print $4}' ${stats_directory}/${processcount_early_filename} | sort > "${stats_directory}/process-names-only-sorted-${processcount_early_filename}"

    # From the list of files in the stats directory we want file that starts with string "results-packages" and ends with string "early" using regex
    packages_early_filename=$(ls -1 --all ${stats_directory} | grep --regexp="^results-packages-.*-early.txt")
    # Extract the package names from the file and sort them
    awk '$1 == "ii" {print $2}' ${stats_directory}/${packages_early_filename} | sort > "${stats_directory}/packages-names-only-sorted-${packages_early_filename}"

    # From the list of files in the stats directory we want file that starts with string "results-services" and ends with string "early" using regex
    services_early_filename=$(ls -1 --all ${stats_directory} | grep --regexp="^results-services-.*-early.txt")
    # Extract the service names from the file and sort them
    awk '{print $1}' ${stats_directory}/${services_early_filename} | sort > "${stats_directory}/service-names-only-sorted-${services_early_filename}"

    # From the list of files in the stats directory we want file that starts with string "results-timers" and ends with string "early" using regex
    timers_early_filename=$(ls -1 --all ${stats_directory} | grep --regexp="^results-timers-.*-early.txt")
    # Extract the timer names from the file and sort them
    awk '{print $1}' ${stats_directory}/${timers_early_filename} | sort > "${stats_directory}/timer-names-only-sorted-${timers_early_filename}"

    # From the list of files in the stats directory we want file that starts with string "results-kernelmodules" and ends with string "early" using regex
    kernelmodules_early_filename=$(ls -1 --all ${stats_directory} | grep --regexp="^results-kernelmodules-.*-early.txt")
    # Extract the module names from the file and sort them
    tail --lines=+2 ${stats_directory}/${kernelmodules_early_filename} | awk '{print $1}'  | sort > "${stats_directory}/kernelmodules-names-only-sorted-${kernelmodules_early_filename}"
done
# Create process only lists from al three images
#awk '{print $4}' 20230618-before-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-5dff05039403/results-processcount-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-25T16:13:28Z-early.txt | sort > 20230618-before-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-5dff05039403/results-processcount-process-names-only-sorted-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-25T16:13:28Z-early.txt
#awk '{print $4}' 20230824-after-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-791da36b573c/results-processcount-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-24T17:13:35Z-early.txt | sort > 20230824-after-kernel-change-before-seed-change-mantic-minimal-cloudimg-amd64-data-791da36b573c/results-processcount-process-names-only-sorted-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-24T17:13:35Z-early.txt
#awk '{print $4}' 20230821.1-after-kernel-change-after-seed-change-mantic-minimal-cloudimg-amd64-data-f93870221eb8/results-processcount-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-25T16:39:30Z-early.txt | sort > 20230821.1-after-kernel-change-after-seed-change-mantic-minimal-cloudimg-amd64-data-f93870221eb8/results-processcount-process-names-only-sorted-26b6c9bfb8aa40cf8edd36aa3cd51307-mantic-vm-c1-m1-2023-08-25T16:39:30Z-early.txt
