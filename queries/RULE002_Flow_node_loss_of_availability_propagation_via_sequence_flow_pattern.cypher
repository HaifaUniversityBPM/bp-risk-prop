match (l1:LossOfAvailability)<-[r1:ParticipatesIn]-(a1:bpmn_FlowNode)-[r2:ns1__has_outgoing]->(s1:bpmn_NormalSequenceFlow)<-[r3:ns1__has_incoming]-(a2:bpmn_FlowNode)
with *
merge (l2:RiskEvent:LossOfAvailability {src:a1.ns1__name,dst:a2.ns1__name,dsc:"RULE002: Flow node loss of availability propagation via sequence flow pattern"})
merge (a2)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);