public with sharing class LoggingService {

  private static Logger_Setting__mdt getLoggingMdtByName(String loggingComponentName) {
    return Logger_Setting__mdt.getInstance(loggingComponentName);
  }

  private static Boolean checkIfLoggingIsEnabled(Logger_Setting__mdt loggingMdt) {

    if (loggingMdt == null) {
      return null;
    }

    String userIdsEnabledForLogging = loggingMdt.Usesr_Ids__c.trim();
    Boolean isLoggingEnabledForUser = userIdsEnabledForLogging.equalsIgnoreCase('ALL') ||
        userIdsEnabledForLogging.containsIgnoreCase(String.valueOf(UserInfo.getUserId()).left(15));

    return isLoggingEnabledForUser;

  }

  private static String fetchLoggingLevel(Logger_Setting__mdt loggingMdt) {
    if (loggingMdt == null) {
      return '';
    }

    if (String.isNotBlank(loggingMdt.Level__c)) {
      return loggingMdt.Level__c;
    }

    return '';
  }

  @AuraEnabled
  public static Map<String, String> getLoggingMetadata(String componentName) {
    Map<String, String> loggingMap = new Map<String, String>();
    Logger_Setting__mdt loggingMdt = getLoggingMdtByName(componentName);

    System.debug('loggingMdt: '+loggingMdt);
    try {
      Boolean isLoggingEnabledForUser = checkIfLoggingIsEnabled(loggingMdt);
      loggingMap.put(
        'isLoggingEnabled',
        String.valueOf(isLoggingEnabledForUser)
      );

      String loggingLevel = fetchLoggingLevel(loggingMdt);
      loggingMap.put('loggingLevel', loggingLevel);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }

    System.debug('loggingMap: '+loggingMap);
    return loggingMap;
  }

  @AuraEnabled
  public static void createLoggingRecords(Map<String, String> fieldsMap) {
    Logger.getInstance().createLogs(fieldsMap);
  }
}