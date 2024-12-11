function mostrarPrecio(IdCasa) {

    var inputPrecio = document.getElementById("PrecioCasa");

    $.ajax({
        url: '/Casas/ConsultarPrecioCasa',
        type: 'GET',
        dataType: 'json',
        data: {
            "IdCasa": IdCasa,
        },
        success: function (data) {
            if (data != null) {
                inputPrecio.value = data;
            }
        }
    });

}