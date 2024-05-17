import json

reader = open("table")
tables = reader.read().splitlines()
reader.close()

# tables = []

partitions = []

for idx, full_path_table in enumerate(tables):
    schema, table = full_path_table.split(".")
    partitions.append({
        "rule-type": "table-settings",
        "rule-id": str(idx + 20000),
        "rule-name": str(idx + 20000),
        "object-locator": {
            "schema-name": schema,
            "table-name": table
        },
        "parallel-load": {
            "type": "partitions-auto"
        }
    })

with open("partitions.json", "w") as writer:
    json.dump(partitions, writer, indent=4)
