<?php
/**
 * Noty - замена стандартных уведомлений
 *
 * Версия:	1.0.0
 * Автор:	Александр Вереник
 * Профиль:	http://livestreet.ru/profile/Wasja/
 * GitHub:	https://github.com/wasja1982/livestreet_noty
 *
 **/

class PluginNoty_HookNoty extends Hook {

    public function RegisterHook() {
        $this->AddHook('template_html_head_end', 'html_head_end');
    }

    public function html_head_end() {
        return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_noty.tpl');
    }
}
?>
