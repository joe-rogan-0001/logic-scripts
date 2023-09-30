function LoadJobCenter(){
    $.post('https://qb-phone/GetJobCentersJobs', JSON.stringify({}), function(Jobs){
        $(".realjobcenter-list").html("");
        for (const [k, v] of Object.entries(Jobs)) {
            if (v.setjob == false) {
                var AddOption = '<div class="realjobcenter-class-body-job" data-action="1" data-job="'+v.job+'" data-label="'+v.label+'">'+'<div class="realjobcenter-showitems-other"><i data-action="2" data-x="'+v.Coords[0]+'" data-y="'+v.Coords[1]+'" id="realjobcenter-icon-class" class="fas fa-map-marked-alt"></i></div>'+v.label+'</div>'
                $('.realjobcenter-list').append(AddOption);
            } else {
                var AddOption = '<div class="realjobcenter-class-body-job" data-action="1" data-job="'+v.job+'" data-label="'+v.label+'">'+'<div class="realjobcenter-showitems-other"><i data-action="1" data-job="'+v.job+'" data-label="'+v.label+'" id="realjobcenter-icon-class" class="fas fa-check-circle"></i><i data-action="2" data-x="'+v.Coords[0]+'" data-y="'+v.Coords[1]+'" id="realjobcenter-icon-class" class="fas fa-map-marked-alt"></i></div>'+v.label+'</div>'
                $('.realjobcenter-list').append(AddOption);
            }
        }
    });
};

$(document).on('click', '.realjobcenter-class-body-job', function(e){
    e.preventDefault();
    var action = $(this).data('action')
    console.log(action)
    if(action == 1){
        var job = $(this).data('job')
        var label = $(this).data('label')
        $.post('https://qb-phone/CasinoPhoneJobCenter', JSON.stringify({
            action: action,
            job: job,
            label: label,
        }));
    }else if(action == 2){
        var x = $(this).data('x')
        var y = $(this).data('y')
        $.post('https://qb-phone/CasinoPhoneJobCenter', JSON.stringify({
            action: action,
            x: x,
            y: y,
        }));
    }
});