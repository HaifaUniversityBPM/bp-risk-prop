match (res1:bpmn_DataResource)-[r:ns1__dependsOn]->(res2:bpmn_DataResource)-[r4:ParticipatesIn]->(l1:LossOfAvailability)
with *
merge (l2:RiskEvent:LossOfAvailability {src:res2.ns1__name,dst:res1.ns1__name,dsc:"RULE011: Data on data (P1) risk propagation of availability"})
merge (res1)-[r5:ParticipatesIn]->(l2)
merge (l1)-[r6:LeadsTo]->(l2);