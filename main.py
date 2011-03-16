import json
import os
import libxml2
from pattern.web import Google, plaintext
from pattern.en import parse, split, wordnet
from pattern.en import ADJECTIVE
from itertools import groupby

def score(word):
    # neg..pos, range -1..1, disregards objectivity
    return wordnet.sentiment[word][0] - wordnet.sentiment[word][1]

articles = []
for root, dirs, files in os.walk('static'):
    for filename in files:
        doc = libxml2.parseFile('static/' + filename)
        for item in doc.xpathEval('/result/items/item'):
            areas = item.xpathEval('buurt/title')
            if len(areas) == 0: continue
            area = areas[0].content
            text = item.xpathEval('content')[0].content
            articles.append((area, text))

# print articles
# articles = (("noord", "goed goed goed"),
#             ("west", "aap aap aap"),
#             ("zuid", "slecht slecht slecht"))

wordnet.sentiment.load();

table = {}
for area, text in articles:
    plain = plaintext(text)
    trans = Google().translate(plain, "nl", "en")

    textscore = sum([score(word) for word in trans.split(" ")])
    if area in table:
        table[area] += textscore
    else:
        table[area] = textscore
    print area, textscore

prep = []
for area, score in table.iteritems():
    prep.append({ "area": area, "score": score })

prep = sorted(prep, reverse=True, key=lambda row: row["score"])

export = open("web/export.js", "w")
export.write('var scores = ')
export.write(json.dumps(prep))
export.close()