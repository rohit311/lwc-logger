import { LightningElement } from 'lwc';

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

  }

  get options() {
    return [
        { label: 'ERROR', value: 'ERROR' },
        { label: 'INFO', value: 'INFO' },
        { label: 'FINE', value: 'FINE' },
    ];
  }
}