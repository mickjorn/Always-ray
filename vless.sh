#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/Misaka-blog/AX/main/wef
chmod +x ./wef

if [[ -z $id ]]; then
    id="1eb6e917-774b-4a84-aff6-b058577c60a5"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./wef -config=config.json
