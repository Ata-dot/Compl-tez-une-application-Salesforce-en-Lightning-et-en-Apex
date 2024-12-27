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
        console.log('Term de recherche mis à jour:', this.searchTerm); // Debugging log
    }

    // Effectue une recherche des cases
    handleSearch() {
        console.log('Recherche initiée avec le terme:', this.searchTerm); // Debugging log

        // Validation de base pour éviter une recherche inutile
        if (!this.searchTerm.trim()) {
            this.error = 'Veuillez entrer un terme de recherche.';
            this.cases = [];
            console.log('Erreur - Terme de recherche vide:', this.error); // Debugging log
            return;
        }

        if (!this.recordId) {
            this.error = "L'identifiant du compte (recordId) est manquant.";
            this.cases = [];
            console.log('Erreur - recordId manquant:', this.error); // Debugging log
            return;
        }

        // Appel à Apex
        console.log('Appel à Apex avec recordId:', this.recordId, 'et searchTerm:', this.searchTerm); // Debugging log
        findCasesBySubject({ /*accountId: this.recordId,*/ subject: this.searchTerm })
            .then(result => {
                if (result.length === 0) {
                    this.error = 'Aucun cas trouvé pour ce terme de recherche.';
                    this.cases = [];
                    console.log('Aucun cas trouvé:', this.error); // Debugging log
                } else {
                    this.cases = result;
                    this.error = undefined;
                    console.log('Résultats trouvés:', this.cases); // Debugging log
                }
            })
            .catch((error) => {
                this.error = 'Une erreur est survenue lors de la recherche des cases.';
                this.cases = [];
                console.log('Erreur lors de l\'appel Apex:', error); // Debugging log
            });
    }
}
