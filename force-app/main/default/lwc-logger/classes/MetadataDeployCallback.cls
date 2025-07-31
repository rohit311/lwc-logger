public with sharing class MetadataDeployCallback implements Metadata.DeployCallback {
    public void handleResult(Metadata.DeployResult result,
                             Metadata.DeployCallbackContext context) {

      Id jobId = context.getCallbackJobId();

      switch on (result.status) {
          when Succeeded {
              // Deployment was successful
              System.debug('in Succeeded');
          }
          when SucceededPartial {
              // The deployment succeeded, but some components might not have been successfully deployed. Check Metadata.DeployResult for more details.
              System.debug('in SucceededPartial');
          }
          when Failed {
              // Deployment was not successful
              System.debug('in Failed');
          }
          when Canceled {
            System.debug('in Canceled');
          }
          when Pending, InProgress, Canceling {
              // Queued or state changing
              System.debug('in Pending');
          }
      }
    }
}