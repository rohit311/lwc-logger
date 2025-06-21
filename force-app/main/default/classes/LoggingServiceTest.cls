@isTest
public with sharing class LoggingServiceTest {
    @TestSetup
    static void makeData(){
      Logger_Setting__mdt loggingMdt = new Logger_Setting__mdt(DeveloperName='TestComponent', Component_Name__c='TestComponent', Level__c='ERROR', Usesr_Ids__c='ALL');
      insert loggingMdt;
    }
}