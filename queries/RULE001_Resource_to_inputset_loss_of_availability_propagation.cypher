MATCH (i:bpmn_InputSet)-[:ns1__has_resourceInputRef]->(res:bpmn_Resource)
WHERE NOT res:bpmn_HumanResource
WITH i, COLLECT(DISTINCT res) AS resources
WHERE ALL(res IN resources WHERE (res)-[:ParticipatesIn]->(:LossOfAvailability))
WITH i, resources,[r IN resources | r.ns1__name] AS resourceNames,split(i.uri, '#')[1] AS inputSetName
MERGE (l2:RiskEvent:LossOfAvailability {dst: inputSetName,dsc: "RULE001: Resource to input set loss of availability propagation"})
SET l2.src = resourceNames
WITH i, l2, resources
UNWIND resources AS res
MATCH (res)-[:ParticipatesIn]->(l1:LossOfAvailability)
MERGE (i)-[:ParticipatesIn]->(l2)
MERGE (l1)-[:LeadsTo]->(l2)