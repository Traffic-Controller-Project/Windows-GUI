#!/usr/bin/bash

# Check if the required environment variables are set
if [ -z "$MQTT_BROKER_IP" ] || [ -z "$MQTT_BROKER_PORT" ]; then
    echo "Error: MQTT_BROKER_IP and MQTT_BROKER_PORT environment variables must be set."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <json_file_path> <mqtt_topic>"
    exit 1
fi

json_file_path=$1
mqtt_topic=$2

# Function to deploy JSON content to MQTT broker
deploy_to_mqtt() {
    json_content=$(cat "$json_file_path")
    # Print debug information
    echo "Deploying JSON content to MQTT broker on topic: $mqtt_topic"
    echo "JSON content:"
    echo "$json_content"
    
    # Assuming 'mosquitto_pub' is available for publishing messages
    mosquitto_pub -h "$MQTT_BROKER_IP" -p "$MQTT_BROKER_PORT" -t "$mqtt_topic" -m "$json_content"
    echo "JSON content deployed to MQTT broker on topic: $mqtt_topic"
}

# Main loop
while true; do
    read -rsn1 input
    echo $input
    if [ "$input" == "r" ]; then
        # If spacebar is pressed, deploy JSON content to MQTT broker
        json_content=$(cat "$json_file_path")
        # Print debug information
        echo "Deploying JSON content to MQTT broker on topic: $mqtt_topic"
        echo "JSON content:"
        echo "$json_content"
        
        # Assuming 'mosquitto_pub' is available for publishing messages
        mosquitto_pub -h "$MQTT_BROKER_IP" -p "$MQTT_BROKER_PORT" -t "$mqtt_topic" -m "$json_content"
        echo "JSON content deployed to MQTT broker on topic: $mqtt_topic"
        deploy_to_mqtt
    elif [ "$input" == "q" ]; then
        # If 'q' is pressed, exit the script
        echo "Exiting script."
        exit 0
    fi
done
