public without sharing class Logger {
  private static Logger LOGGER_INSTANCE = null;
  private Boolean allowMultiple = false;
  private List<Log__e> logEvents;

  public Logger() {}

  private Logger(Boolean inMultiple) {
    this.allowMultiple = inMultiple;
    this.logEvents = new List<Log__e>();
  }

  public static Logger getInstance(Boolean inMultiple) {
    if (LOGGER_INSTANCE == null) {
      LOGGER_INSTANCE = new Logger(inMultiple);
    }
    return LOGGER_INSTANCE;
  }

  public static Logger getInstance() {
    return Logger.getInstance(false);
  }

  public void createLogs(Map<String, String> fieldsMap) {
    System.debug('fieldsMap :'+fieldsMap);
    if (fieldsMap != null && !fieldsMap.isEmpty()) {
      Log__e logRecord = new Log__e();
      logRecord.Component_Name__c = fieldsMap.get('componentName');
      logRecord.Current_User__c = UserInfo.getUserId();
      logRecord.Level__c = fieldsMap.get('level');
      logRecord.Message__c = fieldsMap.get('message');
      logRecord.Object_Ids__c = fieldsMap.get('objectids');
      logRecord.Stack_Trace__c = fieldsMap.get('stacktrace');

      if (this.allowMultiple) {
        logEvents.add(logRecord);
      } else {
        EventBus.publish(logRecord);
      }
    }
  }
}