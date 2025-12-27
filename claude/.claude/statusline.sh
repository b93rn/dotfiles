#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract model information
MODEL=$(echo "$input" | jq -r '.model.display_name')
MODEL_ID=$(echo "$input" | jq -r '.model.id')

# Extract context window information
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')

# Calculate context usage percentage
if [ "$USAGE" != "null" ]; then
    INPUT_TOKENS=$(echo "$USAGE" | jq -r '.input_tokens // 0')
    CACHE_CREATE=$(echo "$USAGE" | jq -r '.cache_creation_input_tokens // 0')
    CACHE_READ=$(echo "$USAGE" | jq -r '.cache_read_input_tokens // 0')

    CURRENT_TOKENS=$((INPUT_TOKENS + CACHE_CREATE + CACHE_READ))
    PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))

    # Create a visual progress bar
    BAR_LENGTH=20
    FILLED=$((PERCENT_USED * BAR_LENGTH / 100))
    EMPTY=$((BAR_LENGTH - FILLED))

    PROGRESS_BAR="["
    for ((i = 0; i < FILLED; i++)); do
        PROGRESS_BAR="${PROGRESS_BAR}="
    done
    for ((i = 0; i < EMPTY; i++)); do
        PROGRESS_BAR="${PROGRESS_BAR}-"
    done
    PROGRESS_BAR="${PROGRESS_BAR}]"
else
    PERCENT_USED=0
    PROGRESS_BAR="[--------------------]"
fi

# Fetch weather for Meppel, Netherlands
# Using open-meteo API (free, no auth required)
WEATHER_DATA=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=52.6921&longitude=6.1937&current=temperature_2m,weather_code&timezone=auto" 2>/dev/null)

if [ $? -eq 0 ]; then
    TEMP=$(echo "$WEATHER_DATA" | jq -r '.current.temperature_2m // "N/A"')
    WEATHER_CODE=$(echo "$WEATHER_DATA" | jq -r '.current.weather_code // 0')

    # Convert weather code to emoji
    case $WEATHER_CODE in
        0) WEATHER_EMOJI="☀️" ;;   # Clear sky
        1|2) WEATHER_EMOJI="⛅" ;;  # Partly cloudy
        3) WEATHER_EMOJI="☁️" ;;    # Cloudy
        45|48) WEATHER_EMOJI="🌫️" ;; # Foggy
        51|53|55) WEATHER_EMOJI="🌦️" ;; # Drizzle
        61|63|65) WEATHER_EMOJI="🌧️" ;; # Rain
        71|73|75) WEATHER_EMOJI="❄️" ;;  # Snow
        77) WEATHER_EMOJI="❄️" ;;   # Snow grains
        80|81|82) WEATHER_EMOJI="⛈️" ;;  # Showers
        85|86) WEATHER_EMOJI="🌨️" ;; # Snow showers
        95|96|99) WEATHER_EMOJI="⚡" ;; # Thunderstorm
        *) WEATHER_EMOJI="🌡️" ;;   # Unknown
    esac

    WEATHER_STR="$WEATHER_EMOJI ${TEMP}°C"
else
    WEATHER_STR="Weather N/A"
fi

# Output the status line with colors
# Model in cyan, context bar in yellow, weather in green
echo -e "\033[36m[$MODEL]\033[0m \033[33m$PROGRESS_BAR ${PERCENT_USED}%\033[0m \033[32m$WEATHER_STR\033[0m"
