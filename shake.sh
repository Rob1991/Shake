#!/bin/bash

LOGIN_URL="https://www.telecomarmenia.am/api/hy/login?applicationId=3C9DAF7B-E9A8-459C-B6E3-08848FA3548A&applicationVersion=8.16.0&deviceScale=3&deviceType=iPhone&osVersion=26.2.1&versionNumber=312"

SHAKE_URL="https://www.telecomarmenia.am/api/hy/shake?applicationId=3C9DAF7B-E9A8-459C-B6E3-08848FA3548A&applicationVersion=8.17.0&deviceScale=3&deviceType=iPhone&osVersion=26.2.1&versionNumber=330"


# ------------------------
# LOGIN REQUEST
# ------------------------
LOGIN_RESPONSE=$(curl -s -X POST "$LOGIN_URL" \
  -H "Content-Type: application/json" \
  -d "{
    \"username\": \"$USERNAME\",
    \"password\": \"$PASSWORD\"
  }"
)

echo "Login Response:"
echo "$LOGIN_RESPONSE"


# ------------------------
# EXTRACT TOKEN
# ------------------------
TOKEN=$(echo "$LOGIN_RESPONSE" | grep -oP '"accessToken"\s*:\s*"\K[^"]+')

if [ "$TOKEN" == "null" ]; then
  echo "❌ Login failed. No token found."
  exit 1
fi

echo "Token:"
echo "$TOKEN"


# ------------------------
# SECOND REQUEST
# ------------------------
curl -X GET "$SHAKE_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: */*" \
  -H "User-Agent: MyTeam/8.17.0"