// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-2.1.3.min
//= require bootstrap
//= require_tree .
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js

function fecha(){
	var fecha=new Date()
	var ano=fecha.getYear()
	if (ano < 1000)
	ano+=1900
	var dia=fecha.getDay()
	var mes=fecha.getMonth()
	var diaS=fecha.getDate()
	if (diaS<10)
	diaS="0"+diaS
	var diassemana=new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sabado")
	var meses=new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
	$('#fechamuestra').append("<h4>"+diassemana[dia]+", "+diaS+" de "+meses[mes]+" de "+ano+"</h4>")
}