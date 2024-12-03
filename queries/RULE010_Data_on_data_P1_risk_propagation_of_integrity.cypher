match (res1:bpmn_DataResource)-[r:ns1__dependsOn]->(res2:bpmn_DataResource)-[r4:ParticipatesIn]->(l1:LossOfIntegrity)
with *
merge (l2:RiskEvent:LossOfIntegrity {src:res2.ns1__name,dst:res1.ns1__name,dsc:"RULE010: Data on data (P1) risk propagation of integrity"})
merge (res1)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);