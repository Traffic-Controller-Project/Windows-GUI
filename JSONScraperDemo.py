import json

# Read JSON file
def read_json_file(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
    return data

# Example usage
file_path = 'GUI.json'  # Replace with the path to your JSON file

# Read the JSON file
json_data = read_json_file(file_path)

# Access JSON data
print(json_data)  # Print the entire JSON data

# Access specific values
value1 = json_data['Summary (View Only)']

print(value1)
