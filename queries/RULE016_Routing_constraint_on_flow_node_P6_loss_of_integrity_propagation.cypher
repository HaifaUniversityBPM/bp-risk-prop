MATCH (l1:LossOfIntegrity)<-[r1:ParticipatesIn]-(g:bpmn_Gateway)-[r2:ns1__has_outgoing]->(s1:ns1__ConditionalSequenceFlow)-[r3:ns1__has_conditionExpression]->(e:bpmn_ConditionExpression)-[r4:ns1__dependsOn]->(res:bpmn_DataResource)
MATCH (s1)<-[r5:ns1__has_incoming]-(a1:bpmn_FlowNode)
MATCH (res)-[:ParticipatesIn]->(:LossOfIntegrity)
with *,CASE WHEN EXISTS(e.ns1__body) THEN "if ("+res.ns1__name+".truth ∋ '"+e.ns1__body +"' "+"and "+res.ns1__name+".modified !∋ '"+e.ns1__body +"')" ELSE "" END AS condition
merge (l2:RiskEvent:LossOfIntegrity {src:g.ns1__name,dst:a1.ns1__name,condition:condition,dsc:"RULE016: Routing constraint on activity/ events (P6) loss of integrity propagation"})
merge (a1)-[r7:ParticipatesIn]->(l2)
with l1,l2 where l1.condition = l2.condition
merge (l1)-[r8:LeadsTo]->(l2);
