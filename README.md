# Shiny to Azure App Service demo

This repo contains the necessary set up to deploy your Shiny app to [Azure App Service](https://azure.microsoft.com/en-us/products/app-service). You will need the following:

* An `app.R` file
* A `Dockerfile`
* GitHub Actions workflow file (in this repo, called `container-registry.yaml`)
* An Azure account, where you are allowed to set up an Azure App Service Plan, and Azure Container Registry

The Docker image will be stored in [Azure Container Registry](https://azure.microsoft.com/en-us/products/container-registry). Azure App Service will run the application from this image.

This project uses [renv](https://rstudio.github.io/renv/index.html) and will use the `renv.lock` file to install the necessary R packages in the container.

## Authentication

In the app, you will also see a logout button and a script, called `auth.js`, that works in combination with [Entra ID](https://www.microsoft.com/en-us/security/business/microsoft-entra). You can make use of the built-in authentication and authorization capabilities of Azure App Service to make this happen. See you YouTube tutorials section for more information about adding authentication to Azure App Service.

This is a solution that works, and it's pretty vanilla, but you also have another option: [AzureAuth](https://cran.r-project.org/web/packages/AzureAuth/vignettes/shiny.html). 

## Costs

There are costs involved with setting up the Azure Container Registry. You pay per day for storage, and you pay per second for build time 💰. With the lowest tier this will result in approximately 5 USD per month, depending on your set region and your build times. Azure App Service has a free tier (F1), which allows 60 CPU-minutes per day and 1GB RAM, and 1GB storage. The first basic App Service tier (B1) starts from 0,018 USD per hour. You can get more information about pricing [here](https://azure.microsoft.com/nl-nl/pricing/details/app-service/linux/).

Microsoft Entra ID is included with Microsoft cloud subscriptions such as Microsoft Azure and Microsoft 365. For more advanced usage, you can move to the [paid tiers](https://www.microsoft.com/en-us/security/business/microsoft-entra-pricing). 

## Alternatives

⚠️ Note that another option is to use Azure Container Apps, which has a different pricing model and a slightly different aim. I've chosen Azure App Service here because I've worked with it before, but do your research before you pick something!

# Watch tutorials on YouTube

1️⃣  ["Deploying Your Shiny Application to Azure App Service"](https://youtu.be/Phnihe6cBgE)
2️⃣  ["Adding Authentication to Azure App Service"](https://youtu.be/2vZDTIb6KWc)

# Plumber API to Azure App Service

Not looking to have your Shiny app deployed, but an R Plumber API? You can do that in a very similar manner too! Check out this article on [how to deploy a Plumber API to Azure App Service](https://veerlevanleemput.medium.com/hosting-a-r-plumber-api-using-azure-app-service-4e78936787cf), and this follow-up article on [how to add authentication to your (Plumber) API](https://veerlevanleemput.medium.com/adding-authentication-to-an-api-on-azure-app-service-f7a3770986f).

