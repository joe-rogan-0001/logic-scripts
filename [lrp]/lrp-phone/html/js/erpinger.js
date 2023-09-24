$(document).ready( function() {
    $("#pinger_button").click(function() {
        let id = $("#pingerid").val()
        $.post('https://lrp-phone/pingSend', JSON.stringify({
            number: id,
        }));
    })

    $("#cam_button").click(function() {
        $.post('https://lrp-phone/TakePhotoButton', JSON.stringify({}),function(url){
            setUpCameraApp(url)
        })
        QB.Phone.Functions.Close();
    })
})