$(".dropdown-menu li a").click(function(){
	var textoClickeado = $(this).text();
	var textoVisible = $(this).parents(".dropdown").children('link_to').text();
	$(this).parents(".dropdown").children('link_to').html(textoClickeado.concat(" <span class='caret'></span>"));
	$(this).text(textoVisible);
});