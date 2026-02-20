#!/bin/bash
# Deploy jarvis-telegram to VPS
# Usage: ./scripts/deploy.sh
set -euo pipefail

VPS_HOST="root@100.68.120.99"
REMOTE_DIR="/opt/jarvis-telegram"
SERVICE_NAME="jarvis-telegram"

echo "=== Deploying jarvis-telegram to VPS ==="

echo "[1/3] Pulling latest code on VPS..."
ssh "$VPS_HOST" "cd $REMOTE_DIR && git pull origin main"

echo "[2/3] Installing dependencies..."
ssh "$VPS_HOST" "cd $REMOTE_DIR && pip install -r requirements.txt -q"

echo "[3/3] Restarting service..."
ssh "$VPS_HOST" "systemctl restart $SERVICE_NAME"

sleep 2
echo ""
echo "=== Verifying ==="
ssh "$VPS_HOST" "systemctl is-active $SERVICE_NAME && journalctl -u $SERVICE_NAME -n 5 --no-pager"

echo ""
echo "Deploy complete!"
