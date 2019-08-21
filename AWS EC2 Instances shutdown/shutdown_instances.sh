#!/bin/bash

function shut_down_region()
{
        region=$1

        ids_to_stop=$(aws ec2 describe-instance-status --output text --region $region | grep INSTANCESTATUSES | awk '{ print $3 }')
        if [[ "$ids_to_stop" != "" ]]; then
                aws ec2 stop-instances --instance-ids $ids_to_stop
        fi
}

# MAIN
aws ec2 describe-regions --output text | cut -f3 | while read region; do
        echo "shutting down region $region"
        shut_down_region $region
done                    