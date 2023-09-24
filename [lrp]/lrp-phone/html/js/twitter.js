var CurrentTwitterTab = "twitter-home"
var HashtagOpen = false;
var MinimumTrending = 100;

$(document).on('click', '.twitter-header-tab', function(e){
    e.preventDefault();

    var PressedTwitterTab = $(this).data('twittertab');
    var PreviousTwitterTabObject = $('.twitter-header').find('[data-twittertab="'+CurrentTwitterTab+'"]');

    if (PressedTwitterTab !== CurrentTwitterTab) {
        $(this).addClass('selected-twitter-header-tab');
        $(PreviousTwitterTabObject).removeClass('selected-twitter-header-tab');

        $("."+CurrentTwitterTab+"-tab").css({"display":"none"});
        $("."+PressedTwitterTab+"-tab").css({"display":"block"});

        if (PressedTwitterTab === "twitter-mentions") {
            $.post('https://lrp-phone/ClearMentions');
        }

        if (PressedTwitterTab == "twitter-home") {
            $.post('https://lrp-phone/GetTweets', JSON.stringify({}), function(Tweets){
                QB.Phone.Notifications.LoadTweets(Tweets);
            });
        }

        CurrentTwitterTab = PressedTwitterTab;

        if (HashtagOpen) {
            event.preventDefault();

            $(".twitter-hashtag-tweets").css({"left": "30vh"});
            $(".twitter-hashtags").css({"left": "0vh"});
            $(".twitter-new-tweet").css({"display":"block"});
            $(".twitter-hashtags").css({"display":"block"});
            HashtagOpen = false;
        }
    } else if (CurrentTwitterTab == "twitter-hashtags" && PressedTwitterTab == "twitter-hashtags") {
        if (HashtagOpen) {
            event.preventDefault();

            $(".twitter-hashtags").css({"display":"block"});
            $(".twitter-hashtag-tweets").animate({
                left: 30+"vh"
            }, 150);
            $(".twitter-hashtags").animate({
                left: 0+"vh"
            }, 150);
            HashtagOpen = false;
        }
    } else if (CurrentTwitterTab == "twitter-home" && PressedTwitterTab == "twitter-home") {
        event.preventDefault();

        $.post('https://lrp-phone/GetTweets', JSON.stringify({}), function(Tweets){
            QB.Phone.Notifications.LoadTweets(Tweets);
        });
    } else if (CurrentTwitterTab == "twitter-mentions" && PressedTwitterTab == "twitter-mentions") {
        event.preventDefault();

        $.post('https://lrp-phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets){
            QB.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
        })
    }
});

$(document).on('click', '#twitter-home', function(e){
    e.preventDefault();

    $('#twat-send-container').show()
    //QB.Phone.Animations.TopSlideDown(".twitter-new-tweet-tab", 450, 0);
});



$("#cancel_twat").click(function() {
    $(".search_input").css(
    {
        "filter": "blur(0px)"
    });
    $("#twat-list").css(
    {
        "filter": "blur(0px)"
    });

    $("#twat-list").css("pointer-events", "visible")
    $('#twat-send-container').hide();
    $("#twat_text").val('');
    $('.word-counter').text('0 / 255');
    
})


$(document).on('click', '#take-pic', function (e) {
    e.preventDefault();
    $.post('https://lrp-phone/TakePhoto', JSON.stringify({}),function(url){
        if(url){
            $('#tweet-new-url').val(url)
        }
    })
    QB.Phone.Functions.Close();
})

QB.Phone.Notifications.LoadTweets = function(Tweets) {
    Tweets = Tweets.reverse();
    if (Tweets !== null && Tweets !== undefined && Tweets !== "" && Tweets.length > 0) {
        $(".twitter-home-tab").html("");
        $.each(Tweets, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = QB.Phone.Functions.FormatTwitterMessage(clean);
            var TimeAgo = moment.utc(Tweet.date).local().fromNow()

            var TwitterHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png"
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            if (Tweet.url == "") {
                let TweetElement = '<div class="twitter-tweet" data-twtmessage="'+TwtMessage+'" data-twturl="'+Tweet.url+'" data-twtcid="'+Tweet.citizenid+'" data-twtid ="'+Tweet.tweetId+'" data-twthandler="@' + TwitterHandle.replace(" ", "_") + '"><div class="tweet-replyperson"><i class="fas fa-reply"></i></div><div class="tweet-reply"><i class="fas fa-retweet"></i></div>' +
                '<div class="tweet-tweeter">'+'<span class="tweet-tweeter">@'+TwitterHandle.replace(" ", "_")+'</span></div>'+
                '<div class="tweet-message">' + TwtMessage + '</div>' +
                    '<div class="tweet-message">' + "" + '</div>' +
                    //'<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '<div class="tweet-message" style="float:right;margin-top: -21px;margin-right: 5px;">'+TimeAgo+'</div>'+
                    '</div>';
                    $(".twitter-home-tab").append(TweetElement);
            } else {
                let TweetElement = '<div class="twitter-tweet" data-twtmessage="'+TwtMessage+'" data-twturl="'+Tweet.url+'" data-twtcid="'+Tweet.citizenid+'" data-twtid ="'+Tweet.tweetId+'" data-twthandler="@' + TwitterHandle.replace(" ", "_") + '"><div class="tweet-replyperson"><i class="fas fa-reply"></i></div><div class="tweet-reply"><i class="fas fa-retweet"></i></div>' +
                    '<div class="tweet-tweeter">'+'<span class="tweet-tweeter">@'+TwitterHandle.replace(" ", "_")+'</span></div>'+
                    '<div class="tweet-message"  data-twtmessage="'+TwtMessage+'">'+TwtMessage+'</div>'+
                    '<img class="image" src= ' + Tweet.url + ' style = " border-radius:4px; width: 70%; position:relative; z-index: 1; left:0px; margin:.6rem .5rem .6rem 1rem;height: auto; padding-bottom: 15px;">' +
                    '<div class="tweet-message" style="float:right;margin-top: -21px;margin-right: 5px;">'+TimeAgo+'</div>'+
                    //'<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div>' +
                    '</div>';
                $(".twitter-home-tab").append(TweetElement);
            }
            
            //if (Tweet.citizenid === QB.Phone.Data.PlayerData.citizenid){
                 //$(".tweet-message").append('<span><div class="twt-icon"><i class="fas fa-trash"style="position:absolute; right:2%; font-size: 1.5rem; z-index:4;" id ="twt-delete-click"></i></div>')
            //}
        });
    }
}

$("#search_twitter").keyup(function() {
    $("#nothing-here").hide()

    var filter = $(this).val(),
        count = 0;
    $('.twitter-tweet').each(function() {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide(); // MY CHANGE
        } else {
            $(this).show(); // MY CHANGE
            count++;
        }
        if (count == 0) {
            $("#nothing-here").show()
        } else {
            $("#nothing-here").hide()

        }

    });

});

$(document).on('click','#twt-delete-click',function(e){
    e.preventDefault();
    let source = $('.twitter-tweet').data('twtid')
    $(this).parent().parent().parent().parent().remove()
    $.post('https://lrp-phone/DeleteTweet', JSON.stringify({id: source}))
})

$(document).on('click', '.tweet-reply', function(e){
    e.preventDefault();
    //console.table(JSON.stringify($(this).parent().data('')))

    $('#tweet-new-url').val("");
    let text = $(this).parent().data('twtmessage');
    let user = $(this).parent().data('twthandler');
    let urls = $(this).parent().data('twturl');

    $("#twat_text").val('RT ' + user + ' ' + text + ' ' + urls);
    $('#twat-send-container').show()
    $('.word-counter').text(('RT ' + user + ' ' + text + ' ' + urls).length + ' / 255');
});

$(document).on('click', '.tweet-replyperson', function(e){
    e.preventDefault();
    //console.table(JSON.stringify($(this).parent().data('')))

    $('#tweet-new-url').val("");
    let text = $(this).parent().data('twtmessage');
    let user = $(this).parent().data('twthandler');
    let urls = $(this).parent().data('twturl');

    $("#twat_text").val(user);
    $('#twat-send-container').show()
    $('.word-counter').text((user).length + ' / 255');
});

QB.Phone.Notifications.LoadMentionedTweets = function(Tweets) {
    Tweets = Tweets.reverse();
    $('#tweet-new-url').val("");
    if (Tweets.length > 0) {
        $(".twitter-mentions-tab").html("");
        $.each(Tweets, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = QB.Phone.Functions.FormatTwitterMessage(clean);
            var TimeAgo = moment(Tweet.date).format('MM/DD/YYYY hh:mm');

            var TwitterHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png";
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            var TweetElement =
            '<div class="twitter-tweet">'+
                '<div class="tweet-tweeter">'+Tweet.firstName+' '+Tweet.lastName+' &nbsp;<span>@'+TwitterHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                '<div class="tweet-message">'+TwtMessage+'</div>'+
            '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div></div>';

            $(".twitter-mentioned-tweet").css({"background-color":"#F5F8FA"});
            $(".twitter-mentions-tab").append(TweetElement);
        });
    }
}

QB.Phone.Functions.FormatTwitterMessage = function(TwitterMessage) {
    var TwtMessage = TwitterMessage;
    var res = TwtMessage.split("@");
    var tags = TwtMessage.split("#");
    var InvalidSymbols = [
        "[",
        "?",
        "!",
        "@",
        "#",
        "]",
    ]

    for(i = 1; i < res.length; i++) {
        var MentionTag = res[i].split(" ")[0];
        if (MentionTag !== null && MentionTag !== undefined && MentionTag !== "") {
            //TwtMessage = TwtMessage.replace("@"+MentionTag, "<span class='mentioned-tag' data-mentiontag='@"+MentionTag+"''>@"+MentionTag+"</span>");
        }
    }

    for(i = 1; i < tags.length; i++) {
        var Hashtag = tags[i].split(" ")[0];

        for(i = 1; i < InvalidSymbols.length; i++){
            var symbol = InvalidSymbols[i];
            var res = Hashtag.indexOf(symbol);

            if (res > -1) {
                Hashtag = Hashtag.replace(symbol, "");
            }
        }

        if (Hashtag !== null && Hashtag !== undefined && Hashtag !== "") {
            //TwtMessage = TwtMessage.replace("#"+Hashtag, "<span class='hashtag-tag-text' data-hashtag='"+Hashtag+"''>#"+Hashtag+"</span>");
        }
    }

    return TwtMessage
}

$(document).on('click', '#send-tweet', function(e){
    e.preventDefault();
    $(".search_input").css(
        {
            "filter": "blur(0px)"
        });
        $("#twat-list").css(
        {
            "filter": "blur(0px)"
        });
        $("#twat-list").css("pointer-events", "visible")

        $('#twat-send-container').hide()
        $('#twat-sent-container').show()
        $("#twat-sent-container").empty()
        $('#twat-sent-container').append('<img style="position: absolute;top: 50%;left: 50%;transform: translate(-50% , -50%);width: 30%;" src="https://c.tenor.com/I6kN-6X7nhAAAAAi/loading-buffering.gif">');

        var TweetMessage = $("#twat_text").val();
        var imageURL = TweetMessage.match(/\b(http|https)?(:\/\/)?(\S*)\.(\w{2,4})(.*)/g);
        TweetMessage = TweetMessage.split(imageURL)[0]
        
        if (imageURL == null) {
            imageURL = ""
        }

        if (TweetMessage == "" && imageURL !="") {
            TweetMessage = " "
        }

        //console.log(TweetMessage)

        if (TweetMessage != "") {
            setTimeout(() => {
                $('#twat-sent-container').html('<img style="position: absolute;top: 50%;left: 50%;transform: translate(-50% , -50%);width: 30%;" src="https://logicrp.com/images/phone/twatloading.gif">');
                setTimeout(() => {
                    $('.word-counter').text('0 / 255');
                    $('#twat-sent-container').hide()            
                        setTimeout(() => {
                                var CurrentDate = new Date();
                                $.post('https://lrp-phone/PostNewTweet', JSON.stringify({
                                    Message: TweetMessage,
                                    Date: CurrentDate,
                                    Picture: QB.Phone.Data.MetaData.profilepicture,
                                    url: imageURL
                                }), function(Tweets){
                                    QB.Phone.Notifications.LoadTweets(Tweets);
                                });
                        }, 500);
                    $("#twat_text").val('');
                }, 1500);
            }, 300);
        } else {
            QB.Phone.Notifications.Add("fab fa-twitter", "Twitter", "Fill a message!", "#1DA1F2");
        };
});

$(document).on('click', '#cancel-tweet', function(e){
    e.preventDefault();
    $('#tweet-new-url').html("");
    QB.Phone.Animations.TopSlideUp(".twitter-new-tweet-tab", 450, -120);
});

$(document).on('click', '.image', function(e){
    e.preventDefault();
    let source = $(this).attr('src')
    $('#twitter-big-png').append(`<img style="width: 20%;" src="${source}">`)
});

$(document).on('click', '.mentioned-tag', function(e){
    e.preventDefault();
    CopyMentionTag(this);
});

$('#twat_text').keyup(function(){
    $('.word-counter').text(this.value.replace(/ /g,'').length+' / 255');
})

$(document).on('click', '.hashtag-tag-text', function(e){
    e.preventDefault();
    if (!HashtagOpen) {
        var Hashtag = $(this).data('hashtag');
        var PreviousTwitterTabObject = $('.twitter-header').find('[data-twittertab="'+CurrentTwitterTab+'"]');

        $("#twitter-hashtags").addClass('selected-twitter-header-tab');
        $(PreviousTwitterTabObject).removeClass('selected-twitter-header-tab');

        $("."+CurrentTwitterTab+"-tab").css({"display":"none"});
        $(".twitter-hashtags-tab").css({"display":"block"});

        $.post('https://lrp-phone/GetHashtagMessages', JSON.stringify({hashtag: Hashtag}), function(HashtagData){
            QB.Phone.Notifications.LoadHashtagMessages(HashtagData.messages);
        });

        $(".twitter-hashtag-tweets").css({"display":"block", "left":"30vh"});
        $(".twitter-hashtag-tweets").css({"left": "0vh"});
        $(".twitter-hashtags").css({"left": "-30vh"});
        $(".twitter-hashtags").css({"display":"none"});
        HashtagOpen = true;

        CurrentTwitterTab = "twitter-hashtags";
    }
});

function CopyMentionTag(elem) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(elem).data('mentiontag')).select();
    QB.Phone.Notifications.Add("fab fa-twitter", "Twitter", $(elem).data('mentiontag')+ " copied!", "rgb(27, 149, 224)", 1250);
    document.execCommand("copy");
    $temp.remove();
}

QB.Phone.Notifications.LoadHashtags = function(hashtags) {
    if (hashtags !== null) {
        $(".twitter-hashtags").html("");

        $.each(hashtags, function(i, hashtag){
            var Elem = '';
            var TweetHandle = "Tweet";
            if (hashtag.messages.length > 1 ) {
               TweetHandle = "Tweets";
            }
            if (hashtag.messages.length >= MinimumTrending) {
                Elem = '<div class="twitter-hashtag" id="tag-'+hashtag.hashtag+'"><div class="twitter-hashtag-status">Trending in City</div> <div class="twitter-hashtag-tag">#'+hashtag.hashtag+'</div> <div class="twitter-hashtag-messages">'+hashtag.messages.length+' '+TweetHandle+'</div> </div>';
            } else {
                Elem = '<div class="twitter-hashtag" id="tag-'+hashtag.hashtag+'"><div class="twitter-hashtag-status">Not trending in City</div> <div class="twitter-hashtag-tag">#'+hashtag.hashtag+'</div> <div class="twitter-hashtag-messages">'+hashtag.messages.length+' '+TweetHandle+'</div> </div>';
            }

            $(".twitter-hashtags").append(Elem);
            $("#tag-"+hashtag.hashtag).data('tagData', hashtag);
        });
    }
}

QB.Phone.Notifications.LoadHashtagMessages = function(Tweets) {
    Tweets = Tweets.reverse();
    if (Tweets !== null && Tweets !== undefined && Tweets !== "" && Tweets.length > 0) {
        $(".twitter-hashtag-tweets").html("");
        $.each(Tweets, function(i, Tweet){
            var clean = DOMPurify.sanitize(Tweet.message , {
                ALLOWED_TAGS: [],
                ALLOWED_ATTR: []
            });
            if (clean == '') clean = 'Hmm, I shouldn\'t be able to do this...'
            var TwtMessage = QB.Phone.Functions.FormatTwitterMessage(clean);
            var TimeAgo = moment(Tweet.date).format('MM/DD/YYYY hh:mm');

            var TwitterHandle = Tweet.firstName + ' ' + Tweet.lastName
            var PictureUrl = "./img/default.png"
            if (Tweet.picture !== "default") {
                PictureUrl = Tweet.picture
            }

            var TweetElement =
            '<div class="twitter-tweet">'+
                '<div class="tweet-tweeter">'+Tweet.firstName+' '+Tweet.lastName+' &nbsp;<span>@'+TwitterHandle.replace(" ", "_")+' &middot; '+TimeAgo+'</span></div>'+
                '<div class="tweet-message">'+TwtMessage+'</div>'+
            '<div class="twt-img" style="top: 1vh;"><img src="'+PictureUrl+'" class="tweeter-image"></div></div>';

            $(".twitter-hashtag-tweets").append(TweetElement);
        });
    }
}


$(document).on('click', '.twitter-hashtag', function(event){
    event.preventDefault();

    var TweetId = $(this).attr('id');
    var TweetData = $("#"+TweetId).data('tagData');

    QB.Phone.Notifications.LoadHashtagMessages(TweetData.messages);

    $(".twitter-hashtag-tweets").css({"display":"block", "left":"30vh"});
    $(".twitter-hashtag-tweets").animate({
        left: 0+"vh"
    }, 150);
    $(".twitter-hashtags").animate({
        left: -30+"vh"
    }, 150, function(){
        $(".twitter-hashtags").css({"display":"none"});
    });
    HashtagOpen = true;
});
