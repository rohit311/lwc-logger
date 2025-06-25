@isTest
public with sharing class LoggingServiceTest {
    @isTest
    static void testCheckIfLoggingIsEnabled() {
      System.Test.startTest();

      Map<String, String> loggingMap = LoggingService.getLoggingMetadata('');
      Assert.areNotEqual(null, loggingMap, 'Logging data should not be null');
      Assert.areEqual('false', loggingMap.get('isLoggingEnabled'), 'Logging should be disabled');

      loggingMap = LoggingService.getLoggingMetadata('Test');
      Assert.areNotEqual(null, loggingMap, 'Logging data should not be null');
      Assert.areEqual('true', loggingMap.get('isLoggingEnabled'), 'Logging should be enabled');

      System.Test.stopTest();
    }

    @isTest
    static void testCreateLogs() {
      Map<String, String> fieldsMap = new Map<String, String>();
      fieldsMap.put('componentName', 'Test');
      fieldsMap.put('level', 'INFO');
      fieldsMap.put('message', 'Test message');

      System.Test.startTest();

      LoggingService.createLoggingRecords(fieldsMap);

      System.Test.stopTest();

      Log_Event__c loggingRecord = [SELECT Id, Component_Name__c, Level__c, Message__c FROM Log_Event__c LIMIT 1];
      Assert.areEqual('Test' ,loggingRecord.Component_Name__c, 'Name of the logging record created should match component name');
      Assert.areEqual('INFO' ,loggingRecord.Level__c, 'Logging level should match');
    }
}