MATCH (l1:LossOfAvailability)<-[r1:ParticipatesIn]-(a1:bpmn_FlowNode)-[r2:ns1__has_outgoing]->(s1:bpmn_SequenceFlow)<-[r3:ns1__has_incoming]-(n:bpmn_ExclusiveGateway)-[r4:ns1__has_outgoing]->(s2:bpmn_SequenceFlow)<-[r5:ns1__has_incoming]-(a2:bpmn_FlowNode)
with *
optional MATCH (s2)-[r6:ns1__has_conditionExpression]->(e:bpmn_Expression)
with *,CASE WHEN EXISTS(e.ns1__body) THEN e.ns1__body ELSE "" END AS condition
merge (l2:RiskEvent:LossOfAvailability {src:a1.ns1__name,dst:a2.ns1__name,condition:condition,dsc:"RULE003: Flow node loss of availability propagation via xor pattern"})
merge (a2)-[r7:ParticipatesIn]->(l2)
merge (n)-[r9:ParticipatesIn]->(l2)
merge (l1)-[r8:LeadsTo]->(l2);