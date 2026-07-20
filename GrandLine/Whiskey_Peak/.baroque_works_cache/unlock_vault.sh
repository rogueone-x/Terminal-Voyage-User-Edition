#!/bin/bash

TARGET_HASH="b23dad4218492d3bcefc3cbc47b1c367d2a16852921708fee07b5b6e98068fe9"

ENCRYPTED_FLAG="U2FsdGVkX18eGXT7fCm/5zmZmejGVicPYQQLji9cigHrIyxzalWleyVW+k3X6rBlS3baMgfv0DVe24ILF5v+rw==" 

# Compute the hash of the student's input
INPUT_HASH=$(echo -n "$AWAKENING_SIGNATURE" | sha256sum | awk '{print $1}')

if [ "$INPUT_HASH" == "$TARGET_HASH" ]; then
    echo "[SIGNATURE MATCH] Devil Fruit aura detected. Bypassing proxy firewall..."
    echo "[SUCCESS] Decrypting Baroque transmission streams..."

    # Clean up any existing logs from previous run attempts
    rm -f marine_intercept.log bounty_hunter_feed.log

    # Generate identical stream text blocks
    for i in {1..100}; do
        echo "LOG_STREAM_ENTRY_SECURE_NODE_$(printf "%03d" $i)_VALID" >> "marine_intercept.log"
        echo "LOG_STREAM_ENTRY_SECURE_NODE_$(printf "%03d" $i)_VALID" >> "bounty_hunter_feed.log"
    done

    # 3. Decrypt the Level 2 flag using the student's input as the absolute password key
    # FIXED: Changed $ENCRYPTED_FLAG2 to $ENCRYPTED_FLAG to match the variable at the top
    REAL_FLAG=$(echo "$ENCRYPTED_FLAG" | openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -pass pass:"$AWAKENING_SIGNATURE" 2>/dev/null)
    
    # Inject the decrypted runtime flag into line 42
    # FIXED: Changed $REAL_FLAG to match the variable assigned by OpenSSL above
    sed -i "42s/.*/$REAL_FLAG/" bounty_hunter_feed.log

    echo "Files dropped: 'marine_intercept.log' and 'bounty_hunter_feed.log'. Run diff to compare."
else
    echo "[ACCESS DENIED] Environmental Scan Failed. System user unauthorized."
    echo "Hint: Did you export the 'AWAKENING_SIGNATURE' variable inside this session?"
fi
