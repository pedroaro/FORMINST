!function(t){"use strict";var o=function(t,o){this.init("popover",t,o)};o.prototype=t.extend({},t.fn.tooltip.Constructor.prototype,{constructor:o,setContent:function(){var t=this.tip(),o=this.getTitle(),e=this.getContent();t.find(".popover-title")[this.options.html?"html":"text"](o),t.find(".popover-content")[this.options.html?"html":"text"](e),t.removeClass("fade top bottom left right in")},hasContent:function(){return this.getTitle()||this.getContent()},getContent:function(){var t=this.$element,o=this.options;return("function"==typeof o.content?o.content.call(t[0]):o.content)||t.attr("data-content")},tip:function(){return this.$tip||(this.$tip=t(this.options.template)),this.$tip},destroy:function(){this.hide().$element.off("."+this.type).removeData(this.type)}});var e=t.fn.popover;t.fn.popover=function(e){return this.each(function(){var n=t(this),i=n.data("popover"),p="object"==typeof e&&e;i||n.data("popover",i=new o(this,p)),"string"==typeof e&&i[e]()})},t.fn.popover.Constructor=o,t.fn.popover.defaults=t.extend({},t.fn.tooltip.defaults,{placement:"right",trigger:"click",content:"",template:'<div class="popover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'}),t.fn.popover.noConflict=function(){return t.fn.popover=e,this}}(window.jQuery);