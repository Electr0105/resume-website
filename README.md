# Cloud Resume Challenge - Resume Website
The complete code for my Cloud Resume Challenge, including front-end, back-end and the Terraform export.

## Front End
The visible website component contains some simple HTML, CSS and JS, enhanced with Tailwind. My resume is also downloadable through the website.

## Back End
The back-end expects the Azure resources to be already available. The API directory contains the code and the other required files that allow the Python Azure Function to communicate with the CosmosDB. 

## Terraform
To create the required Terraform to replicate this project, I used 'aztfexport'. While I recommend this for ease its ease of use, you'll need to manually remove any secrets, IDs, etc.
