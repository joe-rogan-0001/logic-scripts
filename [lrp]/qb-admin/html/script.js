AdminPanel = {}
AdminPanel.MaxPlayers = 48; // I could pass this data from the server but do I really have to?
AdminPanel.IsOpen = false;
AdminPanel.PlayerList = null;
AdminPanel.ServerInformation = null;
AdminPanel.ConfirmingAction = null;
AdminPanel.ModalOpen = false;
AdminPanel.EditingPlayerInfo = null;
AdminPanel.JobPageInfo = null;
AdminPanel.ResourcePageInfo = null;
AdminPanel.GangPageInfo = null;
AdminPanel.FiringCitizenId = null;
AdminPanel.FiringPlayerName = null;
AdminPanel.BackTo = "playerlist";
AdminPanel.EditingPlayerId = null;
AdminPanel.CurrentAlertClass = null;
AdminPanel.ServerLogs = null;
AdminPanel.DarkModeEnabled = false;
AdminPanel.SeeThroughModeEnabled = false;
AdminPanel.ServerMetrics = null;
AdminPanel.WarningShown = false;
AdminPanel.BansList = null;
AdminPanel.ReportsList = null;
AdminPanel.AdminChat = null;
AdminPanel.AdminChatOpen = false;
AdminPanel.LoadingAdminChat = false;
AdminPanel.CharactersList = null;
AdminPanel.NavDisabled = false;
AdminPanel.ItemsList = null;
AdminPanel.VehiclesList = null;
AdminPanel.ReportScreenOpen = false;
AdminPanel.Version = "Unknown Version";

AdminPanel.Init = function() {
    $(document).ready(function(){
        $(".btn").mouseup(function(){
            $(this).blur();
        });
        Toast.setMaxCount(6);
        Toast.enableTimers(true);
        Toast.setTheme(TOAST_THEME.LIGHT);
        Toast.setPlacement(TOAST_PLACEMENT.BOTTOM_RIGHT);
        $('[data-toggle-second="tooltip"]').tooltip();

        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case "open": {
                    AdminPanel.Open(event.data);
                    break;
                }
                case "close": {
                    AdminPanel.Close();
                    AdminPanel.CloseReportScreen();
                    break;
                }
                case "refresh": {
                    AdminPanel.Refresh(event.data);
                    break;
                }
                case "jobinfo": {
                    AdminPanel.JobPageInfo = event.data.jobinfo;
                    AdminPanel.ResetJobList();
                    break;
                }
                case "resourceinfo": {
                    AdminPanel.ResourcePageInfo = event.data.resourceinfo;
                    AdminPanel.ResetResourceList();
                    break;
                }
                case "ganginfo": {
                    AdminPanel.GangPageInfo = event.data.ganginfo;
                    AdminPanel.ResetGangList();
                    break;
                }
                case "bansinfo": {
                    AdminPanel.BansList = event.data.bansinfo;
                    AdminPanel.ResetBansList();
                    break;
                }
                case "reportsinfo": {
                    AdminPanel.ReportsList = event.data.reportsinfo;
                    AdminPanel.ResetReportsList();
                    break;
                }
                case "adminchat": {
                    AdminPanel.AdminChat = event.data.adminchat;
                    if(AdminPanel.IsOpen && (AdminPanel.LoadingAdminChat || AdminPanel.AdminChatOpen)) {
                        AdminPanel.ResetAdminChat();
                        /*
                        var newMsg = AdminPanel.AdminChat[AdminPanel.AdminChat.length - 1];
                        AdminPanel.ShowAdminChatAlert(`<strong>${newMsg.Sender}</strong>: ${newMsg.Message}`);
                        */
                    } else {
                        var newMsg = AdminPanel.AdminChat[AdminPanel.AdminChat.length - 1];
                        AdminPanel.ShowAdminChatAlert(`<strong>${newMsg.Sender}</strong>: ${newMsg.Message}`);
                    }
                    break;
                }
                case "vehiclesinfo": {
                    AdminPanel.VehiclesList = event.data.vehiclesinfo;
                    AdminPanel.ResetVehiclesList();
                    break;
                }
                case "itemsinfo": {
                    AdminPanel.ItemsList = event.data.itemsinfo;
                    AdminPanel.ResetItemsList();
                    break;
                }
                case "characterslist": {
                    AdminPanel.CharactersList = event.data.characters;
                    AdminPanel.ResetCharactersList();
                    break;
                }
                case "logslist": {
                    AdminPanel.ServerLogs = event.data.logs;
                    AdminPanel.ResetLogViewer();
                    break;
                }
                case "noperms": {
                    AdminPanel.NavDisabled = false;
                    AdminPanel.ResetNav();
                    $("#heading").html("Dashboard");
                    $("#dashboardpagebtn").addClass("active");
        
                    $("#loading").hide();
                    $("#dashboardpage").show();
                    break;
                }
                case "servermetrics": {
                    AdminPanel.ServerMetrics = event.data.metrics;
                    $("#metricsvehiclescount").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.VehicleCount));
                    $("#metricscharactercount").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.CharacterCount));
                    $("#metricsstaffcount").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.StaffCount));
                    $("#metricsbanscount").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.BansCount));
                    $("#metricsunique").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.UniquePlayers));
                    $("#metricscash").html('$'+AdminPanel.NumberWithCommas(Math.trunc(AdminPanel.ServerMetrics.TotalCash)));
                    $("#metricsbank").html('$'+AdminPanel.NumberWithCommas(Math.trunc(AdminPanel.ServerMetrics.TotalBank)));
                    $("#metricsitems").html(AdminPanel.NumberWithCommas(AdminPanel.ServerMetrics.TotalItems));
                    $("#loading").hide();
                    AdminPanel.EnableNav();
                    $("#serverpage").show();
                    break;
                }
                case "clipboard": {
                    AdminPanel.Clipboard(event.data.string);
                    break;
                }
                case "viewonlineplayer": {
                    AdminPanel.ViewOnlinePlayer(event.data.playerid);
                    break;
                }
                case "viewofflineplayer": {
                    AdminPanel.ViewOfflinePlayer(event.data.playerdata);
                    break;
                }
                case "showalert": {
                    AdminPanel.ShowAlert(event.data.type, event.data.text);
                    break;
                }
                case "showreportalert": {
                    AdminPanel.ShowReportAlert(event.data.title, event.data.text);
                    break;
                }
                case "showwarning": {
                    AdminPanel.ShowWarning(event.data.by, event.data.reason);
                    break;
                }
                case "viewwarnings": {
                    AdminPanel.ViewWarnings(event.data.warnings);
                }
                case "reportscreen": {
                    AdminPanel.ShowReportScreen();
                }
                default: {
                    break;
                }
            }
        })
    });
    
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip({
            selector: true,
            placement: "top",
            classes: {
                "ui-tooltip": "float-right"
            },
            title: function() {
                return $(this).attr('title');
            },
        });
    });

    $(document).on('click', '#clearbtn', function(e) {
        $("#playersearch").val('');
        AdminPanel.SearchPlayers();
    });

    $(document).on('click', '#clearbtnres', function(e) {
        $("#resourcesearch").val('');
        AdminPanel.SearchResources();
    });

    $(document).on('click', '#clearbtnch', function(e) {
        $("#charactersearch").val('');
        AdminPanel.SearchCharacters();
    });

    $(document).on('click', '#clearbtnitems', function(e) {
        $("#itemsearch").val('');
        AdminPanel.SearchItems();
    });

    $(document).on('click', '#clearbtnvehs', function(e) {
        $("#vehiclesearch").val('');
        AdminPanel.SearchVehicles();
    });

    $(document).on('click', '#clearbtnlg', function(e) {
        $("#logsearch").val('');
        AdminPanel.SearchLogs();
    });

    $(document).on('click', '#clearbtnban', function(e) {
        $("#bansearch").val('');
        AdminPanel.SearchBans();
    });

    $(document).on('click', '#gangpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Gang List");
            $("#gangpagebtn").addClass("active");

            AdminPanel.PreparePage("gangpage");        
        }
    });
    $(document).on('click', '#dashboardpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Dashboard");
            $("#dashboardpagebtn").addClass("active");

            $("#loading").hide();
            $("#dashboardpage").show();
        }
    });
    $(document).on('click', '#jobpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Job List");
            $("#jobpagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("jobpage");
        }
    });
    $(document).on('click', '#serverpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Server Metrics");
            $("#serverpagebtn").addClass("active");

            $("#loading").show();
            AdminPanel.PreparePage("servermetricspage");
            //$("#serverpage").show();
        }
    });


    $(document).on('click', '#banpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Ban List");
            $("#banpagebtn").addClass("active");

            $("#loading").show();
            AdminPanel.PreparePage("banpage");
        }
    });

    $(document).on('click', '#reportspagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Reports List");
            $("#reportspagebtn").addClass("active");

            $("#loading").show();
            AdminPanel.PreparePage("reportspage");
        }
    });

    $(document).on('click', '#adminchatbtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Admin Chat");
            $("#adminchatbtn").addClass("active");

            $("#loading").show();
            AdminPanel.PreparePage("adminchat");
        }
    });

    $(document).on('click', '#characterspagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("All Characters");
            $("#characterspagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("characters");
        }
    });

    $(document).on('click', '#vehspagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("All Vehicles");
            $("#vehspagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("vehicles");
        }
    });

    $(document).on('click', '#itemspagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("All Items");
            $("#itemspagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("items");
        }
    });

    $(document).on('click', '#logviewerpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Log Viewer");
            $("#logviewerpagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("logviewer");
        }
    });

    $(document).on('click', '#resourcelistpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Resource List");
            $("#resourcelistpagebtn").addClass("active");
            $("#loading").show();

            AdminPanel.PreparePage("resourcelistpage");
        }
    });

    $(document).on('click', '#playerlistpagebtn', function(e) {
        if(!AdminPanel.NavDisabled) {
            AdminPanel.ResetNav();
            $("#heading").html("Player List");
            $("#playerlistpagebtn").addClass("active");

            $("#numplayers").html(AdminPanel.PlayerList.length + " / " + AdminPanel.MaxPlayers + " Players Online");

            if(AdminPanel.EditingPlayerInfo){
                AdminPanel.EditingPlayerInfo = null;
            }
            if(AdminPanel.EditingPlayerId) {
                AdminPanel.EditingPlayerId = null;
            }

            $("#loading").hide();
            $("#playerlistpage").show();
        }
    });

    $(document).on('click', '#joblistfireplayer', function(e) {
        AdminPanel.FiringCitizenId = $(this).data('player');
        bootbox.confirm({ 
            size: "small",
            title: `Are you sure?`,
            message: 'Fire <strong>'+$(this).data('name')+'</strong> from their job?',
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Fire Player',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){
                if(result) {
                    // We're going to use an NUI event seperate from the Action event,
                    // because we want this one to be offline safe
                    $.post(`https://${GetParentResourceName()}/FirePlayerFromJob`, JSON.stringify(AdminPanel.FiringCitizenId));
                }
            }
        })
    });

    $(document).on('click', '#ganglistfireplayer', function(e) {
        AdminPanel.FiringCitizenId = $(this).data('player');
        bootbox.confirm({ 
            size: "small",
            title: `Are you sure?`,
            message: 'Remove <strong>'+$(this).data('name')+'</strong> from their gang?',
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Remove Player',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){
                if(result) {
                    $.post(`https://${GetParentResourceName()}/FirePlayerFromGang`, JSON.stringify(AdminPanel.FiringCitizenId));
                }
            }
        })
    });

    $(document).on('click', '#joblistgotoplayer', function(e) {
        AdminPanel.BackTo = "joblist";
        $.post(`https://${GetParentResourceName()}/RequestViewPlayer`, JSON.stringify($(this).data('player')));
        $("#loading").show();
        AdminPanel.ResetNav();
    });

    $(document).on('click', '#characterslistgotoplayer', function(e) {
        $("#characterspage").hide();
        AdminPanel.BackTo = "characterslist";
        $.post(`https://${GetParentResourceName()}/RequestViewPlayer`, JSON.stringify($(this).data('player')));
        $("#loading").show();
        AdminPanel.ResetNav();
    });

    $(document).on('click', '#characterslistdelete', function(e) {
        var deletingChar = $(this).data('player');
        bootbox.confirm({ 
            size: "small",
            title: `Are you sure?`,
            message: 'Delete '+$(this).data('name')+'?',
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Remove Character',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){
                if(result) {
                    $.post(`https://${GetParentResourceName()}/DeleteCharacter`, JSON.stringify(deletingChar));
                }
            }
        })
    });

    $(document).on('click', '#joblistsetrank', function(e) {
        var SetRankCitizenId = $(this).data('player');
        bootbox.prompt({ 
            title: `Set Job Grade for ${$(this).data('name')}`,
            message: `Job Grade to assign to ${$(this).data('name')}`,
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Set Grade',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){ 
                if (result != null) {
                    $.post(`https://${GetParentResourceName()}/SetJobGrade`, JSON.stringify({ citizenid: SetRankCitizenId, grade: result }));
                }
            }
        });
    });

    $(document).on('click', '#ganglistsetrank', function(e) {
        var SetRankCitizenId = $(this).data('player');
        bootbox.prompt({ 
            title: `Set Gang Grade for ${$(this).data('name')}`,
            message: `Gang Grade to assign to ${$(this).data('name')}`,
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Set Grade',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){ 
                if (result != null) {
                    $.post(`https://${GetParentResourceName()}/SetGangGrade`, JSON.stringify({ citizenid: SetRankCitizenId, grade: result }));
                }
            }
        });
    });

    $(document).on('click', '#ganglistgotoplayer', function(e) {
        AdminPanel.BackTo = "ganglist";
        $.post(`https://${GetParentResourceName()}/RequestViewPlayer`, JSON.stringify($(this).data('player')));
        $("#loading").show();
        AdminPanel.ResetNav();
    });

    $(document).on('click', '#banlistunban', function(e) {
        var UnbanLicense = $(this).data('license');
        bootbox.confirm({ 
            title: `Unban ${$(this).data('name')}?`,
            message: `Are you sure you want to unban ${$(this).data('name')}?`,
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Unban',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){ 
                if (result) {
                    $.post(`https://${GetParentResourceName()}/UnbanPlayer`, JSON.stringify({ license: UnbanLicense }));
                }
            }
        });
    });

    $(document).on('click', '#reportlistdeletereport', function(e) {
        var ReportID = $(this).data('id');
        bootbox.confirm({ 
            title: `Delete Report ID ${$(this).data('id')}?`,
            message: `Are you sure you want to delete Report ID ${$(this).data('id')}?`,
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Delete Report',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){ 
                if (result) {
                    $.post(`https://${GetParentResourceName()}/DeleteReport`, JSON.stringify({ id: ReportID }));
                }
            }
        });
    });

    $(document).on('click', '#reportlistclaimreport', function(e) {
        var ReportID = $(this).data('id');
        bootbox.confirm({ 
            title: `Claim Report ID ${$(this).data('id')}?`,
            message: `Are you sure you want to claim Report ID ${$(this).data('id')}?`,
            centerVertical: true,
            buttons: {
                confirm: {
                    label: 'Claim Report',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancel',
                    className: 'btn-secondary'
                }
            },
            swapButtonOrder: true,
            callback: function(result){ 
                if (result) {
                    $.post(`https://${GetParentResourceName()}/ClaimReport`, JSON.stringify({ id: ReportID }));
                }
            }
        });
    });

    $(document).on('click', '.player', function(e) {
        AdminPanel.EditingPlayerId = $(this).data('id');
        editingplayerindex = $(this).data('playerindex');
        AdminPanel.EditingPlayerInfo = AdminPanel.PlayerList[parseInt(editingplayerindex)]
        $("#onlineactions").show();
        AdminPanel.SetupPlayerInfo();
        AdminPanel.BackTo = "playerlist";
    });

    $(document).on('click', '#reportlistviewplayer', function(e) {
        AdminPanel.BackTo = "reports";
        $.post(`https://${GetParentResourceName()}/RequestViewPlayer`, JSON.stringify($(this).data('player')));
        $("#loading").show();
        AdminPanel.ResetNav();
    });

    $(document).on('click', '#reportlistviewreport', function(e) {
        if(AdminPanel.IsOpen) {
            var reportId = $(this).data('id');
            if(AdminPanel.ReportsList[reportId] != null) {
                $("#reportinfobox").empty();
                $("#reportinfobox").append(`
                    <strong>Reporter:</strong> ${AdminPanel.ReportsList[reportId].SenderName}<br/>
                    <strong>Type:</strong> ${AdminPanel.ReportsList[reportId].Type}<br/>
                    <strong>Subject:</strong> ${AdminPanel.ReportsList[reportId].Subject}<br/>
                    <strong>Info:</strong> ${AdminPanel.ReportsList[reportId].Info}<br/>
                `);
                AdminPanel.ModalOpen = true;
                $("#reportmodal").modal('show');
            }
        }
    });
    
    $(document).on('click', '#goback', function(e) {
        AdminPanel.ResetNav();

        if(AdminPanel.BackTo == "playerlist") {
            $("#heading").html("Player List")
            $("#playerlistpagebtn").addClass("active");
            $("#playerlistpage").show();
        } else if(AdminPanel.BackTo == "joblist") {
            $("#heading").html("Job List")
            $("#jobpagebtn").addClass("active");

            $("#jobpage").show();
        } else if(AdminPanel.BackTo == "ganglist") {
            $("#heading").html("Gang List")
            $("#gangpagebtn").addClass("active");

            $("#gangpage").show();
        } else if(AdminPanel.BackTo == "characterslist") {
            $("#heading").html("All Characters");
            $("#characterspagebtn").addClass("active");

            AdminPanel.PreparePage("characters");
        } else if(AdminPanel.BackTo == "reports") {
            $("#heading").html("Reports List");
            $("#reportspagebtn").addClass("active");

            AdminPanel.PreparePage("reportspage");
        }
        AdminPanel.EditingPlayerId = null;
        AdminPanel.EditingPlayerInfo = null;
    });

    $(document).on('click', '#refresh', function(e) {
        $.post(`https://${GetParentResourceName()}/Refresh`);
    });

    $(document).on('click', '#refreshbtn', function(e) {
        $.post(`https://${GetParentResourceName()}/Refresh`);
    });

    $(document).on('click', '#refreshbansbtn', function(e) {
        $("#banpage").hide();
        $("#loading").show();
        AdminPanel.PreparePage("banpage");
    });

    $(document).on('click', '#refreshjobbtn', function(e) {
        $("#jobpage").hide();
        $("#loading").show();
        AdminPanel.PreparePage("jobpage");
    });

    $(document).on('click', '#refreshreportsbtn', function(e) {
        $("#reportspage").hide();
        $("#loading").show();
        AdminPanel.PreparePage("reportspage");
    });

    $(document).on('click', '#refreshdbbtn', function(e) {
        $("#serverpage").hide();
        $("#loading").show();
        AdminPanel.PreparePage("servermetricspage")
    });

    $(document).on('click', '#adminchatsend', function(e) {
        if($("#adminchattext").val() != "") {
            $.post(`https://${GetParentResourceName()}/AdminChatSend`, JSON.stringify({message: $("#adminchattext").val()}));
            $("#adminchattext").val("");
        }
    });

    $("#adminchattext").keyup(function(event) {
        if (event.keyCode === 13) {
            $("#adminchatsend").click();
        }
    });

    $(document).on('click', '.confirm-yes', function(e) {
        if (AdminPanel.ConfirmingAction.action == "ban") {
            AdminPanel.ConfirmingAction.timeamt = $("#timeamt :selected").val();
            console.log($("#timeamt :selected").val());
            AdminPanel.ConfirmingAction.reason = $("#reason").val();
            if ($("#reason").val() == "" || $("#reason").val().length <= 5) {//
                AdminPanel.ShowAlert("danger", "Please enter a reason longer than 5 characters!");
                return;
            }
        } else if (AdminPanel.ConfirmingAction.action == "setgang") {
            AdminPanel.ConfirmingAction.gangname = $("#gangname").val();
            AdminPanel.ConfirmingAction.ganggrade = $("#ganggrade").val();
            if ($("#gangname").val().length < 1 || $("#ganggrade").val().length < 1) {
                AdminPanel.ShowAlert("danger", "<strong>ERROR:</strong> Please enter a gang name and grade!");
                return;
            }
        } else if (AdminPanel.ConfirmingAction.action == "setjob") {
            AdminPanel.ConfirmingAction.jobname = $("#jobname").val();
            AdminPanel.ConfirmingAction.jobgrade = $("#jobgrade").val();
            if ($("#jobname").val().length < 1 || $("#jobgrade").val().length < 1) {
                AdminPanel.ShowAlert("danger", "<strong>ERROR:</strong> Please enter a job name and grade!");
                return;
            }
        } else if (AdminPanel.ConfirmingAction.action == "giveitem") {
            AdminPanel.ConfirmingAction.itemname = $("#itemname").val();
            AdminPanel.ConfirmingAction.itemamount = $("#itemamount").val();
            if ($("#itemname").val().length < 1 || $("#itemamount").val().length < 1) {
                AdminPanel.ShowAlert("danger", "<strong>ERROR:</strong> Please enter an item name and amount!");
                return;
            }
        } else if (AdminPanel.ConfirmingAction.action == "setcolor") {
            AdminPanel.ConfirmingAction.primarycolor = $("#rgb1").minicolors('rgbObject');
            AdminPanel.ConfirmingAction.secondarycolor = $("#rgb2").minicolors('rgbObject');
        }
        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
        $("#confirm").modal('hide');
        AdminPanel.ModalOpen = false;
    });

    $(document).on('click', '.confirm-no', function(e) {
        $("#confirm").modal('hide');
        AdminPanel.ModalOpen = false;
    });

    $(document).on('click', '.action', function(e) {
        var action = $(this).data('action');
        if(action == null || action.length < 2) { return; }
        AdminPanel.ConfirmingAction = {action: action, id: AdminPanel.EditingPlayerInfo ? AdminPanel.EditingPlayerInfo.id : 0};
        if(action == "clearinv") {
            bootbox.confirm({ 
                title: `Are you sure?`,
                message: 'Clear <strong>'+AdminPanel.EditingPlayerInfo.name+'</strong>\'s inventory?',
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Clear Inventory',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){
                    if(result) {
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            })
        } else if(action == "kick") {               
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>KICK</strong> ${AdminPanel.EditingPlayerInfo.name}? Reason:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Kick Player',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.reason = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "warn") {     
            AdminPanel.ConfirmingAction.citizenid = AdminPanel.EditingPlayerInfo.citizenid     
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>WARN</strong> ${AdminPanel.EditingPlayerInfo.name}? Reason:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Warn Player',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.reason = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "ban") {
            AdminPanel.ConfirmingAction.citizenid = AdminPanel.EditingPlayerInfo.citizenid
            $("#confirm-body").html(`
                <strong>BAN</strong> ${AdminPanel.EditingPlayerInfo.name}?<br/><br/>
                <select class="custom-select" name="timeamt" id="timeamt">
                    <option value="1">1 Hour</option>
                    <option value="2">2 Hours</option>
                    <option value="4">4 Hours</option>
                    <option value="8">8 Hours</option>
                    <option value="12">12 Hours</option>
                    <option value="24">1 Day</option>
                    <option value="48">2 Days</option>
                    <option value="96">4 Days</option>
                    <option value="168">1 Week</option>
                    <option value="9999" style="color:red">Permanent</option>
                </select><br/>
                <input type="text" class="form-control" id="reason" placeholder="Reason">
            `);                   
            $("#confirm").modal('show');
            AdminPanel.ModalOpen = true;
        } else if(action == "givecash") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>GIVE CASH</strong> to ${AdminPanel.EditingPlayerInfo.name}?<br/><br/>Amount:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Give Cash',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.amount = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "removecash") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>REMOVE CASH</strong> from ${AdminPanel.EditingPlayerInfo.name}?<br/><br/>Amount:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Remove Cash',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.amount = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "setpedmodel") {
            bootbox.prompt({ 
                title: `Set Ped Model for ${AdminPanel.EditingPlayerInfo.name}`,
                message: `<strong>MODEL NAME:</strong> (eg. a_c_chop, a_c_deer, mp_m_freemode_01)`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Set Model',
                        className: 'btn-primary'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.model = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "givebank") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>GIVE BANK MONEY</strong> to ${AdminPanel.EditingPlayerInfo.name}?<br/><br/>Amount:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Give Bank',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.amount = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "removebank") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>REMOVE BANK MONEY</strong> from ${AdminPanel.EditingPlayerInfo.name}?<br/><br/>Amount:`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Remove Bank',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.amount = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "setjob") {
            $("#confirm-body").html(`
                <strong>SET JOB</strong> of ${AdminPanel.EditingPlayerInfo.name}?<br/>
                <input type="text" class="form-control" id="jobname" placeholder="Job" style="margin-bottom:5px">
                <input type="text" class="form-control" id="jobgrade" placeholder="Grade">
            `);                   
            $("#confirm").modal('show');
            AdminPanel.ModalOpen = true;
        } else if(action == "setgang") {
            $("#confirm-body").html(`
                <strong>SET GANG</strong> of ${AdminPanel.EditingPlayerInfo.name}?<br/>
                <input type="text" class="form-control" id="gangname" placeholder="Gang" style="margin-bottom:5px">
                <input type="text" class="form-control" id="ganggrade" placeholder="Grade">
            `);                   
            $("#confirm").modal('show');
            AdminPanel.ModalOpen = true;
        } else if(action == "giveitem") {
            $("#confirm-body").html(`
                <strong>GIVE ITEM</strong> to ${AdminPanel.EditingPlayerInfo.name}?<br/>
                <input type="text" class="form-control" id="itemname" placeholder="Item" style="margin-bottom:5px">
                <input type="number" class="form-control" id="itemamount" placeholder="Amount">
            `);                   
            $("#confirm").modal('show');
            AdminPanel.ModalOpen = true;
        } else if(action == "loadipl") {
            bootbox.prompt({ 
                title: `Load IPL`,
                message: `<strong>IPL NAME:</strong> (eg. xm_siloentranceclosed_x17)`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Load IPL',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.ipl = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "unloadipl") {
            bootbox.prompt({ 
                title: `Unload IPL`,
                message: `<strong>IPL NAME:</strong> (eg. xm_siloentranceclosed_x17)`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Unload IPL',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.ipl = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "removegang") {
            bootbox.confirm({ 
                title: `Are you sure?`,
                message: `<strong>REMOVE</strong> ${AdminPanel.EditingPlayerInfo.name} from their gang?`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Remove',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result) {
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "massdv") {
            bootbox.confirm({ 
                title: `Are you sure?`,
                message: `DELETE <strong>ALL</strong> vehicle entities for all players?`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Delete All Vehicles',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result) {
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "massdp") {
            bootbox.confirm({ 
                title: `Are you sure?`,
                message: `DELETE <strong>ALL</strong> ped entities for all players?`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Delete All Peds',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result) {
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "massdo") {
            bootbox.confirm({ 
                title: `Are you sure?`,
                message: `DELETE <strong>ALL</strong> object entities for all players?`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Delete All Objects',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result) {
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "setcolor") {
            $("#confirm-body").html(`
                <strong>SET VEHICLE COLOR</strong><br/>
                <br/>
                <span><strong>RGB Primary</strong></span>
                <input type="text" id="rgb1" value="rgb(0, 0, 0)"><br/>
                <span><strong>RGB Secondary</strong></span>
                <input type="text" id="rgb2" value="rgb(0, 0, 0)">
            `);                   
            $('#rgb1').minicolors({format:'rgb'});
            $('#rgb2').minicolors({format:'rgb'});

            $("#confirm").modal('show');
            AdminPanel.ModalOpen = true;
        } else if(action == "setlivery") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>SET VEHICLE LIVERY</strong><br/>
                          <span><strong>Livery #</strong></span>`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Apply',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.livery = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "spawnvehicle") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>SPAWN VEHICLE</strong><br/>
                          <span><strong>Model Name</strong></span>`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Apply',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.model = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "messageall") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>Send Message to All</strong><br/>
                          <span><strong>Message:</strong></span>`,
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Send',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.message = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "reviveall") {
                bootbox.confirm({ 
                    title: `Are you sure?`,
                    message: `<strong>REVIVE ALL?</strong>`,
                    centerVertical: true,
                    buttons: {
                        confirm: {
                            label: 'Revive All Players',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancel',
                            className: 'btn-secondary'
                        }
                    },
                    swapButtonOrder: true,
                    callback: function(result){ 
                        if (result) {
                            $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                        }
                    }
                });
        } else if(action == "setweather") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>SET WEATHER</strong><br/>
                            <span><strong>Weather Type</strong></span>`,
                inputType: 'select',
                inputOptions: [
                {
                    text: 'Choose one...',
                    value: '',
                },
                {
                    text: 'Extra Sunny',
                    value: 'EXTRASUNNY',
                },
                {
                    text: 'Clear',
                    value: 'CLEAR',
                },
                {
                    text: 'Neutral',
                    value: 'NEUTRAL',
                },
                {
                    text: 'Smog',
                    value: 'SMOG',
                },
                {
                    text: 'Foggy',
                    value: 'FOGGY',
                },
                {
                    text: 'Overcast',
                    value: 'OVERCAST',
                },
                {
                    text: 'Clouds',
                    value: 'CLOUDS',
                },
                {
                    text: 'Clearing',
                    value: 'CLEARING',
                },
                {
                    text: 'Rain',
                    value: 'RAIN',
                },
                {
                    text: 'Thunder',
                    value: 'THUNDER',
                },
                {
                    text: 'Snow',
                    value: 'SNOW',
                },
                {
                    text: 'Blizzard',
                    value: 'BLIZZARD',
                },
                {
                    text: 'Light Snow',
                    value: 'SNOWLIGHT',
                },
                {
                    text: 'Heavy Snow (XMAS)',
                    value: 'XMAS',
                },
                {
                    text: 'Halloween',
                    value: 'HALLOWEEN',
                },
                ],
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Apply',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.weather = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        }  else if(action == "settime") {
            bootbox.prompt({ 
                title: `Are you sure?`,
                message: `<strong>SET TIME</strong><br/>
                            <span><strong>Hour</strong></span>`,
                inputType: 'select',
                inputOptions: [
                {
                    text: 'Choose one...',
                    value: '',
                },
                {
                    text: '0100',
                    value: '1',
                },
                {
                    text: '0200',
                    value: '2',
                },
                {
                    text: '0300',
                    value: '3',
                },
                {
                    text: '0400',
                    value: '4',
                },
                {
                    text: '0500',
                    value: '5',
                },
                {
                    text: '0600',
                    value: '6',
                },
                {
                    text: '0700',
                    value: '7',
                },
                {
                    text: '0800',
                    value: '8',
                },
                {
                    text: '0900',
                    value: '9',
                },
                {
                    text: '1000',
                    value: '10',
                },
                {
                    text: '1100',
                    value: '11',
                },
                {
                    text: '1200',
                    value: '12',
                },
                {
                    text: '1300',
                    value: '13',
                },
                {
                    text: '1400',
                    value: '14',
                },
                {
                    text: '1500',
                    value: '15',
                },
                {
                    text: '1600',
                    value: '16',
                },
                {
                    text: '1700',
                    value: '17',
                },
                {
                    text: '1800',
                    value: '18',
                },
                {
                    text: '1900',
                    value: '19',
                },
                {
                    text: '2000',
                    value: '20',
                },
                {
                    text: '2100',
                    value: '21',
                },
                {
                    text: '2200',
                    value: '22',
                },
                {
                    text: '2300',
                    value: '23',
                },
                {
                    text: '2400',
                    value: '24',
                },
                ],
                centerVertical: true,
                buttons: {
                    confirm: {
                        label: 'Apply',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-secondary'
                    }
                },
                swapButtonOrder: true,
                callback: function(result){ 
                    if (result != null) {
                        AdminPanel.ConfirmingAction.time = result;
                        $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
                    }
                }
            });
        } else if(action == "checkwarn") {     
            AdminPanel.ConfirmingAction.citizenid = AdminPanel.EditingPlayerInfo.citizenid     
            $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
        } else {
            $.post(`https://${GetParentResourceName()}/Action`, JSON.stringify(AdminPanel.ConfirmingAction));
        }
    });

    $(document).on('click', '#hidealert', function(e) {
        $("#pagealert").hide();
    });

    $('.list-group-item').on('click', function() {
        $('.fas', this)
          .toggleClass('fa-chevron-right')
          .toggleClass('fa-chevron-down');
    });

    $(document).on('click', '#startresource', function(e) {
        AdminPanel.PeformResourceAction($(this).data('resource'), 'start');
    });

    $(document).on('click', '#stopresource', function(e) {
        AdminPanel.PeformResourceAction($(this).data('resource'), 'stop');
    });

    $(document).on('click', '#restartresource', function(e) {
        AdminPanel.PeformResourceAction($(this).data('resource'), 'restart');
    });

    $(document).on('click', '#closePanelBtn', function(e) {
        AdminPanel.Close();
    });

    $(document).on('click', '#settingsPanelBtn', function(e) {
        AdminPanel.OpenSettings();
    });

    $(document).on('click', '#reportscreenclose', function(e) {
        AdminPanel.CloseReportScreen();
    });

    document.getElementById('reportform').onsubmit = function() {
        return false;
    };

    $(document).on('click', '#reportsubmit', function(e) {
        if ($("#inputSubject").val() == "" || $("#inputSubject").val().length <= 5) {//
            AdminPanel.ShowAlert("danger", "Please enter a subject longer than 5 characters!");
            return;
        } else {
            //AdminPanel.ShowAlert("success", "Your report was sent to online staff!");
            var reportType = $('input[name=typeoption]:checked', '#reportform').val();
            console.log(reportType);
            $.post(`https://${GetParentResourceName()}/SendReport`, JSON.stringify({subject: escapeHtml($("#inputSubject").val()), info:escapeHtml($("#inputInfo").val()), type:reportType}));
            AdminPanel.CloseReportScreen();
        }
    });

    $('#darkmode').change(function() {
        if($(this).prop('checked')) {
            Toast.setTheme(TOAST_THEME.DARK);
            AdminPanel.DarkModeEnabled = true;
            $("body").removeClass("bootstrap");
            $("body").addClass("bootstrap-dark");
            $("#content-wrapper").css('background-color', '#333');
            $(".card-header").each(function(i, item) {
                $(item).addClass("text-light");
            });
            AdminPanel.ShowAlert("success", "<strong>DARK MODE:</strong> Dark mode enabled!");
            $.post(`https://${GetParentResourceName()}/SaveSetting`, JSON.stringify({setting: "darkmode", value:1}));
        } else {
            Toast.setTheme(TOAST_THEME.LIGHT);
            AdminPanel.DarkModeEnabled = false;
            $("body").removeClass("bootstrap-dark");
            $("body").addClass("bootstrap");
            $("#content-wrapper").css('background-color', 'rgb(248, 249, 252)');
            $(".card-header").each(function(i, item) {
                $(item).removeClass("text-light");
            });
            AdminPanel.ShowAlert("danger", "<strong>DARK MODE:</strong> Dark mode disabled!");
            $.post(`https://${GetParentResourceName()}/SaveSetting`, JSON.stringify({setting: "darkmode", value:0}));
        }
    });

    $('#seethroughmode').change(function() {
        if($(this).prop('checked')) {
            AdminPanel.SeeThroughModeEnabled = true;
            $("#mainbox").fadeTo('fast', 0.9);
            AdminPanel.ShowAlert("success", "<strong>SEE THROUGH MODE:</strong> Decreased opacity enabled!");
            $.post(`https://${GetParentResourceName()}/SaveSetting`, JSON.stringify({setting: "seethrough", value:1}));
        } else {
            AdminPanel.SeeThroughModeEnabled = false;
            $("#mainbox").fadeTo('fast', 1);
            AdminPanel.ShowAlert("danger", "<strong>SEE THROUGH MODE:</strong> Decreased opacity disabled!");
            $.post(`https://${GetParentResourceName()}/SaveSetting`, JSON.stringify({setting: "seethrough", value:0}));
        }
    });
    
    $('#confirm').on('hidden.bs.modal', function () {
        AdminPanel.ModalOpen = false;
    });

    $('#settings').on('hidden.bs.modal', function () {
        AdminPanel.ModalOpen = false;
    });

    $('#warningsmodal').on('hidden.bs.modal', function () {
        AdminPanel.ModalOpen = false;
        setTimeout(() => {
            $('.reportbox').css('display', 'none'); 
        }, 100);
    });

    $('#reportmodal').on('hidden.bs.modal', function () {
        AdminPanel.ModalOpen = false;
    });
    
    $(document).on('keyup', function(e) {
        if (e.key === "Escape" && AdminPanel.IsOpen && !AdminPanel.ModalOpen) { // escape key maps to keycode `27`
            AdminPanel.Close();
        } else if (e.key === "Escape" && AdminPanel.ReportScreenOpen && !AdminPanel.ModalOpen) { // escape key maps to keycode `27`
            AdminPanel.CloseReportScreen();
        }
    });

    var lastKeyUpAt = 0;
    $(document).on('keydown', function(e) {
        if (AdminPanel.WarningShown == true) {
            if(e.key === " ") {
                var keyDownAt = new Date();
                setTimeout(function() {
                    if (+keyDownAt > +lastKeyUpAt) {
                        $('#playerwarning').hide();
                        AdminPanel.WarningShown = false;
                        $.post(`https://${GetParentResourceName()}/ExitWarn`);
                    }
                }, 5000);
            }
        }
    });

    $(document).on('keyup', function() {
        lastKeyUpAt = new Date();
    });
}

AdminPanel.PeformResourceAction = function(resourceName, action) {
    $('[data-toggle="tooltip"], .tooltip').tooltip("hide");
    $("#loading").show();
    $("#resourcelistpage").hide();
    $("#resourcelist").hide();
    $.post(`https://${GetParentResourceName()}/ResourceAction`, JSON.stringify({resource: resourceName, action: action}));
}

AdminPanel.ShowAlert = function(type, alertText) {
    if(type == "error") { type = TOAST_STATUS.DANGER; }
    else if(type == "danger") { type = TOAST_STATUS.DANGER; }
    else if(type == "success") { type = TOAST_STATUS.SUCCESS; }
    else {
        type = TOAST_STATUS.INFO;
    }
    

    Toast.create("919 ADMIN", alertText, type, 3000);
}

AdminPanel.ShowAdminChatAlert = function(msgText) {
    var type = TOAST_STATUS.SUCCESS;
    Toast.create("ADMIN CHAT", msgText, type, 3000);
}

AdminPanel.ShowReportAlert = function(title, msgText) {
    var type = TOAST_STATUS.SUCCESS;
    Toast.create(title, msgText, type, 8000);
}

AdminPanel.SetupPlayerInfo = function() {
    $("#loading").show();
    AdminPanel.ResetNav();
    var gender = AdminPanel.EditingPlayerInfo.gender ? "<span style=\"color:deeppink\"><i class=\"fas fa-venus\"></i> Female</span>" : "<span style=\"color:aqua\"><i class=\"fas fa-mars\"></i> Male</span>";
    var injail = AdminPanel.EditingPlayerInfo.injail ? `<span class="badge badge-danger">Yes</span>` : `<span class="badge badge-success">No</span>`;
    $("#heading").html(AdminPanel.EditingPlayerInfo.name +" ("+AdminPanel.EditingPlayerInfo.charname+") "+(AdminPanel.EditingPlayerId == -1?`<span class="badge badge-danger">OFFLINE</span>`:`<span class="badge badge-success">${AdminPanel.EditingPlayerId}`));
    $("#steamid").html(AdminPanel.EditingPlayerInfo.steamid);
    $("#identifiers").html(AdminPanel.EditingPlayerInfo.identifiers);
    $("#role").html(AdminPanel.EditingPlayerInfo.role);
    $("#cash").html(AdminPanel.EditingPlayerInfo.cash);
    $("#bank").html(AdminPanel.EditingPlayerInfo.bank);
    $("#job").html(AdminPanel.EditingPlayerInfo.job);
    $("#jobboss").html(AdminPanel.EditingPlayerInfo.jobboss);
    $("#citizenid").html(AdminPanel.EditingPlayerInfo.citizenid);
    $("#gender").html(gender);
    $("#nationality").html(AdminPanel.EditingPlayerInfo.nationality);
    $("#hunger").html(parseFloat(AdminPanel.EditingPlayerInfo.hunger).toFixed(2)+"%");
    $("#foodprogress").css('width', parseFloat(AdminPanel.EditingPlayerInfo.hunger).toFixed(2)+"%");
    $("#thirst").html(parseFloat(AdminPanel.EditingPlayerInfo.thirst).toFixed(2)+"%");
    $("#waterprogress").css('width', parseFloat(AdminPanel.EditingPlayerInfo.thirst).toFixed(2)+"%")
    $("#health").html(parseFloat(AdminPanel.EditingPlayerInfo.health).toFixed(2)+"%");
    $("#healthprogress").css('width', parseFloat(AdminPanel.EditingPlayerInfo.health).toFixed(2)+"%");
    $("#armour").html(parseFloat(AdminPanel.EditingPlayerInfo.armor).toFixed(2)+"%");
    $("#armourprogress").css('width', parseFloat(AdminPanel.EditingPlayerInfo.armor).toFixed(2)+"%")
    $("#phoneno").html(AdminPanel.EditingPlayerInfo.phone);
    $("#injail").html(injail);
    $("#rank").html(AdminPanel.EditingPlayerInfo.rank);
    $("#duty").html(AdminPanel.EditingPlayerInfo.duty);
    $("#gang").html(AdminPanel.EditingPlayerInfo.gang);
    $("#gangrank").html(AdminPanel.EditingPlayerInfo.gangrank);
    $("#gangboss").html(AdminPanel.EditingPlayerInfo.gangboss);
    $("#charname").html(AdminPanel.EditingPlayerInfo.charname);
    $("#playerid").html((AdminPanel.EditingPlayerId == -1 ? "OFFLINE" : AdminPanel.EditingPlayerId));
    editingplayer = AdminPanel.EditingPlayerId;
    $("#playerpage").show();
    $("#loading").hide();
}

AdminPanel.ViewOnlinePlayer = function(playerId) {
    AdminPanel.PlayerList.forEach(function (item, index) {
        if(item.id == playerId) {
            $("#onlineactions").show();
            editingplayerindex = index;
            AdminPanel.EditingPlayerId = index;
            AdminPanel.EditingPlayerInfo = AdminPanel.PlayerList[parseInt(editingplayerindex)];
            AdminPanel.SetupPlayerInfo();
        }
    });
}

AdminPanel.Clipboard = function(string) {
    fallbackCopyTextToClipboard(string);
    AdminPanel.ShowAlert("success", "<strong>SUCCESS:</strong> Copied to clipboard!");
}

function fallbackCopyTextToClipboard(text) {
    var textArea = document.createElement("textarea");
    textArea.value = text;
    
    // Avoid scrolling to bottom
    textArea.style.top = "0";
    textArea.style.left = "0";
    textArea.style.position = "fixed";
  
    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();
  
    try {
      var successful = document.execCommand('copy');
      var msg = successful ? 'successful' : 'unsuccessful';
      console.log('Fallback: Copying text command was ' + msg);
    } catch (err) {
      console.error('Fallback: Oops, unable to copy', err);
    }
  
    document.body.removeChild(textArea);
}

AdminPanel.ViewOfflinePlayer = function(playerData) {
    $("#onlineactions").hide();
    editingplayerindex = -1;
    AdminPanel.EditingPlayerId = -1;
    AdminPanel.EditingPlayerInfo = playerData;
    AdminPanel.SetupPlayerInfo();
}

AdminPanel.ResetNav = function() {
    $('[data-toggle="tooltip"], .tooltip').tooltip("hide");
    $("#characterslisttbody").empty();
    $("#gangpagebtn").removeClass("active");
    $("#resourcelistpagebtn").removeClass("active");
    $("#characterspagebtn").removeClass("active");
    $("#dashboardpagebtn").removeClass("active");
    $("#serverpagebtn").removeClass("active");
    $("#logviewerpagebtn").removeClass("active");
    $("#banpagebtn").removeClass("active");
    $("#jobpagebtn").removeClass("active");
    $("#adminchatbtn").removeClass("active");
    $("#reportspagebtn").removeClass("active");
    $("#playerlistpagebtn").removeClass("active");
    $("#vehspagebtn").removeClass("active");
    $("#itemspagebtn").removeClass("active");
    $("#adminchatpagebtn").removeClass("active");
    $("#logviewerpage").hide();
    $("#banpage").hide();
    $("#adminchatpage").hide();
    $("#reportspage").hide();
    $("#gangpage").hide();
    $("#itemspage").hide();
    $("#vehiclespage").hide();
    $("#serverpage").hide();
    $("#dashboardpage").hide();
    $("#playerpage").hide();
    $("#jobpage").hide();
    $("#playerlistpage").hide();
    $("#resourcelistpage").hide();
    $("#characterspage").hide();
    AdminPanel.AdminChatOpen = false;
}

AdminPanel.DisableNav = function() {
    AdminPanel.NavDisabled = true;
}

AdminPanel.EnableNav = function() {
    AdminPanel.NavDisabled = false;
}

AdminPanel.OpenSettings = function() {
    $("#settings").modal('show');
    AdminPanel.ModalOpen = true;
}

AdminPanel.PreparePage = function(pageName) {
    switch(pageName) {
        case "gangpage": {
            $.post(`https://${GetParentResourceName()}/LoadGangInfo`);
            $("#ganglist").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "jobpage": {
            $.post(`https://${GetParentResourceName()}/LoadJobInfo`);
            $("#joblist").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "resourcelistpage": {
            $.post(`https://${GetParentResourceName()}/LoadResourcesInfo`);
            $("#resourcelist").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "servermetricspage": {
            $.post(`https://${GetParentResourceName()}/LoadServerMetrics`);
            $("#serverpage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "banpage": {
            $.post(`https://${GetParentResourceName()}/LoadBansInfo`);
            $("#banpage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "reportspage": {
            $.post(`https://${GetParentResourceName()}/LoadReportsInfo`);
            $("#reportspage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "adminchat": {
            $.post(`https://${GetParentResourceName()}/LoadAdminChat`);
            $("#adminchatpage").hide();
            AdminPanel.LoadingAdminChat = true;
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "logviewer": { 
            $.post(`https://${GetParentResourceName()}/LoadLogs`);
            $("#logspage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "characters": {
            $.post(`https://${GetParentResourceName()}/LoadCharacters`);
            $("#characterspage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "items": {
            $.post(`https://${GetParentResourceName()}/LoadItemsInfo`);
            $("#itemspage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
        case "vehicles": {
            $.post(`https://${GetParentResourceName()}/LoadVehiclesInfo`);
            $("#vehiclespage").hide();
            $("#loading").show();
            AdminPanel.DisableNav();
            break;
        }
    }
}

AdminPanel.ResetJobList = function() {
    $("#joblist").empty();
    for (const [key, value] of Object.entries(AdminPanel.JobPageInfo)) {
        if(key == "unemployed") { continue; }
        $("#joblist").append(`
            <a href="#jobinfo${key}" class="list-group-item" data-toggle="collapse">
                <i class="fas fa-chevron-right"></i> Job: <strong>${key}</strong> - Employees: <strong>${value.length}</strong>
            </a>
        `);

        var string = `
        <ul class="list-group collapse" id="jobinfo${key}">
        `;
        value.forEach(function(item, index) {
            string = string + `
                <li href="#" class="list-group-item"><strong>${item.CharName}</strong> ${item.IsOnline} (CitizenId: <strong>${item.CitizenId}</strong> - Steam: <strong>${item.Name}</strong> - Grade: <strong>${item.Grade.name} - ${item.Grade.level}</strong> - Boss: <strong>${item.IsBoss}</strong>)
                <a href="#" id="joblistgotoplayer" data-player="${item.CitizenId}" data-name="${item.Name} (${item.CharName})" data-toggle="tooltip" title="View Player" class="float-right h4" style="margin-left:10px;"><i class="fas fa-external-link-square-alt"></i></a> 
                <a href="#" id="joblistsetrank" data-player="${item.CitizenId}" data-name="${item.Name} (${item.CharName})" data-toggle="tooltip" title="Set Grade" class="float-right h4" style="margin-left:10px;"><i class="fas fa-user-edit"></i></a> 
                <a href="#" data-name="${item.Name} (${item.CharName})" data-player="${item.CitizenId}" id="joblistfireplayer" data-toggle="tooltip" title="Fire Player" class="float-right h4" style="margin-left:10px;"><i class="fas fa-times-circle"></i></a>
                </li>`;
        });
        string = string + `</ul>`;
        $("#joblist").append(string);
    }
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#jobpage").show();
    $("#joblist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetGangList = function() {
    $("#ganglist").empty();
    for (const [key, value] of Object.entries(AdminPanel.GangPageInfo)) {
        if(key == "none") { continue; }
        $("#ganglist").append(`
            <a href="#ganginfo${key}" class="list-group-item" data-toggle="collapse">
                <i class="fas fa-chevron-right"></i> Gang: <strong>${key}</strong> - Members: <strong>${value.length}</strong>
            </a>
        `);

        var string = `
        <ul class="list-group collapse" id="ganginfo${key}">
        `;
        value.forEach(function(item, index) {
            string = string + `
                <li href="#" class="list-group-item"><strong>${item.CharName}</strong> ${item.IsOnline} (CitizenId: <strong>${item.CitizenId}</strong> - Steam: <strong>${item.Name}</strong> - Grade: <strong>${item.Grade.name} - ${item.Grade.level}</strong> - Boss: <strong>${item.IsBoss}</strong>)
                <a href="#" id="ganglistgotoplayer" data-player="${item.CitizenId}" data-name="${item.Name} (${item.CharName})" data-toggle="tooltip" title="View Player" class="float-right h4" style="margin-left:10px;"><i class="fas fa-external-link-square-alt"></i></a> 
                <a href="#" id="ganglistsetrank" data-player="${item.CitizenId}" data-name="${item.Name} (${item.CharName})" data-toggle="tooltip" title="Set Grade" class="float-right h4" style="margin-left:10px;"><i class="fas fa-user-edit"></i></a> 
                <a href="#" data-name="${item.Name} (${item.CharName})" data-player="${item.CitizenId}" id="ganglistfireplayer" data-toggle="tooltip" title="Fire Player" class="float-right h4" style="margin-left:10px;"><i class="fas fa-times-circle"></i></a>
                </li>`;
        });
        string = string + `</ul>`;
        $("#ganglist").append(string);
    }
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#gangpage").show();
    $("#ganglist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetBansList = function() {
    $("#banslisttbody").empty();
    AdminPanel.BansList.forEach(function(item, index) {
        $("#banslisttbody").append(`
            <tr data-license="${item.License}">
            <th scope="row">${item.ID}</th>
            <td>${item.Name}</td>
            <td>${item.License}</td>
            <td>${item.IP}</td>
            <td>${item.Reason}</td>
            <td>${item.BannedBy}</td>
            <td>${AdminPanel.GetReadableTime(item.Expire)}</td>
            <td>
            <a href="#" id="banlistunban" data-name="${item.Name}" data-license="${item.License}" data-toggle="tooltip" title="Unban Player" class="h4"><i class="fas fa-gavel"></i></a> 
            <td>
            </tr>
        `);
    });
    $("#banslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#banpage").show();
    $("#banslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetReportsList = function() {
    $("#reportslisttbody").empty();
    AdminPanel.ReportsList.forEach(function(item, index) {
        if(item) {
            $("#reportslisttbody").append(`
                <tr data-reportid="${item.ReportID}" ${item.Claimed ? 'style="color:lime"' : 'style="color:red"'}>
                <th scope="row">${item.SenderID}</th>
                <td>${item.SenderName}</td>
                <td>${AdminPanel.TimeSince(parseInt(item.ReportTime))}</td>
                <td>${item.Claimed ? item.Claimed : "Not Claimed"}</td>
                <td>${item.Type}</td>
                <td>${item.Subject}</td>
                <td>${AdminPanel.TruncateLongString(item.Info, 45, true)}</td>
                <td>
                    <a href="#" id="reportlistviewplayer" data-player="${item.SenderCitizenID}" data-toggle="tooltip" title="View Player Info" class="h4"><i class="fas fa-external-link-square-alt"></i></a> 
                    <a href="#" id="reportlistviewreport" data-id="${index}" data-toggle="tooltip" title="View Report Info" class="h4"><i class="fas fa-clipboard-list"></i></a> 
                    <a href="#" id="reportlistclaimreport" data-id="${item.ReportID}" data-toggle="tooltip" title="Claim Report" class="h4"><i class="fas fa-check-circle"></i></a> 
                    <a href="#" id="reportlistdeletereport" data-id="${item.ReportID}" data-toggle="tooltip" title="Delete Report" class="h4"><i class="fas fa-times-circle"></i></a> 
                <td>
                </tr>
            `);
        }
    });
    $("#reportslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#reportspage").show();
    $("#reportslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetAdminChat = function() {
    $("#adminchatboxul").empty();
    AdminPanel.AdminChat.forEach(function(item, index) {
        $("#adminchatboxul").append(`
            <li>
                <strong>${item.Sender}</strong> (${AdminPanel.TimeSince(item.TimeStamp)}): ${item.Message}
            </li>
        `);
    });
    $("#loading").hide();
    $("#adminchatpage").show();
    $("#adminchattext").focus();
    AdminPanel.EnableNav();
    AdminPanel.LoadingAdminChat = false;
    AdminPanel.AdminChatOpen = true;
    $("#adminchatboxul").animate({ scrollTop: $("#adminchatboxul")[0].scrollHeight }, 500);
}

AdminPanel.ResetItemsList = function() {
    $("#itemslisttbody").empty();
    for(const Item in AdminPanel.ItemsList) {
        $("#itemslisttbody").append(`
            <tr>
            <td>${AdminPanel.ItemsList[Item].label}</td>
            <td>${Item}</td>
            <td>${AdminPanel.ItemsList[Item].description}</td>
            <td>${AdminPanel.ItemsList[Item].weight/1000} KG</td>
            </tr>
        `);
    }
    $("#itemslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $("#loading").hide();
    $("#itemspage").show();
    $("#itemslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetVehiclesList = function() {
    $("#vehicleslisttbody").empty();
    for(const Vehicle in AdminPanel.VehiclesList) {
        $("#vehicleslisttbody").append(`
            <tr>
            <td>${Vehicle}</td>
            <td>${AdminPanel.VehiclesList[Vehicle].brand} ${AdminPanel.VehiclesList[Vehicle].name}</td>
            <td>${AdminPanel.VehiclesList[Vehicle].category}</td>
            <td>${AdminPanel.VehiclesList[Vehicle].shop}</td>
            <td>$${AdminPanel.NumberWithCommas(AdminPanel.VehiclesList[Vehicle].price)}</td>
            </tr>
        `);
    }
    $("#vehicleslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $("#loading").hide();
    $("#vehiclespage").show();
    $("#vehicleslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetCharactersList = function() {
    $("#characterslisttbody").empty();
    AdminPanel.CharactersList.forEach(function(item, index) {
        var charInfo = JSON.parse(item.charinfo)
        $("#characterslisttbody").append(`
            <tr data-citizenid="${item.citizenid}">
            <td>${item.name}</td>
            <td>${charInfo.firstname} ${charInfo.lastname}</td>
            <th scope="row">${item.citizenid}</th>
            <td>
            <a href="#" id="characterslistdelete" data-player="${item.citizenid}" data-name="${item.name}'s character '${charInfo.firstname} ${charInfo.lastname}'" data-toggle="tooltip" title="Delete Character" class="h4"><i class="fas fa-user-times"></i></a> 
            <a href="#" id="characterslistgotoplayer" data-player="${item.citizenid}" data-license="${item.License}" data-toggle="tooltip" title="View Player" class="h4"><i class="fas fa-external-link-square-alt"></i></a> 
            <td>
            </tr>
        `);
    });
    $("#characterslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#characterspage").show();
    $("#characterslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetLogViewer = function() {
    $("#logslisttbody").empty();
    Array.from(AdminPanel.ServerLogs).forEach(function(item, index) {
        $("#logslisttbody").append("<tr><td>"+AdminPanel.GetReadableTime(item.time)+"</td><td>" + item.from + "</td><td>"+ AdminPanel.MdToHtml(item.message)+"</td></tr>");
    });
    $("#logslisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        sortOrder: 'descending',
        searchable: false
    });
    $("#loading").hide();
    $("#logviewerpage").show();
    $("#logslist").show();
    AdminPanel.EnableNav();
}

AdminPanel.ResetResourceList = function() {
    $("#resourcelist").empty();
    var string = `<table class="table table-sm" id="resourceinfo">
    <thead>
      <tr>
        <th scope="col">Resource Name</th>
        <th scope="col">Running</th>
        <th scope="col">Actions</th>
      </tr>
    </thead>
    <tbody id="resourcetbody">
      `;
    AdminPanel.ResourcePageInfo.forEach(function(item, index) {
        var isStarted = `<span class="badge bg-danger text-light">STOPPED</span>`;
        if(item[1] == "started") {
            isStarted = `<span class="badge bg-success text-light">STARTED</span>`;
        }
        string = string + `<tr style="border-bottom:1px solid grey;"><td><strong>${item[0]}</strong></td><td>${isStarted}</td>
        <td><a href="#" id="startresource" data-resource="${item[0]}" data-toggle="tooltip" title="Start Resource" class="float-left listactionbutton" style="margin-left:10px;"><i class="fas fa-play-circle"></i></a>
        <a href="#" id="stopresource" data-resource="${item[0]}" data-toggle="tooltip" title="Stop Resource" class="float-left listactionbutton" style="margin-left:10px;"><i class="fas fa-stop-circle"></i></a>
        <a href="#" id="restartresource" data-resource="${item[0]}" data-toggle="tooltip" title="Restart Resource" class="float-left listactionbutton" style="margin-left:10px;"><i class="fas fa-sync-alt"></i></a></td></tr>`;
    });
    string = string + `</tbody></table>`;
    $("#resourcelist").append(string);
    $("#resourceinfo").fancyTable({
         sortColumn:1,
         pagination: true,
         perPage:50,
         searchable: false
    });
    $('[data-toggle="tooltip"]').tooltip({
        selector: true,
        placement: "top",
        classes: {
            "ui-tooltip": "float-right"
        },
        title: function() {
            return $(this).attr('title');
        },
    });
    $("#loading").hide();
    $("#resourcelistpage").show();
    $("#resourcelist").show();
    AdminPanel.EnableNav();
}

AdminPanel.Refresh = function(data) {
    AdminPanel.PlayerList = $.parseJSON(data.playerlist);
    AdminPanel.ServerInformation = data.serverData;
    $("#playersonline").html(AdminPanel.PlayerList.length + " / " + AdminPanel.MaxPlayers);
    $("#numplayers").html(AdminPanel.PlayerList.length + " / " + AdminPanel.MaxPlayers + " Players Online");
    $("#playersonlinebar").css({"width": (AdminPanel.PlayerList.length / AdminPanel.MaxPlayers) * 100});
    $("#charactercount").html(AdminPanel.ServerInformation.CharacterCount);
    $("#staffcount").html(AdminPanel.ServerInformation.StaffCount);
    $("#banscount").html(AdminPanel.ServerInformation.BansCount);
    $("#mainplayerlist2").empty();
    
    AdminPanel.PlayerList.forEach(function (item, index) {
        if(item.role == "god") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:red" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else if(item.role == "admin") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:orange" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else if(item.role == "mod") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:blue" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else {
            $("#mainplayerlist2").append(
                `<tr class="player" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        }
    });

    $("#playerlisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $(".pag").prop({colspan: 4});  // Hack to fix the pagination not having full width

    if(AdminPanel.EditingPlayerInfo && AdminPanel.EditingPlayerId) {
        AdminPanel.EditingPlayerInfo = AdminPanel.PlayerList[parseInt(editingplayerindex)];
        AdminPanel.SetupPlayerInfo();
    }
}

AdminPanel.Open = function(data) {
    $("#loading").hide();
    AdminPanel.EnableNav();

    AdminPanel.SetupModes(data);

    AdminPanel.PlayerList = JSON.parse(data.playerlist);
    AdminPanel.ServerInformation = data.serverData;
    AdminPanel.MaxPlayers = data.maxplayers;
    AdminPanel.Version = data.version;
    $("#919adminversion").html(AdminPanel.Version);
    $("#adminname").html(data.name);
    $("#playersonline").html(AdminPanel.PlayerList.length + " / " + AdminPanel.MaxPlayers);
    $("#playersonlinebar").css({"width": ((AdminPanel.PlayerList.length / AdminPanel.MaxPlayers) * 100)+"%"});
    $("#staffcount").html(AdminPanel.ServerInformation.StaffCount);
    $("#mainplayerlist2").empty();
    AdminPanel.PlayerList.forEach(function (item, index) {
        if(item.role == "god") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:red" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else if(item.role == "admin") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:orange" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else if(item.role == "mod") {
            $("#mainplayerlist2").append(
                `<tr class="player" style="color:blue" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        } else {
            $("#mainplayerlist2").append(
                `<tr class="player" data-playerindex="${index}" data-id="${item.id}"><th scope="row">${item.id}</th><td>${item.name}</td><td>${item.charname}</td><td>${item.steamid}</td></tr>`
            );
        }
    });
    $("#playerlisttable").fancyTable({
        sortColumn:0,
        pagination: true,
        perPage:50,
        searchable: false
    });
    $(".pag").prop({colspan: 4}); // Hack to fix the pagination not having full width
    $("#mainbox").show();
    $("#content-wrapper").show();
    AdminPanel.IsOpen = true;
}

AdminPanel.SetupModes = function(data) {
    if(data.darkmode == 1) {
        if(!AdminPanel.DarkModeEnabled) {
            Toast.setTheme(TOAST_THEME.DARK);
            AdminPanel.DarkModeEnabled = true;
            $("body").removeClass("bootstrap");
            $("body").addClass("bootstrap-dark");
            $("#content-wrapper").css('background-color', '#333');
            $(".card-header").each(function(i, item) {
                $(item).addClass("text-light");
            });
            $('#darkmode').bootstrapToggle('on', true);
        }
    } else if(data.darkmode == 0) {
        if(AdminPanel.DarkModeEnabled) {
            Toast.setTheme(TOAST_THEME.LIGHT);
            AdminPanel.DarkModeEnabled = false;
            $("body").removeClass("bootstrap-dark");
            $("body").addClass("bootstrap");
            $("#content-wrapper").css('background-color', 'rgb(248, 249, 252)');
            $(".card-header").each(function(i, item) {
                $(item).removeClass("text-light");
            });
            $('#darkmode').bootstrapToggle('off', true);
        }
    }

    if(data.seethrough == 1) {
        if(!AdminPanel.SeeThroughModeEnabled) {
            AdminPanel.SeeThroughModeEnabled = true;
            setTimeout(function() {
                $("#mainbox").fadeTo('fast', 0.9);
            }, 100);
            $('#seethroughmode').bootstrapToggle('on', true);
        }
    } else if(data.seethrough == 0) {
        if(AdminPanel.SeeThroughModeEnabled) {
            AdminPanel.SeeThroughModeEnabled = false;
            setTimeout(function() {
                $("#mainbox").fadeTo('fast', 1.0);
            }, 100);
            $('#seethroughmode').bootstrapToggle('off', true);
        }
    }
}

AdminPanel.Close = function() {
    $('[data-toggle="tooltip"], .tooltip').tooltip("hide");
    $("#mainbox").hide();
    $("#content-wrapper").hide();
    $.post(`https://${GetParentResourceName()}/close`);
    AdminPanel.IsOpen = false;
}

AdminPanel.ShowReportScreen = function() {
    AdminPanel.ReportScreenOpen = true;
    $("#reportbox").fadeIn(350);
}

AdminPanel.CloseReportScreen = function() {
    $("#reportbox").fadeOut(350);
    $.post(`https://${GetParentResourceName()}/close`);
    AdminPanel.ReportScreenOpen = false;
}

AdminPanel.ShowWarning = function(warnedBy, reason) {
    if(AdminPanel.IsOpen) {
        $('[data-toggle="tooltip"], .tooltip').tooltip("hide");
        $("#mainbox").hide();
        $("#content-wrapper").hide();
        AdminPanel.IsOpen = false;
    }
    $("#warnadmin").html(warnedBy);
    $("#warnreason").html(reason);
    $("#playerwarning").fadeIn(500);
    AdminPanel.WarningShown = true;
}

AdminPanel.ViewWarnings = function(warnings) {
    if(AdminPanel.IsOpen) {
        $("#warninglistbody").empty();
        warnings.forEach(function (item, index) {
            $("#warninglistbody").append(`
                <tr>
                <th>${index+1}</th>
                <td>${item.reason}</td>
                <td>${item.warnedby}</td>
                <td>${AdminPanel.GetReadableTime(item.warnedtime)}</td>
                </tr>
            `);
        });
        AdminPanel.ModalOpen = true;
        $("#warningsmodal").modal('show');
        setTimeout(() => {
            $('.reportbox').css('display', 'none'); 
        }, 100);
    }
}

AdminPanel.SearchPlayers = function() {
    var filter = $("#playersearch").val().toLowerCase();
    $("#mainplayerlist2 > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchBans = function() {
    var filter = $("#bansearch").val().toLowerCase();
    $("#banslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchItems = function() {
    var filter = $("#itemsearch").val().toLowerCase();
    $("#itemslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchVehicles = function() {
    var filter = $("#vehiclesearch").val().toLowerCase();
    $("#vehicleslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchCharacters = function() {
    var filter = $("#charactersearch").val().toLowerCase();
    $("#characterslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchReports = function() {
    var filter = $("#reportsearch").val().toLowerCase();
    $("#reportslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchLogs = function() {
    var filter = $("#logsearch").val().toLowerCase();
    $("#logslisttbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.SearchResources = function() {
    var filter = $("#resourcesearch").val().toLowerCase();
    $("#resourcetbody > tr").filter(function() {      
        $(this).toggle($(this).text().toLowerCase().indexOf(filter) > -1)
    });
}

AdminPanel.GetReadableTime = function(t) {
    var dt = new Date(0);
    dt.setUTCSeconds(t);
    return dt.toLocaleString("en-US", {timeZone: "America/New_York"});
}

AdminPanel.NumberWithCommas = function(x){
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

AdminPanel.MdToHtml = function(text) {
    var bold = /\*\*(.*?)\*\*/gm;
    var html = text.replace(bold, '<strong>$1</strong>');            
    return html;
}

AdminPanel.TimeSince = function(time) {
    var timeStamp = new Date(parseInt(time) * 1000);
    var now = new Date(),
        secondsPast = ((now.getTime() - timeStamp) / 1000);
    if (secondsPast < 60) {
        return parseInt(secondsPast) + 's ago';
    }
    if (secondsPast < 3600) {
        return parseInt(secondsPast / 60) + 'm ago';
    }
    if (secondsPast <= 86400) {
        return parseInt(secondsPast / 3600) + 'h ago';
    }
    if (secondsPast > 86400) {
        day = timeStamp.getDate();
        month = timeStamp.toDateString().match(/ [a-zA-Z]*/)[0].replace(" ", "");
        year = timeStamp.getFullYear() == now.getFullYear() ? "" : " " + timeStamp.getFullYear();
        return day + " " + month + year;
    }
}

AdminPanel.TruncateLongString = function(str, n, useWordBoundary){
    if (str.length <= n) { return str; }
    const subString = str.substr(0, n-1); // the original check
    return (useWordBoundary 
      ? subString.substr(0, subString.lastIndexOf(" ")) 
      : subString) + "&hellip;";
};

var entityMap = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;',
    '/': '&#x2F;',
    '`': '&#x60;',
    '=': '&#x3D;'
};
  
function escapeHtml (string) {
    return String(string).replace(/[&<>"'`=\/]/g, function (s) {
        return entityMap[s];
    });
}

AdminPanel.Init();