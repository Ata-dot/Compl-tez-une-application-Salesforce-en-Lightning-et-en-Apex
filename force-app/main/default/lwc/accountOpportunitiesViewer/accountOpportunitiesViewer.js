import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId; // ID de l'enregistrement de compte transmis par Salesforce
    @track opportunities; // Liste des opportunités
    @track error; // Objet d'erreur

    // Colonnes pour l'affichage des données
    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];

    // Appel à Apex via @wire
    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunities = data; // Affecte les données
            this.error = undefined; // Réinitialise les erreurs
        } else if (error) {
            this.error = error; // Stocke les erreurs
            this.opportunities = undefined; // Réinitialise les opportunités
        }
    }

    // Méthode pour rafraîchir manuellement les opportunités
    handleRafraichir() {
        if (this.recordId) {
            getOpportunities({ accountId: this.recordId })
                .then((data) => {
                    this.opportunities = data; // Affecte les données
                    this.error = undefined; // Réinitialise les erreurs
                })
                .catch((error) => {
                    this.error = error; // Stocke les erreurs
                    this.opportunities = undefined; // Réinitialise les opportunités
                });
        } else {
            console.error('recordId is not defined.'); // Journalise l'erreur si recordId n'est pas défini
        }
    }
}
