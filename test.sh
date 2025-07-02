#!/bin/bash

# n8n DomainSearch Workflow Test Script

echo "Creating test payload..."

# Create test payload JSON file
cat > test-payload.json << 'EOF'
{
  "texts": [
    "顧客管理システムでは、顧客IDを使って顧客情報を管理します。注文が作成されると注文IDが発行され、商品が配送されます。",
    "ユーザーがログインすると、セッションが開始されます。決済処理では支払い方法を選択し、決済完了イベントが発生します。"
  ]
}
EOF

echo "Sending request to n8n webhook..."

# Execute the webhook request
curl -X POST \
  http://localhost:5678/webhook/domain-search \
  -H "Content-Type: application/json" \
  -d @test-payload.json

echo ""
echo "Test completed."