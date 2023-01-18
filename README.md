# Cloud-backup: Zip and push a backup to the cloud

Usage:

```bash
docker run \
    --rm \
    -ti \
    -v $(pwd)/testContent:/data \
    -e AZURE_STORAGE_ACCOUNT="yourstorageaccount" \
    -e AZURE_STORAGE_ACCOUNT_CONTAINER="your-container" \
    -e AZURE_STORAGE_SAS_TOKEN="your-sas-token" \
    ghcr.io/pablozaiden/cloud-backup:latest
```
