import getLoggingMetadata from "@salesforce/apex/LoggingService.getLoggingMetadata";
import createLoggingRecords from "@salesforce/apex/LoggingService.createLoggingRecords";

const LOG_LEVELS_MAP = { ERROR: 1, INFO: 2, FINE: 3 };

const fetchLoggingData = async (componentName) => {

    try {
      const loggingMdt = await getLoggingMetadata({componentName: componentName});
      console.log("getLoggingMetadata:: ", loggingMdt);
      return loggingMdt;
    } catch (e) {
      console.log(e);
    }

    return null;
};

const logAction = async (fieldMap, loggingMetadata = {}) => {
  const {level} = fieldMap;

  try {
    let loggingMdt = loggingMetadata;

    if (!loggingMetadata) {
      loggingMdt = await fetchLoggingData(fieldMap.componentName);
    }

    if (!loggingMdt) {
      console.log('%cError: Logging not enabled or empty logging metadata passed!', 'color: red; font-weight: bold; background: #ffeeee; padding: 2px 4px; border: 1px solid red;');

      return;
    }

    let isLogLevelEnabled =
          LOG_LEVELS_MAP[loggingMdt?.loggingLevel] >=
          LOG_LEVELS_MAP[level];

    console.log("isLogLevelEnabled: ", loggingMdt?.isLoggingEnabled?.toUpperCase());
    if (isLogLevelEnabled && loggingMdt.isLoggingEnabled &&
        loggingMdt?.isLoggingEnabled?.toUpperCase() === "TRUE"
      ) {
      await createLoggingRecords({fieldsMap: fieldMap});
    }


  } catch(e) {
    console.log(e);
  }
};

export {
  fetchLoggingData,
  logAction
};