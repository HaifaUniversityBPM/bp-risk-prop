# Conceptualizing Process Dependencies That Propagate Cyber Risk

## Abstract
This paper addresses the critical challenge of understanding how cyber risks propagate within business processes, driven by increasing interconnectivity due to IoT and cloud adoption. Existing research often neglects comprehensive process-aware perspectives, particularly the intricate dependencies across business process components. This gap motivates our work to explore how cyber risks, originating at the infrastructure level, cascade through processes, impacting business process components.

We propose a conceptualization as the primary contribution, capturing the representation of business process components, dependencies, cyber risk events, and inference rules to elucidate risk propagation. The conceptualization synthesizes insights from literature and incorporates risk inference rules to address control flow, data flow, and resource-to-activity dependencies. 

A proof-of-concept implementation demonstrates the model's practical utility by analyzing risk propagation within a credit evaluation business process. Our findings emphasize the importance of a nuanced understanding of business process dependencies, revealing how confidentiality, integrity, and availability risks propagate. This work lays the foundation for more robust process-aware risk assessments, offering significant implications for mitigating cascading cyber risks in interconnected business environments.

## Resources

- **OWL File**: The OWL file of the credit request evaluation process can be found [here](./bbo_credit_request.xml).
- **Cypher Queries**: Implementation of the inference rules is available [here](./queries).

### Inference Rules Table

| Inference Rule Number | Cypher Query Name            |
|------------------------|-----------------------------|
| Rule 1                | `1_Create_the_graph.cypher` |
| Rule 2                | [Add other queries]         |

- **Python Script**: The script for running the inference is available [here](./risk_prop_demo.py).

## Formal Description of Process Dependencies

The following table presents the formal description of the process dependencies:

| Dependency Type      | Description                                                                                  |
|----------------------|----------------------------------------------------------------------------------------------|
| Control Flow         | [Description of control flow dependencies]                                                  |
| Data Flow            | [Description of data flow dependencies]                                                     |
| Resource-to-Activity | [Description of resource-to-activity dependencies]                                          |

## Dependencies Table

| **Dependency Type**   | **Dependency Name**          | **Informal Description** | **Formal Description** |
|-----------------------|------------------------------|--------------------------|------------------------|
| **Resource to Activity** | **Input Set Dependency**     | If an activity has an input-output specification with a defined input set that references a resource, then the resource is part of the activity's input set. | $\forall a, ios, is, r \, \big( HasIoSpecification(Activity(a), InputOutputSpecification(ios)) \land HasInputSet(InputOutputSpecification(ios), InputSet(is)) \land HasResourceInputRef(InputSet(is), Resource(r)) \rightarrow InInputSet(r, a) \big)$ |
|                       | **Output Set Dependency**    | If an activity has an input-output specification with a defined output set that references a resource, then the resource is part of the activity's output set. | $\forall a, ios, os, r \, \big( HasIoSpecification(Activity(a), InputOutputSpecification(ios)) \land HasOutputSet(InputOutputSpecification(ios), OutputSet(os)) \land HasResourceOutputRef(OutputSet(os), Resource(r)) \rightarrow InOutputSet(r, a) \big)$ |
| **Control Flow**      | **Normal Sequence Flow Dependency** | If a sequence flow connects two flow nodes (either events or activities), and the flow is a normal sequence flow, then the relationship between these two flow nodes is considered a normal sequence flow. | $\forall a_1, a_2, s \, \big( HasOutgoing(FlowNode(a_1), SequenceFlow(s)) \land HasIncoming(FlowNode(a_2), SequenceFlow(s)) \land (s \in NormalSequenceFlow) \land (a_1 \in \{Event, Activity\}) \land (a_2 \in \{Event, Activity\}) \rightarrow NormalSequenceFlow(a_1, a_2) \big)$ |
|                       | **Gateway Dependency**       | If a gateway (Exclusive, Inclusive, or Parallel) connects two flow nodes with sequence flows and includes a condition expression on the outgoing flow, a gateway pattern is defined by the flow nodes, gateway, and sequence flow with the condition. | $\forall a_1, a_2, g, s_1, s_2, e \, \big( HasOutgoing(FlowNode(a_1), SequenceFlow(s_1)) \land HasIncoming(Gateway(g), SequenceFlow(s_1)) \land HasOutgoing(Gateway(g), SequenceFlow(s_2)) \land (g \in \{ExclusiveGateway, InclusiveGateway, ParallelGateway\}) \land HasIncoming(FlowNode(a_2), SequenceFlow(s_2)) \land ((\exists e \, ConditionExpression(SequenceFlow(s_2), Expression(e))) \rightarrow GatewayPattern(a_1, a_2, g, s_2, e) ) \big)$ |
| **Data Flow**         | **Data on Data**             | A dependency between data resources, where the modification of one data resource (e.g., \( r_1 \)) causes an update to another data resource (e.g., \( r_2 \)) that depends on it. | $\forall r_1, r_2\, (DependsOn(DataResource(r_1), DataResource(r_2)))$ |
|                       | **Data on Activity**         | When a data resource serves as an input to an activity, influencing its behavior or decision-making process. | $\forall r,a\, (InInputSet(DataResource(r), Activity(a)))$ |
|                       | **Activity on Data**         | When an activity modifies a data resource through creation, deletion, or updating. | $\forall r,a\, (InOutputSet(DataResource(r), Activity(a)))$ |
|                       | **Data on Routing Constraint** | If a data resource depends on an expression in a routing constraint through a gateway and sequence flow. | $\forall g,s,r,e\, (HasOutgoing(Gateway(g), SequenceFlow(s)) \land (s  \in ConditionalSequenceFlow) \land ConditionExpression(SequenceFlow(s), Expression(e)) \land DependsOn(Expression(e), DataResource(r)) \rightarrow DataOnRoutingConstraint(r,g,s,e) )$ |
|                       | **Routing Constraint on Flow Node** | When the activation of a flow node depends on a gateway's conditional sequence flow, which is based on the evaluation of a data resource. | $\forall g,s_1,s_2,r,e,a\, (HasOutgoing(Gateway(g), SequenceFlow(s_1))  \land (s_1  \in ConditionalSequenceFlow)  \land ConditionExpression(SequenceFlow(s_1), Expression(e))  \land DependsOn(Expression(e), DataResource(r))  \land HasIncoming(FlowNode(a), SequenceFlow(s_1)) \rightarrow RoutingConstraintOnFlowNode(g,a,r,s_1,e) )$ |


