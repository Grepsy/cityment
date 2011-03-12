from pattern.web import Google, plaintext
from pattern.en import parse, split, wordnet
from pattern.en import ADJECTIVE
from pattern.table import Table, pprint

wordnet.sentiment.load();

print wordnet.sentiment["good"]
print wordnet.sentiment["bad"]
print wordnet.sentiment["explosion"]

def score(word):
    # neg..pos, range -1..1, disregards objectivity
    return wordnet.sentiment[word][1] - wordnet.sentiment[word][0]

tups = (("noord", "AMSTERDAM - Een gebouw van een kerncentrale in het noordoosten van Japan is zaterdag ontploft.\
          Door de explosie in Fukushima Daichi I is het dak ingestort en zijn de buitenmuren weggevallen."),
        ("zuid", "AMSTERDAM - Een Tunesische bloggersgroep heeft de Netizen-prijs van Verslaggevers Zonder Grenzen gewonnen voor zijn belangrijke bijdrage aan de opstand in het Noord-Afrikaanse land, die in januari leidde tot het vertrek van president Zine El Abidine Ben Ali."))

table = Table()
for area, text in tups:
    trans = Google().translate(plaintext(text), "nl", "en")

    #for word in trans.split(" "):
        #print word, score(word)
    linescore = sum([score(word) for word in trans.split(" ")])
    table.append([area, text, linescore])

pprint(table)