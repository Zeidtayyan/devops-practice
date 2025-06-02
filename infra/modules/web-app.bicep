@description('Name of the Web App')
param name string

@description('Location for the Web App')
param location string = resourceGroup().location

@description('Kind of the Web App')
param kind string = 'app'

@description('Resource ID of the App Service Plan')
param serverFarmResourceId string

@description('Site config object')
param siteConfig object

@description('App settings key-value pairs')
param appSettingsKeyValuePairs object

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: name
  location: location
  kind: kind
  properties: {
    serverFarmId: serverFarmResourceId
    siteConfig: siteConfig
  }
}

resource webAppSettings 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: webApp
  name: 'appsettings'
  properties: appSettingsKeyValuePairs
}

output name string = webApp.name
output defaultHostName string = webApp.properties.defaultHostName 
