import paho.mqtt.client as mqtt
import keyboard
import json

# MQTT broker details
topics = ["/traffic/slave_feedback","/traffic/master_feedback"]
# broker = "traffic-controller.cloud.shiftr.io"
# port = 1883
# username = "traffic-controller"
# password = "sZG1eCQPPOS7nmBg"
broker = "raspberrypi"
port = 1883
username = "raspi_broker"
password = "12345678"
client_id = "GUIClient"

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