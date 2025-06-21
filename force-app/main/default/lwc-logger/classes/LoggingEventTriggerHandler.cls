public with sharing class LoggingEventTriggerHandler {

  public static void afterInsertHandler(List<Log__e> loggedPlatformEvents) {
    List<Log_Event__c> loggingRecordsToCreate = new List<Log_Event__c>();

    for(Log__e loggedPlatformEvent : loggedPlatformEvents) {
        Log_Event__c logRecord = new Log_Event__c();
        logRecord.Component_Name__c = loggedPlatformEvent.Component_Name__c;
        logRecord.Current_User__c = loggedPlatformEvent.CreatedById;
        logRecord.Level__c = loggedPlatformEvent.Level__c;
        logRecord.Message__c = loggedPlatformEvent.Message__c;
        logRecord.Object_Ids__c	 = loggedPlatformEvent.Object_Ids__c;
        logRecord.Stack_Trace__c = loggedPlatformEvent.Stack_Trace__c;

        loggingRecordsToCreate.add(logRecord);
     }

     insert loggingRecordsToCreate;
  }
}