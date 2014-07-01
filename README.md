# Form validator

This is a vanilla javascript class for validating form fields easily.

## Instroduction

First you have to compile the Validator.coffee using [Coffee Script](http://coffeescript.org). documentation on installing and usage can be found at their website.

To compile Validator you'll have to write this in the terminal.

	coffee -c -b path/to/Validator.coffee
	
This will create a compiled version of Validator. Please notice that the `bare` option is required to provide in order for it to work properly.

The whole concept behind this validator is that it's *stupid*. I doesn't do anything like adding classes, showing error messages or similar. That process of notifying the user it's totally up to you, and should be up to you. 

## Example Usage

**Markup**

Each input field with a `data-validation-rules` attribute gets validated.   
Validator returns an array with the fields that did not validate.

Each rule is seperated with a `|` (pipe). Some rules requires a parameter seperated by a `:` (colon).

	<form action="/" method="POST" id="form">
		<input name="name" data-validation-rules="required">
		<input name="age" data-validation-rules="required|numeric">
	</form>

**Example**

	var form = document.getElementById('form');
	
	form.addEventListener('submit', function (e) {
		var validator = new Validator(form);
		
		if (validator.length > 0) {
			e.preventDefalut();
			
			for (i=1;i<validator.lenght;i++) {
				validator[i].className = validator[i].className + " error";
			}
		}
				
	});
	
**Example using jQuery**

	$('#form').on('submit', function (e) {
		var validator = new Validator(this);
		
		if (validator.length > 0) {
			e.preventDefalut();
			
			$.each(validator, function () {
				$(this).addClass('error');
			});
		}
	});

## Validation rules

* required
* min:{num}
* max:{num}
* excact:{num}
* email
* regex:{pattern}
* numeric
* alpha
* alphanumeric
* boolean `("0", "1", "true", "false")`

If the `required` rule is not set, the field won't be validated unless it got a value. This means that a field only is validated as failed if the field has a value and dosent match the rule pattern.

## Validating a single input

To validate a single input field you can user the `validateField` method which accepts a input field, like with the form example above.

This method returns boolean agaist the `data-validation-rules` attribute.

## Extending

To extend Validator you simply need to pass in a functions that follows the rule pattern, like this:

	Validator.prototype.validatemyrule = function (field, rule) {
		return field.value.trim() === 'foobar';
	}
	
In the rule above the rule `myrule` has been made available for your fields. All rules follows the pattern of `validate{rule}` where `{rule}` is replaced with the name of your rule.

That means that you can now use your custom rule like so:

	<input type="text" name="foo" data-validation-rules="required|myrule">

## License

Validator is published under the MIT license, which means that you can do pretty much enything you wanna do with it. See the `LICENSE` file for more information.
