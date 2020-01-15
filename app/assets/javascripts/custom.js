$(document).ready(function(){
    $('#typeahead').typeahead({
        source: function (query, process) {
            return $.getJSON(
                '/autocomplete',
                { q: query },
                function (data) {
                    return process(data);
                })
        },
        delay:200    
    });
})