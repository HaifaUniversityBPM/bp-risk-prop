match (a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_inputSet]->(i:bpmn_InputSet)-[r3:ParticipatesIn]->(l1:LossOfAvailability)
with *
merge (l2:RiskEvent:LossOfAvailability {src:split(i.uri, '#')[1],dst:a.ns1__name,dsc:"RULE001_1: Inputset to activity loss of availability propagation"})
merge (a)-[r4:ParticipatesIn]->(l2)
merge (l1)-[r5:LeadsTo]->(l2)