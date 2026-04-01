#!/bin/bash

echo "🚀 Starting Auto Git Push..."

# add file
git add .

# commit
git commit -m "auto update $(date)"

# push
git push origin main

echo "✅ Push Complete!"

