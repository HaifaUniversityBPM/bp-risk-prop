match (a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_inputSet|ns1__has_outputSet]->(c)-[r3:ns1__has_resourceInputRef|ns1__has_resourceOutputRef]->(res:bpmn_DataResource)-[r4:ParticipatesIn]->(l1:LossOfConfidentiality)
with *
merge (l2:RiskEvent:LossOfConfidentiality {src:res.ns1__name,dst:a.ns1__name,dsc:"RULE009: Data resource to activity loss of confidentiality propagation"})
merge (a)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);