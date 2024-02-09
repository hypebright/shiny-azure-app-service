# Shiny to Azure App Service demo

This repo contains the necessary set up to deploy your Shiny app to Azure App Service. You will need the following:

* An app.R file
* A Dockerfile
* GitHub Actions workflow file (in this repo, called `container-registry.yaml`
* An Azure account, where you are allowed to set up an Azure App Service Plan, and Azure Container Registry

The Docker image will be stored in [Azure Container Registry](https://azure.microsoft.com/en-us/products/container-registry). Azure App Service will run this image from the Azure Container Registry.

This project uses [renv](https://rstudio.github.io/renv/index.html) and will use the `renv.lock` file to install the necessary packages.

## Costs

There are costs involved with setting up the Azure Container Registry. You pay per day for storage, and you pay per second for build time 💰. With the lowest tier this will result in approximately 5 USD per month, depending on your set region and your build times. Azure App Service has a free tier (F1), which allows 60 CPU-minutes per day and 1GB RAM, and 1GB storage. The first basic App Service tier (B1) starts from 0,018 USD per hour. You can get more information about pricing [here](https://azure.microsoft.com/nl-nl/pricing/details/app-service/linux/)

# Watch this tutorial on YouTube

In 10 minutes, I will walk you through all the steps to deploy the Hangman app. You can watch "Deploying Your Shiny Application to Azure App Service" on YouTube 🚀.

# Plumber API to Azure App Service

Not looking to have your Shiny app deployed, but an R Plumber API? You can do that in a very similar manner too! Check out this article on [how to deploy a Plumber API to Azure App Service](https://veerlevanleemput.medium.com/hosting-a-r-plumber-api-using-azure-app-service-4e78936787cf), and this follow-up article on [how to add authentication to your (Plumber) API](https://veerlevanleemput.medium.com/adding-authentication-to-an-api-on-azure-app-service-f7a3770986f).

