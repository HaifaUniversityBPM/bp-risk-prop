MATCH (g:bpmn_Gateway)-[r1:ns1__has_outgoing]->(s:ns1__ConditionalSequenceFlow)-[r2:ns1__has_conditionExpression]->(e:bpmn_ConditionExpression)-[r3:ns1__dependsOn]->(res:bpmn_DataResource)-[r4:ParticipatesIn]->(l1:LossOfIntegrity)
with *,CASE WHEN EXISTS(e.ns1__body) THEN "if ("+res.ns1__name+".truth ∋ '"+e.ns1__body +"' "+"and "+res.ns1__name+".modified !∋ '"+e.ns1__body +"')" ELSE "" END AS condition
merge (l2:RiskEvent:LossOfIntegrity {src:res.ns1__name,dst:g.ns1__name,condition:condition,dsc:"RULE015: Data on routing constraint (P5) loss of integrity propagation"})
merge (g)-[r7:ParticipatesIn]->(l2)
merge (l1)-[r8:LeadsTo]->(l2);
