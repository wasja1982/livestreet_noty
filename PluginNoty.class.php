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

/**
 * Запрещаем напрямую через браузер обращение к этому файлу.
 */
if (!class_exists('Plugin')) {
    die('Hacking attemp!');
}

class PluginNoty extends Plugin {
    public function Activate() {
        return true;
    }


    public function Deactivate() {
        return true;
    }

    public function Init() {
        $this->Viewer_AppendScript(Plugin::GetTemplateWebPath(__CLASS__) . 'js/jquery.noty.packaged.min.js');
    }
}
?>