#!/bin/bash
# Script to test and deploy a new version of Personal Blocklist.

UNPACKED_DIR=/tmp/pbl
DEPLOY_ZIP=/tmp/chrome-ext.zip

# Build blocklist. This pulls in jquery from third_party and jsapi from
# google.com
blaze build spam/browsertools/chrome_extensions/personal_blocklist/...

# Deference the symlinks. This is required for local testing, because Chrome
# doesn't like symlinks in unpacked extensions. See http://crbug.com/27185
rsync -rtL --delete blaze-bin/spam/browsertools/chrome_extensions/personal_blocklist/deploy_files/ $UNPACKED_DIR

# Finally, zip the extension for possible deployment.
zip -rq $DEPLOY_ZIP $UNPACKED_DIR

echo "Unpacked extension: $UNPACKED_DIR"
echo "Deployment ZIP: $DEPLOY_ZIP"
