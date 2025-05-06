# Conceptualizing Process Dependencies That Propagate Cyber Risk

## Abstract
This paper explores the propagation of cyber risks within business processes, addressing the lack of process-awareness in existing research, especially regarding dependencies between process model components. We propose a conceptualization that incorporates process model components, dependencies, cyber risk events, and inference rules for capturing cascading effects. The conceptualization covers control flow, data flow, and resource-to-activity dependencies. A proof of concept, analyzing risk propagation in a credit evaluation process, demonstrates how confidentiality, integrity, and availability risks cascade across components. Our findings show how this approach uncovers cascading risks, providing insights for cyber risk assessment in interconnected environments.

## Resources

- **OWL File**: The OWL file of the credit request evaluation process can be found [here](./bbo_credit_request.xml).
- **Cypher Queries**: Implementation of the inference rules is available [here](./queries).
- **Python Script**: The script for running the inference is available [here](./risk_prop_demo.py).
- **Dependencies and Rules Formal Description**: The formal description of the process dependencies and rules [here](./Process_dependencies_that_propagate_cyber_risk__Process_dependencies_and_inference_rules.pdf).
- **Simulated vulnerabilities**: links to the simulated vulnerabilities [here](./simulated_vulnerabilities.txt).

### Mapping of the paper inference rules to the PoC cypher queries:

| Inference Rule Number | Rule Description                                                                                  | Cypher Query Name                                                                                          |
|------------------------|---------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Rule 1                 | If all resources involved in an activity input set becomes unavailable, the input set itself becomes unavailable. | [`RULE001_Resource_to_inputset_loss_of_availability_propagation.cypher`](./queries/RULE001_Resource_to_inputset_loss_of_availability_propagation.cypher) |
| Rule 2                 | If at least one input set of an activity becomes unavailable, the activity itself becomes unavailable. | [`RULE001_1_Inputset_to_activity_loss_of_availability_propagation.cypher`](./queries/RULE001_1_Inputset_to_activity_loss_of_availability_propagation.cypher) |
| Rule 3                 | If a data resource becomes unavailable, any data resource that depends on it also becomes unavailable. | [`RULE011_Data_on_data_P1_risk_propagation_of_availability.cypher`](./queries/RULE011_Data_on_data_P1_risk_propagation_of_availability.cypher) |
| Rule 4                 | If an activity is unavailable, its output data becomes unavailable.                                | [`RULE014_Activity_on_data_P2_loss_of_availability_propagation.cypher`](./queries/RULE014_Activity_on_data_P2_loss_of_availability_propagation.cypher) |
| Rule 5                 | If a flow node in a normal sequence flow becomes unavailable, the subsequent flow node also becomes unavailable. | [`RULE002_Flow_node_loss_of_availability_propagation_via_sequence_flow_pattern.cypher`](./queries/RULE002_Flow_node_loss_of_availability_propagation_via_sequence_flow_pattern.cypher) |
| Rule 6                 | An ExclusiveGateway causes output nodes to be unavailable if an input node is unavailable and the sequence flow expression is true. An InclusiveGateway requires all input nodes to be unavailable, while a ParallelGateway is affected by the unavailability of any input node. | [`RULE003_Flow_node_loss_of_availability_propagation_via_xor_pattern.cypher`](./queries/RULE003_Flow_node_loss_of_availability_propagation_via_xor_pattern.cypher); [`RULE004_Flow_node_loss_of_availability_propagation_via_or_pattern.cypher`](./queries/RULE004_Flow_node_loss_of_availability_propagation_via_or_pattern.cypher); [`RULE005_Flow_node_loss_of_availability_propagation_via_parallel_pattern.cypher`](./queries/RULE005_Flow_node_loss_of_availability_propagation_via_parallel_pattern.cypher) |
| Rule 7                 | Loss of confidentiality propagates when a compromised non-data resource in an activity's input or output set compromises the confidentiality of data resources involved. | [`RULE007_Resource_to_data_resource_loss_of_confidentiality_propagation.cypher`](./queries/RULE007_Resource_to_data_resource_loss_of_confidentiality_propagation.cypher) |
| Rule 8                 | If a data resource in an activity’s input or output set loses confidentiality, the activity’s confidentiality is compromised. | [`RULE009_Data_resource_to_activity_loss_of_confidentiality_propagation_P2_P3.cypher`](./queries/RULE009_Data_resource_to_activity_loss_of_confidentiality_propagation_P2_P3.cypher) |
| Rule 9                 | If a non-data resource in an activity's input set has compromised integrity, the output data resources of the activity will also be compromised. | [`RULE008_Resource_to_data_resource_loss_of_integrity_propagation.cypher`](./queries/RULE008_Resource_to_data_resource_loss_of_integrity_propagation.cypher) |
| Rule 10                | If one data resource depends on another and it loses integrity, the dependent resource is compromised. | [`RULE010_Data_on_data_P1_risk_propagation_of_integrity.cypher`](./queries/RULE010_Data_on_data_P1_risk_propagation_of_integrity.cypher) |
| Rule 11                | If a data resource in an activity's input set loses integrity, the activity's integrity is compromised. | [`RULE012_Data_on_Activity_P3_loss_of_integrity_propagation.cypher`](./queries/RULE012_Data_on_Activity_P3_loss_of_integrity_propagation.cypher) |
| Rule 12                | If an activity loses integrity and produces a data resource, that resource’s integrity is compromised. | [`RULE013_Activity_on_data_P2_loss_of_integrity_propagation.cypher`](./queries/RULE013_Activity_on_data_P2_loss_of_integrity_propagation.cypher) |
| Rule 13                | If a data resource affected by a loss of integrity is part of a sequence flow constrained by a gateway, the gateway’s integrity is compromised. | [`RULE015_Data_on_routing_constraint_P5_loss_of_integrity_propagation.cypher`](./queries/RULE015_Data_on_routing_constraint_P5_loss_of_integrity_propagation.cypher) |
| Rule 14                | If a gateway in a routing constraint for a flow node loses integrity, the flow node’s integrity is also compromised. | [`RULE016_Routing_constraint_on_flow_node_P6_loss_of_integrity_propagation.cypher`](./queries/RULE016_Routing_constraint_on_flow_node_P6_loss_of_integrity_propagation.cypher) |




