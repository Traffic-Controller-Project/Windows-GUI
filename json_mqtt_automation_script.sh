#!/bin/bash

# Check if the required environment variables are set
if [ -z "$MQTT_BROKER_IP" ] || [ -z "$MQTT_BROKER_PORT" ]; then
    echo "Error: MQTT_BROKER_IP and MQTT_BROKER_PORT environment variables must be set."
    exit 1
fi

# Check if the argument (JSON file path) is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <json_file_path>"
    exit 1
fi

# Function to deploy JSON content to MQTT broker
deploy_to_mqtt() {
    json_content=$(cat "$1")
    # Assuming 'mosquitto_pub' is available for publishing messages
    mosquitto_pub -h "$MQTT_BROKER_IP" -p "$MQTT_BROKER_PORT" -t "topic" -m "$json_content"
    echo "JSON content deployed to MQTT broker."
}

# Main loop
while true; do
    read -rsn1 input
    if [ "$input" == " " ]; then
        # If spacebar is pressed, deploy JSON content to MQTT broker
        deploy_to_mqtt "$1"
    elif [ "$input" == "q" ]; then
        # If 'q' is pressed, exit the script
        echo "Exiting script."
        exit 0
    fi
done
