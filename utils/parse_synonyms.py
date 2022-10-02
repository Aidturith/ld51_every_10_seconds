import json

print("merging synonyms into single json file")

word_dict = {}
jsonl_path = "../downloads/en_thesaurus.jsonl"
dump_path = "synonyms_en.json"

with open(jsonl_path, "r") as f:
    line = f.readline()
    while line:
        data = json.loads(line)
        key = data["word"].lower()
        values = [v.lower() for v in data["synonyms"]]
        if key in values:
            values.remove(key)
        try:
            prev_values = word_dict[key]
        except KeyError:
            prev_values = []
        if values:
            update = {key: prev_values + values}
            word_dict.update(update)
        line = f.readline()

print("dumping result into file " + dump_path)
with open(dump_path, "w") as f:
    json.dump(word_dict, f, sort_keys=True)

