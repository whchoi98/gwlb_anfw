#!/bin/bash

# Check if --name option is provided
if [ "$#" -ne 2 ] || [ "$1" != "--name" ]; then
    echo "Usage: $0 --name <rule-group-name>"
    exit 1
fi

RULE_GROUP_NAME=$2

# Execute the AWS CLI command with jq processing
aws network-firewall describe-rule-group \
  --region ap-northeast-2 \
  --rule-group-name "$RULE_GROUP_NAME" \
  --type STATEFUL \
  --query "RuleGroup.RulesSource.StatefulRules[*]" \
  --output json | jq -r '
  (
    ["SID", "Action", "Destination", "DestinationPort", "Direction", "Protocol", "Source", "SourcePort"],
    ["---", "------", "-----------", "---------------", "---------", "--------", "------", "----------"]
  ), (
    .[] |
    [
      (.RuleOptions[] | select(.Keyword == "sid") | .Settings[0]),
      .Action,
      .Header.Destination,
      .Header.DestinationPort,
      .Header.Direction,
      .Header.Protocol,
      .Header.Source,
      .Header.SourcePort
    ]
  ) | @tsv' | column -t
