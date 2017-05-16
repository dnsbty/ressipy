/* recipe.js */

let Recipe = {
  addIngredient: function(){
    let container = document.getElementById('ingredientsContainer');
    let key = container.getElementsByClassName('row').length;

    let row = document.createElement('div');
    row.className = "row";

    let amountContainer = document.createElement('div');
    amountContainer.className = 'form-group col-xs-3';

    let amountLabel = document.createElement('label');
    amountLabel.className = 'control-label';
    amountLabel.htmlFor = `recipe_ingredients_${key}_amount`;
    amountLabel.innerText = 'Amount';
    amountContainer.appendChild(amountLabel);

    let amountInput = document.createElement('input');
    amountInput.className = 'form-control';
    amountInput.id = `recipe_ingredients_${key}_amount`;
    amountInput.name = `recipe[ingredients][${key}][amount]`;
    amountInput.type = 'text';
    amountContainer.appendChild(amountInput);

    let nameContainer = document.createElement('div');
    nameContainer.className = 'form-group col-xs-9';

    let nameLabel = document.createElement('label');
    nameLabel.className = 'control-label';
    nameLabel.htmlFor = `recipe_ingredients_${key}_ingredient_name`;
    nameLabel.innerText = 'Name';
    nameContainer.appendChild(nameLabel);

    let nameInput = document.createElement('input');
    nameInput.className = 'form-control';
    nameInput.id = `recipe_ingredients_${key}_ingredient_name`;
    nameInput.name = `recipe[ingredients][${key}][ingredient][name]`;
    nameInput.htmlType = 'text';
    nameContainer.appendChild(nameInput);

    row.appendChild(amountContainer);
    row.appendChild(nameContainer);
    container.appendChild(row);
  },
  addInstruction: function() {
    let container = document.getElementById('instructionsContainer');
    let key = container.getElementsByClassName('form-group').length;

    let formGroup = document.createElement('div');
    formGroup.className = 'form-group';

    let orderElement = document.createElement('input');
    orderElement.id = `recipe_instructions_${key}_order`;
    orderElement.name = `recipe[instructions][${key}][order]`;
    orderElement.type = 'hidden';
    orderElement.value = key + 1;
    formGroup.append(orderElement);

    let inputGroup = document.createElement('div');
    inputGroup.className = 'input-group';
    formGroup.appendChild(inputGroup);

    let addon = document.createElement('span');
    addon.className = 'input-group-addon';
    addon.innerText = key + 1;

    let input = document.createElement('input');
    input.className = 'form-control';
    input.id = `recipe_instructions_${key}_text`;
    input.name = `recipe[instructions][${key}][text]`;
    input.htmlType = 'text';

    inputGroup.appendChild(addon);
    inputGroup.appendChild(input);
    container.appendChild(formGroup);
  }
}
export default Recipe;
