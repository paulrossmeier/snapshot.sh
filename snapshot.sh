#!/bin/bash


#get auth token
# RACKSPACE_USERNAME = your mycloud login ID
# API_KEY = API key obtained from your myrackspace account user page

key=$(curl -s https://identity.api.rackspacecloud.com/v2.0/tokens \
	-X POST  \
	-d '{"auth":{"RAX-KSKEY:apiKeyCredentials":{"username":"$RACKSPACE_USERNAME","apiKey":"$API_KEY"}}}'  \
	-H "Content-type: application/json" | python -m json.tool | grep AA)



auth=$(echo $key | tr -d '"' |  awk -F ":" '{ print $2}' | sed 's/,*$//g')

echo "Your Auth Token is "$auth

#echo "export AUTH_TOKEN=$auth"

export AUTH_TOKEN=$auth
export TITLE="Nightly-backup-"$(date +%Y%m%dT%H%M)
echo "Snapshot Name is "$TITLE

#Create Snapshot
#You will neeed for URL 
    # The region - here the block volume is in IAD
    # The Account number ACCOUNT_NUMBER = account number/DDI

curl -s https://iad.blockstorage.api.rackspacecloud.com/v1/$ACCOUNT_NUMBER/snapshots \
	-H "X-Auth-Token: $AUTH_TOKEN"  \
	-H "Content-type: application/json" \
	-X POST  \
	-d '{"snapshot": { "display_name": "'$TITLE'", "display_description": "Daily backup","volume_id": "02878c21-0197-404c-ad63-5d2bfcf77cd1","force": true}}' | python -m json.tool


# list servers
#curl -s https://iad.servers.api.rackspacecloud.com/v2/$ACCOUNT_NUMBER/servers  \
#	-H "X-Auth-Token: $AUTH_TOKEN"  \
#	-H "Content-type: application/json" | python -m json.tool



#exit 0
