import { LightningElement, track, api } from 'lwc';
import findCasesBySubject from '@salesforce/apex/AccountCasesController.findCasesBySubject';

// Colonnes du tableau
const COLUMNS = [
    { label: 'Sujet', fieldName: 'Subject', type: 'text' },
    { label: 'Statut', fieldName: 'Status', type: 'text' },
    { label: 'Priorité', fieldName: 'Priority', type: 'text' },
];

export default class AccountCaseSearchComponent extends LightningElement {
    @api recordId; // ID du compte actuel
    @track cases = []; // Liste des cases
    @track error; // Stocke les erreurs éventuelles
    searchTerm = ''; // Terme de recherche
    columns = COLUMNS; // Colonnes du tableau

    // Met à jour le terme de recherche
    updateSearchTerm(event) {
        this.searchTerm = event.target.value;
    }

    // Effectue une recherche des cases
    handleSearch() {
        // Validation de base pour éviter une recherche inutile
        if (!this.searchTerm.trim()) {
            this.error = 'Veuillez entrer un terme de recherche.';
            this.cases = [];
            return;
        }

        if (!this.recordId) {
            this.error = "L'identifiant du compte (recordId) est manquant.";
            this.cases = [];
            return;
        }

        // Appel à Apex
        findCasesBySubject({ accountId: this.recordId, subjectSearchTerm: this.searchTerm })
            .then(result => {
                if (result.length === 0) {
                    this.error = 'Aucun cas trouvé pour ce terme de recherche.';
                    this.cases = [];
                } else {
                    this.cases = result;
                    this.error = undefined;
                }
            })
            .catch(() => {
                this.error = 'Une erreur est survenue lors de la recherche des cases.';
                this.cases = [];
            });
    }
}
