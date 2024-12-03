match (l1:LossOfAvailability)<-[r4:ParticipatesIn]-(a:bpmn_Activity)-[r1:ns1__has_ioSpecification]->(b:bpmn_InputOutputSpecification)-[r2:ns1__has_outputSet]->(c:bpmn_OutputSet)-[r3:ns1__has_resourceOutputRef]->(res:bpmn_DataResource)
with *
merge (l2:RiskEvent:LossOfAvailability {src:a.ns1__name,dst:res.ns1__name,dsc:"RULE014: Loss of availability propagation via activity on data pattern (P2)"})
merge (res)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);