# Conceptualizing Process Dependencies That Propagate Cyber Risk

## Abstract
This paper explores the propagation of cyber risks within business processes, addressing the lack of process-awareness in existing research, especially regarding dependencies between process model components. We propose a conceptualization that incorporates process model components, dependencies, cyber risk events, and inference rules for capturing cascading effects. The conceptualization covers control flow, data flow, and resource-to-activity dependencies. A proof of concept, analyzing risk propagation in a credit evaluation process, demonstrates how confidentiality, integrity, and availability risks cascade across components. Our findings show how this approach uncovers cascading risks, providing insights for cyber risk assessment in interconnected environments.

## Resources

- **OWL File**: The OWL file of the credit request evaluation process can be found [here](./bbo_credit_request.xml).
- **Cypher Queries**: Implementation of the inference rules is available [here](./queries).
- **Python Script**: The script for running the inference is available [here](./risk_prop_demo.py).
- **Dependencies and Rules Formal Description**: The formal description of the process dependencies and rules [here](./Process_dependencies_that_propagate_cyber_risk__Process_dependencies_and_inference_rules.pdf).

### Mapping of the paper inference rules to the PoC cypher queries:

| Inference Rule Number | Cypher Query Name            |
|------------------------|-----------------------------|
| Rule 1                | `1_Create_the_graph.cypher` |
| Rule 2                | [Add other queries]         |




