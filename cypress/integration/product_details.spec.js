describe('jungle app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })
  it("Clicking a product opens the details page", () => {
    cy.get(".products a").first().click();
    cy.get(".products-show").should("have.length", 1);
  });
})
