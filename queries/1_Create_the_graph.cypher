match(n) detach delete n;
Call n10s.graphconfig.init();
Call n10s.graphconfig.set({keepLangTag:true,handleRDFTypes:"LABELS_AND_NODES",handleVocabUris:"SHORTEN"});
CREATE CONSTRAINT IF NOT EXISTS ON (r:Resource) ASSERT r.uri IS UNIQUE;
CALL n10s.rdf.import.fetch("file:///C:\\Users\\gal.engelberg\\OneDrive - Accenture\\Gal personal folder\\PHD\\bbo_credit_request.xml","RDF/XML");

MATCH (n:owl__Class)
   call apoc.create.addLabels([ id(n) ], [replace(n.rdfs__label," ","")]) yield node
   with node
   return node;

MATCH p = (n:owl__Class)-[j:rdfs__subClassOf*]->(m:owl__Class)
WITH max(length(p)) as len
UNWIND range(1, len) AS _
MATCH p = (n:owl__Class)-[j:rdfs__subClassOf]->(m:owl__Class)
CALL apoc.create.addLabels([ id(n) ], labels(m)) YIELD node
WITH node
RETURN node;

MATCH (n:owl__NamedIndividual)-[a:rdf__type]->(m:owl__Class)
WITH n, m, [label IN labels(m) WHERE label ENDS WITH '@en' | 'bpmn_' + replace(label, '@en', '')] AS en_labels
CALL apoc.create.addLabels([id(n)], en_labels) YIELD node
RETURN node;