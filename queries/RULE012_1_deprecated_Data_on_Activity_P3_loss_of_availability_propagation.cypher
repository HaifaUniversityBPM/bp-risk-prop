match (a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_inputSet]->(c:bpmn_InputSet)-[r3:ns1__has_resourceInputRef]->(res:bpmn_DataResource)-[r4:ParticipatesIn]->(l1:LossOfAvailability)
with *
merge (l2:RiskEvent:LossOfAvailability {src:res.ns1__name,dst:a.ns1__name,dsc:"RULE012.1: Data on activity pattern (P3) loss of availability propagation"})
merge (a)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);
