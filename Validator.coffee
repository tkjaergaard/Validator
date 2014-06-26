class Validator

    constructor: (form) ->
        @form = form
        return @validate()

    validate: ->
        fields = @form.querySelectorAll 'input[data-validation-rules], textarea[data-validation-rules]'
        _results = []

        for field in fields
            validation = @validateField field
            if(validation)
                _results.push validation

        return _results

    validateField: (field) ->
        rules = field.getAttribute('data-validation-rules')
        regex = /([a-z]+)/

        if (rules.indexOf('required') < 0 && field.value.trim().length < 1) || !rules
            return false

        rules = rules.split('|')

        for rule in rules
            method = regex.exec(rule)[0]
            validation = this['validate' + method](field, rule)
            if !validation
                return field

    validaterequired: (field, rule) ->
        return !!field.value.trim().length;

    validatemin: (field, rule) ->
        min = parseInt(rule.split(':')[1])

        return !!field.value.trim().length >= min

    validatemax: (field, rule) ->
        max = parseInt(rule.split(':')[1])
        return !!field.value.trim().length <= max

    validateexcact: (field, rule) ->
        excact = parseInt(rule.split(':')[1])
        return !!field.value.trim().length == excact

    validateemail: (field, rule) ->
        return !!field.value.trim().match(/[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[a-z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b/)

    validateregex: (field, rule) ->
        pattern = rule.split(':')[1];
        return !!field.value().trim().match(pattern)

    validatenumeric: (field, rule) ->
        return !isNaN(field.value.trim())

    validatealpha: (field, rule) ->
        return !!field.value.trim().match(/^[a-zA-Z]+$/)

    validatealphanumeric: (field, rule) ->
        return !!field.value.trim().match(/^[a-zA-Z0-9]+$/)

    validateboolean: (field, rule) ->
        return !!field.value.trim().match(/^(true|false|1|0)$/)