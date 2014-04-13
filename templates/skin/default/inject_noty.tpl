{literal}<script type="text/javascript">
    String.prototype.hashCode = function() {
        var hash = 0, i, chr, len;
        if (this.length == 0) return hash;
        for (i = 0, len = this.length; i < len; i++) {
            chr   = this.charCodeAt(i);
            hash  = ((hash << 5) - hash) + chr;
            hash |= 0;
        }
        return hash;
    };

    jQuery(document).ready(function($){
        $.notifier.closeMessage = function(message) {
            var hash = message.hashCode();
            var messages = window.localStorage.getItem('noty_close_messages');
            messages = (messages != null ? messages.split('|') : []);
            var found = false;
            var time = Math.round(new Date().getTime() / 1000);
            for (var i = 0, l = messages.length; i < l; l--) {
                var message = messages[l-1];
                var info = message.split('=');
                if (Number(info[0]) == hash) {
                    found = true;
                    break;
                } else if (Number(info[1]) < time) {
                    messages.splice(l-1,1);
                }
            }
            if (!found) {
                messages.push(hash + '=' + (time + 300));
                window.localStorage.setItem('noty_close_messages', messages.join('|'));
            }
        };
        $.notifier.broadcast = function(title, message, type){
            var template = '<div class="noty_message '+ this.options.box_class + (type != null ? ' ' + type : '') + '"><span class="noty_text"></span><div class="noty_close"></div></div>';
            var text = (title != null ? '<h3>' + title + '</h3>' : '') + '<p>' + message + '</p>';
            var animation = {
                open: {height: 'toggle'},
                close: {height: 'toggle'},
                easing: 'swing',
                speed: 0
            };
            var callback = {
                onShow: function() {},
                afterShow: function() {},
                onClose: function() {},
                afterClose: function() {}
            };
            switch (type) {
                case $.notifier.options.notice_class:
                case $.notifier.options.error_class:
                    var timeout = $.notifier.options.duration;
                    break;
                default:
                    var timeout = false;
                    callback.afterClose = function() {
                        $.notifier.closeMessage(text);
                    };
                    if ($("#beep").length) {
                        var beep = $("#beep")[0];
                        beep.volume = 0.4;
                        beep.play();
                    }
                    break;
            }
            $.notifier.core();
            var box = $("#" + $.notifier.options.core).noty({layout: 'topRight', timeout: timeout, theme: 'blankTheme', animation: animation, template: template, text: text, callback: callback});
            if (box && type != $.notifier.options.notice_class && type != $.notifier.options.error_class) {
                var now = new Date();
                var h = now.getHours(); h = (h < 10 ? '0' : '') + h;
                var m = now.getMinutes(); m = (m < 10 ? '0' : '') + m;
                var s = now.getSeconds(); s = (s < 10 ? '0' : '') + s;
                var time = '<b>[' + h + ':' + m + ':' + s + ']</b> ';
                var text_box = box.$bar.find('.noty_text > p').first();
                text_box.html(time + text_box.html());
            }
        };
        $(window).bind('storage', function (e) {
            var evt = e.originalEvent;
            if (evt != null && evt.key == 'noty_close_messages') {
                var messages = evt.newValue;
                messages = (messages != null ? messages.split('|') : []);
                var time = Math.round(new Date().getTime() / 1000);
                var hashes = [];
                for (var i = 0, l = messages.length; i < l; l--) {
                    var message = messages[l-1];
                    var info = message.split('=');
                    if (Number(info[1]) >= time) {
                        hashes.push(info[0]);
                    }
                }
                $.each($.noty.store, function (id, noty) {
                    var hash = noty.options.text.hashCode();
                    for (var i = 0, l = hashes.length; i < l; l--) {
                        if (Number(hashes[l-1]) == hash) {
                            noty.close();
                            break;
                        }
                    }
                });
            }
        });
    });
</script>{/literal}