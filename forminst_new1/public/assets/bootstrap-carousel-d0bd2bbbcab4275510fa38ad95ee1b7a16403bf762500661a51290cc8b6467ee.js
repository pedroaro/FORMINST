!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.$indicators=this.$element.find(".carousel-indicators"),this.options=i,"hover"==this.options.pause&&this.$element.on("mouseenter",t.proxy(this.pause,this)).on("mouseleave",t.proxy(this.cycle,this))};e.prototype={cycle:function(e){return e||(this.paused=!1),this.interval&&clearInterval(this.interval),this.options.interval&&!this.paused&&(this.interval=setInterval(t.proxy(this.next,this),this.options.interval)),this},getActiveIndex:function(){return this.$active=this.$element.find(".item.active"),this.$items=this.$active.parent().children(),this.$items.index(this.$active)},to:function(e){var i=this.getActiveIndex(),s=this;if(!(e>this.$items.length-1||e<0))return this.sliding?this.$element.one("slid",function(){s.to(e)}):i==e?this.pause().cycle():this.slide(e>i?"next":"prev",t(this.$items[e]))},pause:function(e){return e||(this.paused=!0),this.$element.find(".next, .prev").length&&t.support.transition.end&&(this.$element.trigger(t.support.transition.end),this.cycle(!0)),clearInterval(this.interval),this.interval=null,this},next:function(){if(!this.sliding)return this.slide("next")},prev:function(){if(!this.sliding)return this.slide("prev")},slide:function(e,i){var s,n=this.$element.find(".item.active"),a=i||n[e](),r=this.interval,l="next"==e?"left":"right",o="next"==e?"first":"last",h=this;if(this.sliding=!0,r&&this.pause(),a=a.length?a:this.$element.find(".item")[o](),s=t.Event("slide",{relatedTarget:a[0],direction:l}),!a.hasClass("active")){if(this.$indicators.length&&(this.$indicators.find(".active").removeClass("active"),this.$element.one("slid",function(){var e=t(h.$indicators.children()[h.getActiveIndex()]);e&&e.addClass("active")})),t.support.transition&&this.$element.hasClass("slide")){if(this.$element.trigger(s),s.isDefaultPrevented())return;a.addClass(e),a[0].offsetWidth,n.addClass(l),a.addClass(l),this.$element.one(t.support.transition.end,function(){a.removeClass([e,l].join(" ")).addClass("active"),n.removeClass(["active",l].join(" ")),h.sliding=!1,setTimeout(function(){h.$element.trigger("slid")},0)})}else{if(this.$element.trigger(s),s.isDefaultPrevented())return;n.removeClass("active"),a.addClass("active"),this.sliding=!1,this.$element.trigger("slid")}return r&&this.cycle(),this}}};var i=t.fn.carousel;t.fn.carousel=function(i){return this.each(function(){var s=t(this),n=s.data("carousel"),a=t.extend({},t.fn.carousel.defaults,"object"==typeof i&&i),r="string"==typeof i?i:a.slide;n||s.data("carousel",n=new e(this,a)),"number"==typeof i?n.to(i):r?n[r]():a.interval&&n.pause().cycle()})},t.fn.carousel.defaults={interval:5e3,pause:"hover"},t.fn.carousel.Constructor=e,t.fn.carousel.noConflict=function(){return t.fn.carousel=i,this},t(document).on("click.carousel.data-api","[data-slide], [data-slide-to]",function(e){var i,s,n=t(this),a=t(n.attr("data-target")||(i=n.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,"")),r=t.extend({},a.data(),n.data());a.carousel(r),(s=n.attr("data-slide-to"))&&a.data("carousel").pause().to(s).cycle(),e.preventDefault()})}(window.jQuery);