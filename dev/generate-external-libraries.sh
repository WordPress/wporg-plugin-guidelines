#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install it and try again."
    exit 1
fi

# Check if perl is installed
if ! command -v perl > /dev/null; then
    echo "Error: perl is not installed. Please install perl to continue."
    exit 1
fi

BASE_URL="https://api.wordpress.org/core/credits/1.1/"
FORMAT="markdown"
VERSION=""
FILE=""

display_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Fetch data from the WordPress API and format the output."
    echo
    echo "Options:"
    echo "  -f, --format FORMAT  Set the output format. Available formats: markdown, comma, html. Default: markdown."
    echo "  -v, --version VER    Set the WordPress version. It will fetch data for the specified version."
    echo "  -i, --input FILE     Specify a file to replace the existing UL with the same ID as the generated one."
    echo "  -h, --help           Display this help message."
    echo
    exit 0
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--format)
            FORMAT="$2";
            shift
            ;;
        -v|--version)
            VERSION="?version=$2";
            shift
            ;;
        -i|--input)
            FILE="$2";
            shift
            ;;
        -h|--help)
            display_help
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
    shift
done

# Check for format and file compatibility
if [[ ! -z "$FILE" && "$FORMAT" != "html" ]]; then
    echo "Error: When specifying a file with the -i/--input option, the format must be set to 'html'."
    exit 1
fi

# Build the full URL
FULL_URL="${BASE_URL}${VERSION}"

# Fetch the JSON from the URL
JSON_DATA=$(curl -s "$FULL_URL")

# Extract and format data based on the specified format
case "$FORMAT" in
    "markdown")
        DATA=$(echo "$JSON_DATA" | jq -r '.groups.libraries.data[] | "- [" + .[0] + "](" + .[1] + ")"')
        echo "$DATA"
        ;;
    "comma")
        DATA=$(echo "$JSON_DATA" | jq -r '[.groups.libraries.data[] | "[" + .[0] + "](" + .[1] + ")"] | join(", ")')
        echo "$DATA"
        ;;
    "html")
        DATA=$(echo "$JSON_DATA" | jq -r '.groups.libraries.data[] | "\t<li><a href=\"" + .[1] + "\" rel=\"noopener noreferrer nofollow\" target=\"_blank\">" + .[0] + "</a></li>"')
        NEW_LIST="<ul id=\"list-external-libraries\">\n$DATA\n</ul>"

        # If a file is specified, replace the existing UL with the new one
        if [[ ! -z "$FILE" ]]; then
            # Use perl to replace the ul with a given id
            perl -i -p0e "s|<ul id=\"list-external-libraries\">.*?</ul>|$NEW_LIST|gs" "$FILE"
        else
            echo "$NEW_LIST"
        fi
        ;;
    *)
        echo "Error: Invalid format. Available formats: markdown, comma, html"
        exit 1
        ;;
esac
