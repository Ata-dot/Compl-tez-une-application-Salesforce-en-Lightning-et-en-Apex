import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track error = {};
    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];

    @wire(getOpportunities, { '$accountId': recordId }) //error
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunities = data;
            this.error= undefined
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
        }
    }
handleRafraichir() {
    getOpportunities()
    .then((data) => {
        this.opportunities = data;
        this.error = undefined;
    })
    .catch((error) => {
        this.error = error;
        this.opportunities = undefined;
    });
}
}
