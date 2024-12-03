from neo4j import GraphDatabase

class CypherExecutor:

    def __init__(self, uri, user, password):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self.driver.close()

    def execute_single_cypher_file(self, file_path, db_name):
        query = self.load_query(file_path)
        statements = query.split(";")  # Split the query into individual statements
        any_modifications = False
        for statement in statements:
            trimmed_statement = statement.strip()
            if trimmed_statement:  # Only execute if not empty
                result_summary = self.run_cypher(trimmed_statement, db_name)
                print(f"Executed statement: {trimmed_statement}")
                if self.has_modifications(result_summary):
                    any_modifications = True  # If any query modifies the graph
        return any_modifications

    def execute_multiple_cypher_files(self, file_paths, db_name):
        any_modifications = True
        extra_iterations = 0  # Tracks how many extra iterations are done
        max_extra_iterations = 10  # Number of extra iterations to run after no modifications

        # Continue until no modifications are made for 5 consecutive iterations
        while any_modifications or extra_iterations > 0:
            any_modifications = False

            for file_path in file_paths:
                file_modified = self.execute_single_cypher_file(file_path, db_name)
                if file_modified:
                    any_modifications = True

            if not any_modifications:
                if extra_iterations == 0:
                    # No modifications, start the extra iterations
                    extra_iterations = max_extra_iterations
                    print(f"No modifications made. Running {max_extra_iterations} more iterations to double-check.")
                else:
                    # Decrease the extra iteration count
                    extra_iterations -= 1
                    print(f"Extra iteration {max_extra_iterations - extra_iterations} completed, {extra_iterations} remaining.")

            if any_modifications:
                # If modifications were made in any iteration, reset the extra iterations
                extra_iterations = 0
                print("Modifications made, restarting the loop...")

    def load_query(self, file_path):
        with open(file_path, 'r') as file:
            return file.read()

    def run_cypher(self, query, db_name):
        with self.driver.session(database=db_name) as session:
            result = session.run(query)
            return result.consume()

    def has_modifications(self, summary):
        return (summary.counters.nodes_created or
                summary.counters.nodes_deleted or
                summary.counters.relationships_created or
                summary.counters.relationships_deleted or
                summary.counters.properties_set)

if __name__ == '__main__':
    uri = 
    user = 
    password = 
    database_name = 
    executor = CypherExecutor(uri, user, password)
    #Create the graph
    executor.execute_single_cypher_file(r"queries/1_Create_the_graph.cypher", database_name)
    #Setup initial state risk event
    executor.execute_single_cypher_file(r"queries/2_setup_risk_events.cypher", database_name)
    #Run the risk propagation queries
    file_paths = [r"queries/RULE001_Resource_to_activity_loss_of_availability_propagation.cypher",
                  r"queries/RULE002_Flow_node_loss_of_availability_propagation_via_sequence_flow_pattern.cypher",
                  r"queries/RULE003_Flow_node_loss_of_availability_propagation_via_xor_pattern.cypher",
                  r"queries/RULE004_Flow_node_loss_of_availability_propagation_via_or_pattern.cypher",
                  r"queries/RULE005_Flow_node_loss_of_availability_propagation_via_parallel_pattern.cypher",
                  #r"queries/RULE006_Flow_node_loss_of_availability_via_discriminator_converging_gateway.cypher",
                  r"queries/RULE007_Resource_to_data_resource_loss_of_confidentiality_propagation.cypher",
                  r"queries/RULE008_Resource_to_data_resource_loss_of_integrity_propagation.cypher",
                  r"queries/RULE009_Data_resource_to_activity_loss_of_confidentiality_propagation_P2_P3.cypher",
                  r"queries/RULE010_Data_on_data_P1_risk_propagation_of_integrity.cypher",
                  r"queries/RULE011_Data_on_data_P1_risk_propagation_of_availability.cypher",
                  r"queries/RULE012_Data_on_Activity_P3_loss_of_integrity_propagation.cypher",
                  r"queries/RULE012_1_Data_on_Activity_P3_loss_of_availability_propagation.cypher",
                  r"queries/RULE013_Activity_on_data_P2_loss_of_integrity_propagation.cypher",
                  r"queries/RULE014_Activity_on_data_P2_loss_of_availability_propagation.cypher",
                  r"queries/RULE015_Data_on_routing_constraint_P5_loss_of_integrity_propagation.cypher",
                  r"queries/RULE016_Routing_constraint_on_flow_node_P6_loss_of_integrity_propagation.cypher",
                  #r"queries/RULE017_Loss_of_integrity_of_a_routing_constraint_that_leads_to_a_loss_of_availability.cypher"
    ]
    executor.execute_multiple_cypher_files(file_paths, database_name)
    executor.close()
