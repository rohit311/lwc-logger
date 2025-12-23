public with sharing class LoggerSettingsController {

  private final static string CMDT_NAME = 'Logger_Setting__mdt';


  @AuraEnabled
  public static string createCustomMetadataRecord(Map<String, String> fieldsMap){
    String deploymentId = '';
    try {
      Map<String, String> fieldValues = new Map<String, String>();

      fieldValues.put('Component_Name__c', fieldsMap.get('componentName'));
      fieldValues.put('Level__c', fieldsMap.get('level'));
      fieldValues.put('Usesr_Ids__c', fieldsMap.get('userIds'));

      ICustomMetadataManager metadataManager = new CustomMetadataManager();
      CustomMetadataService cmdtService = new CustomMetadataService(metadataManager);
      deploymentId = cmdtService.createCustomMetadataRecord(CMDT_NAME, fieldsMap.get('recordName'), fieldsMap.get('recordLabel'), fieldValues);
      //CustomMetadataService cmdtService = new CustomMetadataService(CMDT_NAME, fieldsMap.get('recordName'), fieldsMap.get('recordLabel'), fieldValues);
      //deploymentId = cmdtService.createCustomMetadataRecord();
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }

    return deploymentId;
  }
}