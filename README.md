# lwc-logger
Logger component for lwc components

## Steps for generating 2GP managed package

1. sf package create --name "LWC logger" --package-type Managed --path "force-app/main/default/lwc-logger" --target-dev-hub logger-main-org --error-notification-username marketrobin33233@agentforce.com
2. sf package list --target-dev-hub logger-main-org --verbose
3. sf package version create --package "LWC logger" --installation-key-bypass --target-dev-hub logger-main-org
4. sf package version create report --package-create-request-id <id-obtained-in-step-3> --target-dev-hub logger-main-org
