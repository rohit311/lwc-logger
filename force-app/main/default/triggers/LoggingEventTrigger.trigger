trigger LoggingEventTrigger on Log__e (after insert) {
  if (Trigger.isAfter && Trigger.isInsert) {
    LoggingEventTriggerHandler.afterInsertHandler(Trigger.new);
  }
}