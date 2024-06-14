<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Custom Dropdown with Select2</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0/css/select2.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0/js/select2.full.min.js"></script>
</head>
<body>

<select id="multiSelect" multiple>
    <option value="option1">Option 1</option>
    <option value="option2">Option 2</option>
    <option value="option3">Option 3</option>
    <option value="option4">Option 4</option>
    <option value="option5">Option 5</option>
    <option value="option6">Zebra</option>
    <option value="option7">Zoo</option>
    <!-- Add more options as needed -->
</select>

<script>
    $(document).ready(function() {
        $('#multiSelect').select2({
            matcher: function(term, text) {
                // Case-insensitive matching for the typed term
                return text.toUpperCase().indexOf(term.toUpperCase()) == 0;
            }
        });
    });
</script>

</body>
</html>
