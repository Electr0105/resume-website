import logging
import azure.functions as func
import azurefunctions.extensions.bindings.cosmosdb as cosmos

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)

@app.route(route="cosmos")
@app.cosmos_db_input(arg_name="client",
                     connection="CosmosDBConnection",
                     database_name=None,
                     container_name=None)
def get_docs(req: func.HttpRequest, client: cosmos.CosmosClient):
    databases = client.list_databases()
    for db in databases:
        logging.info(f"Found database with ID: {db.get('id')}")

    return "ok"