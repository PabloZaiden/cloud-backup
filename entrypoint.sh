#!/usr/bin/env bash

set -e

# function that validates that a variable is set
function validate_is_set {
    if [ -z "$1" ]; then
        echo "ERROR: $2 is not set"
        exit 1
    fi
}

# validate that all required variables are set
validate_is_set "$AZURE_STORAGE_ACCOUNT" "AZURE_STORAGE_ACCOUNT"
validate_is_set "$AZURE_STORAGE_ACCOUNT_CONTAINER" "AZURE_STORAGE_ACCOUNT_CONTAINER"
validate_is_set "$AZURE_STORAGE_SAS_TOKEN" "AZURE_STORAGE_SAS_TOKEN"

# get yyyy-mm-dd-hh-mm-ss date
currentDate=$(date +%Y-%m-%d-%H-%M-%S)
zipFileName="backup-$currentDate.zip"


echo "Zipping files recursively in /data..."
# Some files might not be accessible while in use. Live with it.
# Ignore warnings while zipping. 
set +e
zip -r "/$zipFileName" /data
set -e

echo "Uploading zip file to Azure Storage with azcopy..."
azcopy copy "/$zipFileName" "https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/$AZURE_STORAGE_ACCOUNT_CONTAINER/$zipFileName?$AZURE_STORAGE_SAS_TOKEN"

echo "Cleaning up..."
rm "/$zipFileName"

echo "Done!"