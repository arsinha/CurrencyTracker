/**
 * Created by JetBrains RubyMine.
 * User: weblogic
 * Date: 9/15/11
 * Time: 11:04 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {
    $('#country_form').bind('ajax:success', function(data) {
        alert("Successfully updated");
    });
})
