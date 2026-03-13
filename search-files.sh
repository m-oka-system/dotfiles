#!/bin/bash

# search-files.sh - Search for keywords in files with specific extensions
# Usage: ./scripts/search-files.sh <directory> <file_pattern> <keyword> [options]
#
# Options:
#   -l    Show matching file names only
#   -i    Case-insensitive search
#
# Examples:
#   ./scripts/search-files.sh ./infra "*.tf" "azurerm_private_dns_resolver"
#   ./scripts/search-files.sh ./infra "*.tf" "azurerm" -l
#   ./scripts/search-files.sh ./infra "*.tf" "AZURERM" -i

# Colors (same style as tflint-all.sh)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 <directory> <file_pattern> <keyword> [options]"
    echo ""
    echo "Arguments:"
    echo "  directory      Directory to search in"
    echo "  file_pattern   File glob pattern (e.g. \"*.tf\", \"*.py\")"
    echo "  keyword        Search keyword or regex pattern"
    echo ""
    echo "Options:"
    echo "  -l    Show matching file names only"
    echo "  -i    Case-insensitive search"
    echo ""
    echo "Examples:"
    echo "  $0 ./infra \"*.tf\" \"azurerm_private_dns_resolver\""
    echo "  $0 ./infra \"*.tf\" \"azurerm\" -l"
    echo "  $0 ./infra \"*.tf\" \"AZURERM\" -i"
    exit 1
}

# Validate required arguments
if [ $# -lt 3 ]; then
    echo -e "${RED}❌ Error: 3 required arguments missing${NC}"
    echo ""
    usage
fi

SEARCH_DIR="$1"
FILE_PATTERN="$2"
KEYWORD="$3"
shift 3

# Parse options
FILES_ONLY=false
IGNORE_CASE=false

while [ $# -gt 0 ]; do
    case "$1" in
        -l) FILES_ONLY=true ;;
        -i) IGNORE_CASE=true ;;
        *)
            echo -e "${RED}❌ Error: Unknown option '$1'${NC}"
            echo ""
            usage
            ;;
    esac
    shift
done

# Validate directory
if [ ! -d "$SEARCH_DIR" ]; then
    echo -e "${RED}❌ Error: Directory not found: ${SEARCH_DIR}${NC}"
    exit 1
fi

echo -e "🔍 Searching in ${CYAN}${SEARCH_DIR}${NC} for ${CYAN}${FILE_PATTERN}${NC} containing ${CYAN}${KEYWORD}${NC}"
echo ""

# Build search command and execute
if command -v rg &> /dev/null; then
    # Use ripgrep (fastest)
    RG_OPTS=(--color always --glob "$FILE_PATTERN")
    if [ "$FILES_ONLY" = true ]; then
        RG_OPTS+=(--files-with-matches)
    else
        RG_OPTS+=(--line-number)
    fi
    if [ "$IGNORE_CASE" = true ]; then
        RG_OPTS+=(--ignore-case)
    fi

    OUTPUT=$(rg "${RG_OPTS[@]}" "$KEYWORD" "$SEARCH_DIR" 2>/dev/null)
    EXIT_CODE=$?

    # Count matches
    if [ "$FILES_ONLY" = true ]; then
        if [ -n "$OUTPUT" ]; then
            MATCH_COUNT=$(echo "$OUTPUT" | grep -c .)
        else
            MATCH_COUNT=0
        fi
    else
        RG_COUNT_OPTS=(--color never --glob "$FILE_PATTERN" --count)
        if [ "$IGNORE_CASE" = true ]; then
            RG_COUNT_OPTS+=(--ignore-case)
        fi
        MATCH_COUNT=$(rg "${RG_COUNT_OPTS[@]}" "$KEYWORD" "$SEARCH_DIR" 2>/dev/null | awk -F: '{s+=$NF} END {print s+0}')
    fi
else
    # Fallback to grep
    echo -e "${YELLOW}⚠️  ripgrep (rg) not found, using grep fallback${NC}"
    echo ""

    GREP_OPTS=(-rn --include="$FILE_PATTERN" --color=always)
    if [ "$FILES_ONLY" = true ]; then
        GREP_OPTS=(-rl --include="$FILE_PATTERN" --color=always)
    fi
    if [ "$IGNORE_CASE" = true ]; then
        GREP_OPTS+=(-i)
    fi

    OUTPUT=$(grep "${GREP_OPTS[@]}" "$KEYWORD" "$SEARCH_DIR" 2>/dev/null)
    EXIT_CODE=$?

    # Count matches
    GREP_COUNT_OPTS=(--include="$FILE_PATTERN" --color=never)
    if [ "$IGNORE_CASE" = true ]; then
        GREP_COUNT_OPTS+=(-i)
    fi

    if [ "$FILES_ONLY" = true ]; then
        MATCH_COUNT=$(grep -rl "${GREP_COUNT_OPTS[@]}" "$KEYWORD" "$SEARCH_DIR" 2>/dev/null | wc -l)
    else
        MATCH_COUNT=$(grep -rn "${GREP_COUNT_OPTS[@]}" "$KEYWORD" "$SEARCH_DIR" 2>/dev/null | wc -l)
    fi
fi

# Display results
if [ -n "$OUTPUT" ]; then
    echo "$OUTPUT"
    echo ""
fi

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$EXIT_CODE" -eq 0 ] && [ -n "$OUTPUT" ]; then
    if [ "$FILES_ONLY" = true ]; then
        echo -e "📊 ${GREEN}${MATCH_COUNT} file(s) matched${NC}"
    else
        echo -e "📊 ${GREEN}${MATCH_COUNT} match(es) found${NC}"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
else
    echo -e "📊 ${YELLOW}No matches found${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
fi
