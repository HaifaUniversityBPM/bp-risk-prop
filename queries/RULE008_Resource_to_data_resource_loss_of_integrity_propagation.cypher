match (a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_inputSet]->(c:bpmn_InputSet)-[r3:ns1__has_resourceInputRef]->(res:bpmn_Resource)-[r4:ParticipatesIn]->(l1:LossOfIntegrity)
where not res:bpmn_DataResource and not res:bpmn_HumanResource
with a,res,l1
match (a)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_outputSet]->(c:bpmn_OutputSet)-[r3:ns1__has_resourceOutputRef]->(res1:bpmn_DataResource)
with *
merge (l2:RiskEvent:LossOfIntegrity {src:res.ns1__name,dst:res1.ns1__name,dsc:"RULE008: Resource to data resource loss of integrity propagation"})
merge (res1)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);