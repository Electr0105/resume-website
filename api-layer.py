from azure.cosmos import CosmosClient
from azure.ide
import os

URL = os.environ["ACCOUNT_URI"]
KEY = os.environ["ACCOUNT_KEY"]
client = CosmosClient(URL, credential=KEY)
