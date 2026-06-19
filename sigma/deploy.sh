#!/usr/bin/env bash
set -euo pipefail

if ! command -v firebase >/dev/null 2>&1; then
  echo "Firebase CLI not found. Install it with: npm install -g firebase-tools"
  exit 1
fi

echo "Deploying to Firebase Hosting..."
firebase deploy --only hosting
echo "Done."
