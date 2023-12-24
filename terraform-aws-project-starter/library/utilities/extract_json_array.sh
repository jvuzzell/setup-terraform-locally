#!/bin/bash
extract_json_array() {
    key=$1
    config_file=$2
    grep -A 1 "\"$key\"" "$config_file" | grep -v "\"$key\"" | sed -E 's/[^"]*"([^"]+)".*/\1/g'
}