match (a:RiskEvent)
detach delete a;

match (a:bpmn_DataResource) where a.ns1__name in ["Amount"]
with a merge (b:RiskEvent:LossOfIntegrity {src:"simulation",dst:a.ns1__name})
with a,b merge (a)-[r:ParticipatesIn]->(b);

match (a:bpmn_DataResource) where a.ns1__name in ["Amount"]
with a merge (b:RiskEvent:LossOfConfidentiality {src:"simulation",dst:a.ns1__name})
with a,b merge (a)-[r:ParticipatesIn]->(b);

match (a:bpmn_Resource) where a.ns1__name in ["Sue_PC"]
with a merge (b:RiskEvent:LossOfAvailability {src:"simulation",dst:a.ns1__name})
with a,b merge (a)-[r:ParticipatesIn]->(b);

match (a:bpmn_Resource) where a.ns1__name in ["Sue_PC"]
with a merge (b:RiskEvent:LossOfConfidentiality {src:"simulation",dst:a.ns1__name})
with a,b merge (a)-[r:ParticipatesIn]->(b);
