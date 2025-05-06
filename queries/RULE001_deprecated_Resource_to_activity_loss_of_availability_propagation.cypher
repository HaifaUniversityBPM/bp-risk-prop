match (a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_inputSet|ns1__has_outputSet]->(c)-[r3:ns1__has_resourceInputRef|ns1__has_resourceOutputRef]->(res:bpmn_Resource)-[r4:ParticipatesIn]->(l1:LossOfAvailability)
where not (res:bpmn_DataResource)
with *
merge (l2:RiskEvent:LossOfAvailability {src:res.ns1__name,dst:a.ns1__name,dsc:"RULE001: Resource to activity loss of availability propagation"})
merge (a)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);
