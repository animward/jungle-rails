/// <reference types="cypress" />

describe('jungle store', () => {
  describe('home page', () => {
    beforeEach(() => {
      // Cypress starts out with a blank slate for each test
      // so we must tell it to visit our website with the `cy.visit()` command.
      // Since we want to visit the same URL at the start of all our tests,
      // we include it in our beforeEach function so that it runs before each test
      cy.visit('http://localhost:3000/');
    });
    it('There is products on the page', () => {
      cy.get('.products article').should('be.visible');
    });
    describe('clicking Add button on product', () => {
      it('changes the number of items shown in My Cart', () => {
        cy.contains('My Cart (0)').should('exist');
        cy.get('article button').first().click({force: true});
        cy.contains('My Cart (1)').should('exist');
      })
    });
  });
});