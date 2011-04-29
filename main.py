import os
import couchdb
import time
from pattern.web import Google, plaintext
from pattern.en import parse, split, wordnet
from pattern.en import ADJECTIVE
from itertools import groupby

def score(word):
    # neg..pos, range -1..1, disregards objectivity
    # 0 = pos, 1 = neg, 2 = obj
    senti = wordnet.sentiment[word] 
    return senti[0] - senti[1] * senti[2]

batch = 5000
couch = couchdb.Server("https://grepsy:kqljcm34%23@grepsy.cloudant.com")
db = couch["cityment"]
results = db.view("_design/filter/_view/spatial", include_docs=True, limit=batch)
print len(results)
articles = []
for item in results.rows[:batch]:
    articles.append(item.doc)

wordnet.sentiment.load();

table = {}
for item in articles:
    try:
        print "TITLE: ", item["title"]
        plain = plaintext(item["content"])
        if (plain == ""):
            print "skipping"
            continue
        trans = Google().translate(plain, "nl", "en")
        area  = item["buurt"]["title"]
        textscore = sum([score(word) for word in trans.split(" ")])
        if (textscore != 0):
            item["score"] = textscore
        #print "TRANS: ", trans
        print area, textscore
    except:
        print "error occured :("
        time.sleep(2)
        continue

db.update(articles)