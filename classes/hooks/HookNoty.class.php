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
        $this->AddHook('template_html_head_end', 'body_begin');
        $this->AddHook('template_profile_whois_item_after_privat', 'profile_whois_item_after_privat');
    }

    public function html_head_end() {
        return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_noty.tpl');
    }

    public function body_begin() {
        return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_mp3.tpl');
    }

    public function profile_whois_item_after_privat($aVar) {
        $oUserCurrent = $this->User_GetUserCurrent();
        $oUserProfile = $aVar['oUserProfile'];
        if ($oUserProfile && $oUserCurrent && $oUserProfile->getId() == $oUserCurrent->getId()) {
            return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_profile.tpl');
        }
    }
}
?>
