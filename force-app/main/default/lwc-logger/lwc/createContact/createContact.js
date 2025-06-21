import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import {fetchLoggingData, logAction} from 'c/utils';

export default class CreateContact extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    fieldMap = {level: 'INFO', componentName: 'CreateContact'};
    @track loggingMetaData = {};
    boundLogAction = logAction.bind(this);

    async connectedCallback() {
      this.loggingMetaData = await fetchLoggingData(this.fieldMap.componentName);
      console.log("loggingMetaData:: ", this.loggingMetaData.isLoggingEnabled);
    }

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }
    handleEmailChange(event) {
        this.email = event.target.value;
    }
    handlePhoneChange(event) {
        this.phone = event.target.value;
    }

    createContact() {
      console.log("In createContact");
      this.boundLogAction({
        componentName: this.fieldMap.componentName,
        level: "INFO",
        message: "In Create Contact"
      }, this.loggingMetaData);
      const fields = {};
      fields[FIRSTNAME_FIELD.fieldApiName] = this.firstName;
      fields[LASTNAME_FIELD.fieldApiName] = this.lastName;
      fields[EMAIL_FIELD.fieldApiName] = this.email;
      fields[PHONE_FIELD.fieldApiName] = this.phone;

      const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };

      createRecord(recordInput)
          .then(contact => {
              alert(`Contact created with Id: ${contact.id}`);
              this.firstName = '';
              this.lastName = '';
              this.email = '';
              this.phone = '';
          })
          .catch(error => {
              console.error('Error creating contact:', error.body.message);
              alert(`Error: ${error.body.message}`);
              this.boundLogAction({
                componentName: this.fieldMap.componentName,
                level: "ERROR",
                message: error.body.message,
                stacktrace: error.stack
              }, this.loggingMetaData);
          });
    }
}