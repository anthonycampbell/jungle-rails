describe('jungle app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })
  it("Adding a product to cart is reflected in the cart", () => {
    cy.get('.end-0').should('contain.text', 'My Cart (0)')
    cy.get('.products').contains('Add').click({force: true});
    cy.get('.end-0').should('contain.text', 'My Cart (1)')
  });
})
