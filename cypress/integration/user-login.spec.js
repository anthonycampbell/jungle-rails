describe('jungle app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })
  it("Logging in correctly takes a user to the home page", () => {
    cy.get('.navbar').contains('Login').click()
    cy.get("[data-testid=login-email]").type('joe@gmail.com')
    cy.get("[data-testid=login-password]").type('somepass')
    cy.get('input').contains('Submit').click()
    cy.get('.navbar').should("contain.text", "Signed in as Joe")
  });
  it("Signing up correctly takes a user to the home page", () => {
    cy.get('.navbar').contains('Signup').click()
    cy.get("[data-testid=signup-first-name]").type('peter')
    cy.get("[data-testid=signup-last-name]").type('portugal')
    cy.get("[data-testid=signup-email]").type('pete@apple.com')
    cy.get("[data-testid=signup-password]").type('newpass')
    cy.get("[data-testid=signup-password-confirmation]").type('newpass')
    cy.get('input').contains('Submit').click()
    cy.get('.navbar').should("contain.text", "Signed in as peter")
  });
})
