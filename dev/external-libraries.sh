#!/bin/bash

# Define colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Header
echo -e "${YELLOW}=================================================${RESET}"
echo -e "${YELLOW} WordPress API External Libraries Fetcher Script ${RESET}"
echo -e "${YELLOW}=================================================${RESET}"
echo

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is not installed. Please install it and try again.${RESET}"
    exit 1
fi

# Check if perl is installed
if ! command -v perl > /dev/null; then
    echo -e "${RED}Error: perl is not installed. Please install perl to continue.${RESET}"
    exit 1
fi

BASE_URL="https://api.wordpress.org/core/credits/1.1/"
FORMAT="markdown"
VERSION=""
VERSION_URL=""
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
            echo -e "${GREEN}Setting output format to: $FORMAT${RESET}"
            shift
            ;;
        -v|--version)
            VERSION="$2";
            VERSION_URL="?version=$VERSION"
            echo -e "${GREEN}Setting WordPress version to: $VERSION${RESET}"
            shift
            ;;
        -i|--input)
            FILE="$2";
            echo -e "${GREEN}Setting input file to: $FILE${RESET}"
            shift
            ;;
        -h|--help)
            display_help
            ;;
        *)
            echo -e "${RED}Unknown parameter: $1${RESET}"
            exit 1
            ;;
    esac
    shift
done

# Check for format and file compatibility
if [[ ! -z "$FILE" && "$FORMAT" != "html" ]]; then
    echo -e "${RED}Error: When specifying a file with the -i/--input option, the format must be set to 'html'.${RESET}"
    exit 1
fi

# Build the full URL
FULL_URL="${BASE_URL}${VERSION_URL}"
echo -e "${GREEN}Built full URL: $FULL_URL${RESET}"

# Fetch the JSON from the URL
JSON_DATA=$(curl -s "$FULL_URL")
CURL_EXIT_STATUS=$?

if [[ $CURL_EXIT_STATUS -ne 0 ]]; then
    echo -e "${RED}Error: Failed to fetch data from the URL. CURL Exit Status: $CURL_EXIT_STATUS${RESET}"
    exit 1
else
    echo -e "${GREEN}Successfully fetched data from the URL.${RESET}"
fi

# Check if JSON data is empty
if [[ -z "$JSON_DATA" ]]; then
    echo -e "${RED}Error: Received empty data from the URL.${RESET}"
    exit 1
fi

# Extract and format data based on the specified format
echo -e "${GREEN}Extracting and formatting data...${RESET}"
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

            if [[ ! -z "$VERSION" ]]; then
              perl -i -p0e "s|\*\*.*? of WordPress\*\*|\*\*$VERSION of WordPress\*\*|gs" "$FILE"
            fi
        else
            echo "$NEW_LIST"
        fi
        ;;
    *)
        echo -e "${RED}Error: Invalid format. Available formats: markdown, comma, html.${RESET}"
        exit 1
        ;;
esac

# End message
echo -e "${YELLOW}Script execution completed.${RESET}"
