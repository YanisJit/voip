#!/bin/bash

shuf contacts.csv > contacts_melanges.csv

while IFS= read -r numero
do
  if [ -z "$numero" ]; then continue; fi

  cat <<EOF > /tmp/call_$numero.call
Channel: PJSIP/$numero
Context: from-internal
Extension: 800
Priority: 1
EOF

  mv /tmp/call_$numero.call /var/spool/asterisk/outgoing/
  sleep 15

done < contacts_melanges.csv
