#!/usr/bin/env bash

display_usage() {
  echo "Usage: permit <spender> <nonce> <amount> [deadline]"
}

if [ $# -lt 3 ];  then
    display_usage
    exit 1
fi

if [ -z ${ETH_FROM+x} ]; then
    echo "ETH_FROM must be set";
    exit 1
fi

DOMAIN_SEPARATOR=$("${0%/*}/domain_separator")
# permit type data
PERMIT_TYPEHASH=$(seth keccak $(seth --from-ascii "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"))

# permit data
OWNER=$ETH_FROM
SPENDER=$1
NONCE=$2
VALUE=$3
DEADLINE=${4:-$(seth --to-int256 -1)}

echo "OWNER $OWNER"
echo "SPENDER $SPENDER"
echo "NONCE $NONCE"
echo "VALUE $VALUE"
echo "DEADLINE $DEADLINE"

MESSAGE=0x1901\
$(echo $DOMAIN_SEPARATOR\
$(seth keccak \
$PERMIT_TYPEHASH\
$(echo $(seth --to-uint256 $OWNER)\
$(seth --to-uint256 $SPENDER)\
$(seth --to-uint256 $VALUE)\
$(seth --to-uint256 $NONCE)\
$(seth --to-uint256 $DEADLINE)\
      | sed 's/0x//g')) \
      | sed 's/0x//g')

SIG=$(ethsign msg --passphrase-file $ETH_PASSWORD --no-prefix --data $MESSAGE)
echo "SIG $SIG"

printf '{"permit": {"owner":"%s","spender":"%s","nonce":"%s", "expiry": "%s", "value": "%s", "v": "%s", "r": "%s", "s": "%s"}}\n' "$OWNER" "$SPENDER" "$NONCE" "$DEADLINE" "$VALUE" $((0x$(echo "$SIG" | cut -c 131-132))) $(echo "$SIG" | cut -c 1-66) "0x"$(echo "$SIG" | cut -c 67-130)
