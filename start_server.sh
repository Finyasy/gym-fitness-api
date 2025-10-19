#!/bin/bash
# Extreme Fitness Centre - Start Rails Server on Network
echo "🏋️  Starting Extreme Fitness Centre API Server..."
echo "📡 Server will be accessible on your network at http://192.168.0.102:3000"
echo ""
rails server -b 0.0.0.0 -p 3000
