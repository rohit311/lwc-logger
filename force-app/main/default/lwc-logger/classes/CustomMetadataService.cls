public with sharing class CustomMetadataService {
    private String cmdtName;
    private String cmdtRecordName;
    private String cmdtRecordLabel;
    private Map<String, String> fieldValues;

    public CustomMetadataService(String cmdtName, String cmdtRecordName, String cmdtRecordLabel, Map<String, String> fieldValues) {
      this.cmdtName = cmdtName;
      this.cmdtRecordName = cmdtRecordName;
      this.cmdtRecordLabel = cmdtRecordLabel;
      this.fieldValues = fieldValues;
    }


    public String createCustomMetadataRecord() {
      Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
      customMetadata.fullName = this.cmdtName + '.' + this.cmdtRecordName;
      customMetadata.label = this.cmdtRecordLabel;

      List<Metadata.CustomMetadataValue> cmdtFields = this.generateCmdtFieldValues();

      customMetadata.values.addAll(cmdtFields);

      return deployMetadata(customMetadata);

    }

    private List<Metadata.CustomMetadataValue> generateCmdtFieldValues() {
      List<Metadata.CustomMetadataValue> cmdtfields = new List<Metadata.CustomMetadataValue>();

      if (this.fieldValues.isEmpty()) {
        throw new CustomMetadataServiceException('No field values where added');
      }

      for (String fieldName : this.fieldValues.keySet()) {
          Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
          customField.field = fieldName;
          customField.value = this.fieldValues.get(fieldName);

          cmdtfields.add(customField);
      }

      return cmdtfields;
    }

    private String deployMetadata(Metadata.CustomMetadata customMetadata) {
      Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
      mdContainer.addMetadata(customMetadata);

      MetadataDeployCallback callback = new MetadataDeployCallback();

      Id deployRequestId = Metadata.Operations.enqueueDeployment(mdContainer, callback);

      return deployRequestId;

    }

    public class CustomMetadataServiceException extends Exception {}
}