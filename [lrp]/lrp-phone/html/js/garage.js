let veh

$(document).on('click', '.garage-vehicle', function(e){
    e.preventDefault();

    $(".garage-homescreen").animate({
        left: 30+"vh"
    }, 200);
    $(".garage-detailscreen").animate({
        left: 0+"vh"
    }, 200);

    var Id = $(this).attr('id');
    var VehData = $("#"+Id).data('VehicleData');
    veh = VehData
    SetupDetails(VehData);
});

String.prototype.ucwords = function() {
    str = this.trim();
    return str.replace(/(^([a-zA-Z\p{M}]))|([ -][a-zA-Z\p{M}])/g, function(s){
        return s.toUpperCase();
    });
};

SetupGarageVehicles = function(Vehicles) {
    id = 0
    GarageData=[]
    $("#cars_list").empty()
    
    if(Vehicles == null) {
        $("#nothing-here-lmao").show()
    }

    $(Vehicles).each(function(k,v){
        let icon = 'fas fa-car'
        
        id = id +1
        GarageData[id] = []
        GarageData[id].push(Vehicles[k])

        $("#cars_list").append(`
        
        <div class="car-shit" data-id=${id}>
        <i class="profileicon ${icon}"></i>
        <p class="p" style="margin-top: 1.7vmin">${v.plate}</p>
        <p class="p" id="contact-phonenum" style="margin-top: 1.0vmin">${v.model.ucwords()}</p>
        <p class="p"  style="position:absolute;top:2vh;left: 87%">${v.state}</p>
      </div>
      `)
    })
    
    $("#search_vehicle_garage").keyup(function() {
        $("#nothing-here").hide()

        var filter = $(this).val(),
            count = 0;
        $('.car-shit').each(function() {
            if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).hide(); // MY CHANGE
            } else {
                $(this).show(); // MY CHANGE
                count++;
            }
            if (count == 0) {
                $("#nothing-here-lmao").show()
            } else {
                $("#nothing-here-lmao").hide()

            }

        });

    });
}

$(document).on("click",".car-shit",function() {
    let clickedid = $(this).data('id')
    if($(this).hasClass("expanded")) {
     $(`#car-data[data-id=${clickedid}]`).remove()
     document.querySelector('div').classList.remove('oldClass') ;

        $(this).removeClass('expanded');
        $(this).closest('#car-data').remove();
   
    } else {
     $(`#car-data[data-id=${clickedid}]`).remove()

     $(this).closest('#car-data').remove();
     $(this).addClass('expanded');
     $(this).append(`<div id="car-data" data-id=${clickedid}>
     <div style="
     align-items: center;
     display: flex;">
     <i style="margin-left: 0.5vh" class="fas fa-map-marker-alt"></i><p style="padding-left:1vmin;font-size:15px">${GarageData[clickedid][0]['garage'] || "Couldn't track the street name"}</p>
     </div>
     <hr style="margin-top: -0.8vh">
     <div style="
     align-items: center;
     display: flex;">
     <i style="margin-left: 0.5vh" class="fas fa-closed-captioning"></i><p style="padding-left:1vmin;font-size:15px">${GarageData[clickedid][0]['plate']}</p>
     </div>
     <hr style="margin-top: -0.8vh">
     <div style="
     align-items: center;
     display: flex;">
     <i style="margin-left: 0.5vh" class="fas fa-oil-can"></i><p style="padding-left:1vmin;font-size:15px">${GarageData[clickedid][0]['fuel']}%</p>
     </div>
     <hr style="margin-top: -0.8vh">
     <div style="
     align-items: center;
     display: flex;">
     <i style="margin-left: 0.5vh" class="fas fa-car-crash"></i><p style="padding-left:1vmin;font-size:15px">${GarageData[clickedid][0]['body'] / 10}%</p>
     </div>
     <hr style="margin-top: -0.8vh">
 
     <button data-id=${clickedid} style="position: releative; top:102%; left: 50%; transform: translate(-50%, -50%);margin-top:1vh;margin-bottom:1vh" id="track_vehicle" class="btn-confirm">TRACK</button>

     </div>`).fadeIn('slow')
    }
    $(document).on("click","#track_vehicle" , function() {
        let id= $(this).data('id')
        $.post('https://lrp-phone/track-vehicle' , JSON.stringify({
            veh: GarageData[clickedid][0]
        }))
    })
 })

