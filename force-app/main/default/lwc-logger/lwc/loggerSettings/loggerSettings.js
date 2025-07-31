import { LightningElement } from 'lwc';
import LightningToast from "lightning/toast";
import createCustomMetadataRecord from '@salesforce/apex/LoggerSettingsController.createCustomMetadataRecord';

export default class LoggerSettings extends LightningElement {
  horizontalAlign = "space";
  spreadAlign = "spread";
  metaDataLabel = "";
  metaDataName = "";
  metaDataComponentName = "";
  metaDataLevel = "";
  metaDataUserIds = "";
  fieldNameMap = "";
  recordIsProtected = false;

  handleInputFieldChange(event) {
    const fieldName = event.target.getAttribute('data-prop-name');
    const fieldValue = event.target.value;

    if (fieldName === "label") {
      this.metaDataLabel = fieldValue;
    } else if (fieldName === "name") {
      this.metaDataName = fieldValue;
    } else if (fieldName === "componentName") {
      this.metaDataComponentName = fieldValue;
    } else if (fieldName === "userIds") {
      this.metaDataUserIds = fieldValue;
    } else if (fieldName === "protected") {
      this.recordIsProtected = event.target.checked;
    }
  }

  handleLevelChange(event) {
    this.metaDataLevel = event.detail.value;
  }

  handleSaveBtnClick() {
    const fieldsMap = {};
    fieldsMap['componentName'] = this.metaDataComponentName;
    fieldsMap['level'] = this.metaDataLevel;
    fieldsMap['userIds'] = this.metaDataUserIds;
    fieldsMap['recordName'] = this.metaDataName;
    fieldsMap['recordLabel'] = this.metaDataLabel;
    fieldsMap['protected'] = this.recordIsProtected;

    createCustomMetadataRecord({fieldsMap: fieldsMap})
    .then(result => {
      console.log("result: ", result);

      LightningToast.show({
            label: 'Success',
            message: 'The record has been saved!',
            variant: 'success',
            mode: 'dismissable'
        });

      setTimeout(() => {
        this.resetForm();
      }, 2000);
    })
    .catch(error => {
      console.log("error: ", error);
    })
  }

  resetForm() {
    this.metaDataLabel = "";
    this.metaDataName = "";
    this.metaDataComponentName = "";
    this.metaDataLevel = "";
    this.metaDataUserIds = "";
    this.recordIsProtected = false;
  }

  get options() {
    return [
        { label: 'ERROR', value: 'ERROR' },
        { label: 'INFO', value: 'INFO' },
        { label: 'FINE', value: 'FINE' },
    ];
  }
}
