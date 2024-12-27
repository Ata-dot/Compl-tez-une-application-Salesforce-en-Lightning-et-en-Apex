import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';
import { refreshApex } from '@salesforce/apex'; 



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
        opportunitiesResult;
    // Appel à Apex via @wire
    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities( result ) {
      this.opportunitiesResult = result; 
      const { data, error } = result;     
        if (data) {
            this.opportunities = data; // Affecte les données
            this.error = undefined; // Réinitialise les erreurs
            console.log('Opportunités récupérées:', this.opportunities); // Log des données récupérées
        } else if (error) {
            this.error = error; // Stocke les erreurs
            this.opportunities = undefined; // Réinitialise les opportunités
            console.error('Erreur lors de la récupération des opportunités:', error); // Log de l'erreur
        }
    }

    // Méthode pour rafraîchir manuellement les opportunités
    handleRafraichir() {
        console.log('Tentative de rafraîchissement des opportunités pour recordId:', this.recordId); // Log avant l'appel
        try {
            return refreshApex(this.opportunitiesResult); //Appel à la méthode refreshApex
        } catch (error) {
            console.error('Erreur lors du rafraîchissement des opportunités:', error); // Log de l'erreur
        }      
    }
}
