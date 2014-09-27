<div class="profile-info-me">
    <h2 class="header-table">{$aLang.plugin.noty.profile}</h2>
    <p><label for="beep_disable"><input type="checkbox" id="beep_disable" name="beep_disable" class="input-checkbox" onchange="toggleBeepDisable(this); return false;" /> {$aLang.plugin.noty.beep}</label></p>
</div>

{literal}<script type="text/javascript">
    function toggleBeepDisable(element) {
        $.cookie('noty_beep_disable', (element.checked ? 1 : null), { 'path': '/' });
    }

    jQuery(document).ready(function($){
        $('#beep_disable').prop('checked', ($.cookie('noty_beep_disable') ? true : false));
    });
</script>{/literal}