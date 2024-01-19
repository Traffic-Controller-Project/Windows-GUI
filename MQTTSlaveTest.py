import paho.mqtt.client as mqtt
import keyboard
import json
from numpy.random import randint

# MQTT broker details
data = None
topic = "/traffic/slave_feedback"
# broker = "raspberrypi"
broker = "192.168.86.14"
port = 1883
username = "raspi_broker"
password = "12345678"
# broker = "traffic-controller.cloud.shiftr.io"
# port = 1883
# username = "traffic-controller"
# password = "sZG1eCQPPOS7nmBg"
client_id = "slaveTest"

# Callback functions
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT broker")
    else:
        print("Failed to connect, return code: " + str(rc))

def on_publish(client, userdata, mid):
    print("Message published")

def on_subscribe(client, userdata, mid, granted_qos):
    print("Subscribed to topic")

# Create MQTT client and set callbacks
client = mqtt.Client(client_id)
client.username_pw_set(username, password)
client.on_connect = on_connect
client.on_publish = on_publish
client.on_subscribe = on_subscribe

def on_key_press(event):
    if event.event_type == keyboard.KEY_DOWN:
        id = randint(1,5)
        message = {
            "id": id,
            "s": randint(0,5),
            "timers":{
                "red":20,
                "green":10
            },
            "elapsed_t":2
        }
        json_message = json.dumps(message)
        print(json_message)
        client.publish(topic, json_message)

# Connect to MQTT broker
client.connect(broker, port, 60)

# Start the network loop
client.loop_start()

keyboard.on_press(on_key_press)

# Wait for KeyboardInterrupt to stop the script
try:
    while True:
        pass
except KeyboardInterrupt:
    print("Disconnecting...")
    client.loop_stop()
    client.disconnect()