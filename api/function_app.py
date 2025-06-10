import azure.functions as func

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="visitorcount")
@app.cosmos_db_input(arg_name="container",
                     connection="CosmosDBConnection",
                     database_name="resume-db",
                     container_name="resume-container")
@app.cosmos_db_output(arg_name="container2",
                     connection="CosmosDBConnection",
                     database_name="resume-db",
                     container_name="resume-container")
def increment_visitor_count(req: func.HttpRequest, container: func.DocumentList, container2: func.Out[func.Document]):
    document = container[0]
    current_value = document['value']
    document['value'] = current_value + 1
    container2.set(document)

    return str(current_value)


