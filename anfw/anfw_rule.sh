#!/bin/bash

# Variables
REGION="ap-northeast-2"
ACTION=$1
SID=$2

# Function to display usage
show_usage() {
    echo "Usage: $0 --name <rule-group-name> [--add | --delete] <sid> [protocol] [source] [destination] [destination_port] [direction] [action] [message]"
    echo
    echo "Options:"
    echo "  --add     Add a new rule with the specified SID"
    echo "  --delete  Delete an existing rule with the specified SID"
    echo
    echo "Arguments for --name:"
    echo "  rule-group-name   The name of the rule group to modify"
    echo
    echo "Arguments for --add:"
    echo "  sid              The SID of the rule to add"
    echo "  protocol         The protocol for the rule (e.g., TCP, UDP, ICMP)"
    echo "  source           The source for the rule (e.g., ANY)"
    echo "  destination      The destination for the rule (e.g., ANY)"
    echo "  destination_port The destination port for the rule (e.g., 8080)"
    echo "  direction        The direction for the rule (e.g., FORWARD, ANY)"
    echo "  action           The action for the rule (e.g., ALERT, PASS, DROP, REJECT)"
    echo "  message          The alert message associated with the rule"
    echo
    echo "Example to add a rule:"
    echo "$0 --name <rule-group-name> --add 5 TCP ANY ANY 8080 ANY ALERT '8080번 포트로 향하는 모든 TCP 트래픽에 대한 경고.'"
    echo
    echo "Example to delete a rule:"
    echo "$0 --name <rule-group-name> --delete 5"
    exit 1
}

# Ensure the --name option is provided
if [ "$1" != "--name" ] || [ -z "$2" ]; then
    show_usage
fi

RULE_GROUP_NAME=$2
ACTION=$3
SID=$4

# Check for sufficient arguments
if [ "$ACTION" == "--add" ]; then
    if [ "$#" -ne 11 ]; then
        show_usage
    fi
elif [ "$ACTION" == "--delete" ]; then
    if [ "$#" -ne 5 ]; then
        show_usage
    fi
else
    show_usage
fi

# Temporary file to store the current rule group JSON
TEMP_FILE="rule-group.json"
UPDATED_FILE="updated-rule-group.json"

# Retrieve the current rule group configuration
aws network-firewall describe-rule-group \
  --region "$REGION" \
  --rule-group-name "$RULE_GROUP_NAME" \
  --type STATEFUL \
  --query "RuleGroup" \
  --output json > $TEMP_FILE

# Perform the add or delete action based on the input parameter
if [ "$ACTION" == "--add" ]; then
    PROTOCOL=$5
    SOURCE=$6
    DESTINATION=$7
    DEST_PORT=$8
    DIRECTION=$9
    RULE_ACTION=${10}
    MSG=${11}

    # Validate Protocol
    VALID_PROTOCOLS=("TCP" "UDP" "ICMP" "IP" "FTP" "MSN" "SSH" "SMB" "HTTP" "DNS" "NTP" "TFTP" "DHCP" "IMAP" "SMTP" "KRB5" "TLS" "IKEV2" "DCERPC")
    if [[ ! " ${VALID_PROTOCOLS[@]} " =~ " ${PROTOCOL} " ]]; then
        echo "Error: Invalid protocol '$PROTOCOL'. Valid protocols are: ${VALID_PROTOCOLS[*]}"
        exit 1
    fi

    # Validate Direction
    VALID_DIRECTIONS=("FORWARD" "ANY")
    if [[ ! " ${VALID_DIRECTIONS[@]} " =~ " ${DIRECTION} " ]]; then
        echo "Error: Invalid direction '$DIRECTION'. Valid directions are: ${VALID_DIRECTIONS[*]}"
        exit 1
    fi

    # Validate Action
    VALID_ACTIONS=("ALERT" "PASS" "DROP" "REJECT")
    if [[ ! " ${VALID_ACTIONS[@]} " =~ " ${RULE_ACTION} " ]]; then
        echo "Error: Invalid action '$RULE_ACTION'. Valid actions are: ${VALID_ACTIONS[*]}"
        exit 1
    fi

    # Check if the SID already exists
    EXISTING_SID=$(jq --arg sid "$SID" '.RulesSource.StatefulRules[] | select(.RuleOptions[] | select(.Keyword == "sid") | .Settings[0] == $sid)' $TEMP_FILE)

    if [ -n "$EXISTING_SID" ]; then
        echo "Error: SID $SID already exists in the rule group $RULE_GROUP_NAME."
        rm $TEMP_FILE
        exit 1
    fi

    # Construct the new rule JSON block, ensuring the message is properly quoted
    NEW_RULE=$(cat <<EOF
{
  "Action": "$RULE_ACTION",
  "Header": {
    "Protocol": "$PROTOCOL",
    "Source": "$SOURCE",
    "SourcePort": "ANY",
    "Direction": "$DIRECTION",
    "Destination": "$DESTINATION",
    "DestinationPort": "$DEST_PORT"
  },
  "RuleOptions": [
    {
      "Keyword": "sid",
      "Settings": ["$SID"]
    },
    {
      "Keyword": "msg",
      "Settings": ["\"$MSG\""]
    }
  ]
}
EOF
    )

    # Insert the new rule into the existing rules
    jq --argjson newRule "$NEW_RULE" '.RulesSource.StatefulRules += [$newRule]' $TEMP_FILE > $UPDATED_FILE

    echo "The rule with SID $SID has been successfully added to the rule group $RULE_GROUP_NAME."

elif [ "$ACTION" == "--delete" ]; then
    # Remove the rule with the specified SID
    jq --arg sid "$SID" 'del(.RulesSource.StatefulRules[] | select(.RuleOptions[] | select(.Keyword == "sid") | .Settings[0] == $sid))' $TEMP_FILE > $UPDATED_FILE

    echo "The rule with SID $SID has been successfully deleted from the rule group $RULE_GROUP_NAME."
fi

# Retrieve the UpdateToken
UPDATE_TOKEN=$(aws network-firewall describe-rule-group \
  --region "$REGION" \
  --rule-group-name "$RULE_GROUP_NAME" \
  --type STATEFUL \
  --query 'UpdateToken' \
  --output text)

# Update the rule group with the modified rules
aws network-firewall update-rule-group \
  --region "$REGION" \
  --rule-group-name "$RULE_GROUP_NAME" \
  --type STATEFUL \
  --rule-group file://$UPDATED_FILE \
  --update-token $UPDATE_TOKEN

# Cleanup
rm $TEMP_FILE $UPDATED_FILE
